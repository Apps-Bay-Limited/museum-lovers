import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/constants.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

import 'detail_full_page.dart';

/// "Guess the painting" — shows a zoomed-in IIIF crop of a Top 1000
/// masterpiece and asks the player to pick its title from 4 options.
class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  static const int questionCount = 5;
  static const int choiceCount = 4;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizQuestion {
  _QuizQuestion({required this.answer, required this.choices, required this.cropUrl});

  final Art answer;
  final List<Art> choices;
  final String cropUrl;
}

enum _Phase { loading, error, playing, finished }

class _QuizPageState extends State<QuizPage> {
  final Random _random = Random();

  _Phase _phase = _Phase.loading;
  List<_QuizQuestion> _questions = <_QuizQuestion>[];
  int _index = 0;
  int _score = 0;
  int? _selectedChoice;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    setState(() => _phase = _Phase.loading);
    try {
      final List<Art> pool = (await context.repository.fetchAll(page: 1, masterpieces: true))
          .where((Art art) => art.webImage?.url != null)
          .toList()
        ..shuffle(_random);
      if (pool.length < QuizPage.choiceCount) {
        setState(() => _phase = _Phase.error);
        return;
      }
      final int questionCount = min(QuizPage.questionCount, pool.length);
      final List<_QuizQuestion> questions = <_QuizQuestion>[
        for (int i = 0; i < questionCount; i++) _buildQuestion(pool, i),
      ];
      if (!mounted) {
        return;
      }
      setState(() {
        _questions = questions;
        _index = 0;
        _score = 0;
        _selectedChoice = null;
        _phase = _Phase.playing;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _phase = _Phase.error);
      }
    }
  }

  _QuizQuestion _buildQuestion(List<Art> pool, int answerIndex) {
    final Art answer = pool[answerIndex];
    final List<Art> decoyPool = <Art>[...pool]..removeAt(answerIndex);
    decoyPool.shuffle(_random);
    final List<Art> choices = <Art>[answer, ...decoyPool.take(QuizPage.choiceCount - 1)]..shuffle(_random);

    const double windowPct = 22;
    final double x = _random.nextDouble() * (100 - windowPct);
    final double y = _random.nextDouble() * (100 - windowPct);
    final String cropUrl = artImageRegionUrl(
      answer.webImage!.url!,
      xPct: x,
      yPct: y,
      wPct: windowPct,
      hPct: windowPct,
      size: 700,
    );
    return _QuizQuestion(answer: answer, choices: choices, cropUrl: cropUrl);
  }

  void _selectChoice(int choiceIndex) {
    if (_selectedChoice != null) {
      return;
    }
    final _QuizQuestion question = _questions[_index];
    final bool correct = question.choices[choiceIndex].id == question.answer.id;
    setState(() {
      _selectedChoice = choiceIndex;
      if (correct) {
        _score++;
      }
    });
  }

  void _next() {
    if (_index + 1 >= _questions.length) {
      setState(() => _phase = _Phase.finished);
      return;
    }
    setState(() {
      _index++;
      _selectedChoice = null;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff141213),
        appBar: AppBar(
          backgroundColor: const Color(0xff141213),
          title: const Text('Art quiz'),
        ),
        body: SafeArea(child: _buildBody(context)),
      );

  Widget _buildBody(BuildContext context) {
    switch (_phase) {
      case _Phase.loading:
        return const LoadingSpinner();
      case _Phase.error:
        return Center(
          child: ErrorDisplayView(
            message: 'Could not load the quiz :(',
            onRetry: _loadQuiz,
          ),
        );
      case _Phase.finished:
        return _ResultView(score: _score, total: _questions.length, onPlayAgain: _loadQuiz);
      case _Phase.playing:
        return _QuestionView(
          question: _questions[_index],
          questionNumber: _index + 1,
          totalQuestions: _questions.length,
          score: _score,
          selectedChoice: _selectedChoice,
          onSelect: _selectChoice,
          onNext: _next,
        );
    }
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    Key? key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.score,
    required this.selectedChoice,
    required this.onSelect,
    required this.onNext,
  }) : super(key: key);

  final _QuizQuestion question;
  final int questionNumber;
  final int totalQuestions;
  final int score;
  final int? selectedChoice;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool answered = selectedChoice != null;
    final int correctIndex =
        question.choices.indexWhere((Art a) => a.id == question.answer.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Question $questionNumber / $totalQuestions', style: theme.textTheme.bodyMedium),
              Text('Score: $score', style: theme.textTheme.bodyMedium),
            ],
          ),
          AppSpacing.v12,
          const Text('Whose detail is this?', style: TextStyle(color: Colors.white60)),
          AppSpacing.v8,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () => Navigator.push<dynamic>(
                context,
                CupertinoPageRoute<dynamic>(builder: (_) => Detail(link: question.cropUrl)),
              ),
              child: Hero(
                tag: question.cropUrl,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColoredBox(
                    color: Colors.black26,
                    child: CachedImage(url: question.cropUrl, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.v16,
          for (int index = 0; index < question.choices.length; index++) ...<Widget>[
            if (index > 0) AppSpacing.v8,
            Builder(builder: (BuildContext context) {
              final Art choice = question.choices[index];
              final bool isCorrect = index == correctIndex;
              final bool isSelected = index == selectedChoice;
              Color background = Colors.white10;
              if (answered && isCorrect) {
                background = Colors.green.withValues(alpha: 0.35);
              } else if (answered && isSelected) {
                background = Colors.red.withValues(alpha: 0.35);
              }
              return Material(
                color: background,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: answered ? null : () => onSelect(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Text(choice.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                ),
              );
            }),
          ],
          if (answered) ...<Widget>[
            AppSpacing.v8,
            Text(
              '${question.answer.title} — ${question.answer.principalOrFirstMaker}',
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
            ),
            AppSpacing.v12,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onNext,
                child: Text(questionNumber == totalQuestions ? 'See results' : 'Next'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({Key? key, required this.score, required this.total, required this.onPlayAgain})
      : super(key: key);

  final int score;
  final int total;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.emoji_events_outlined, size: 64, color: Color(0xffD2FCAC)),
          AppSpacing.v16,
          Text('$score / $total', style: theme.textTheme.headlineMedium),
          AppSpacing.v8,
          Text('Nice eye!', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white60)),
          AppSpacing.v24,
          FilledButton(onPressed: onPlayAgain, child: const Text('Play again')),
        ],
      ),
    );
  }
}
