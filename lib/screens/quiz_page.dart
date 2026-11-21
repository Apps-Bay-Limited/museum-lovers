import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/provider.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_url.dart';
import 'package:museumLovers/widgets.dart';

import 'detail_full_page.dart';
import 'premium_page.dart';

/// "Guess the painting" — shows a zoomed-in IIIF crop of a Top 1000
/// masterpiece and asks the player to pick its title from 4 options.
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

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

enum _QuizSource { masterpieces, favorites }

class _QuizPageState extends State<QuizPage> {
  final Random _random = Random();

  _Phase _phase = _Phase.loading;
  List<_QuizQuestion> _questions = <_QuizQuestion>[];
  int _index = 0;
  int _score = 0;
  int? _selectedChoice;
  _QuizSource _source = _QuizSource.masterpieces;

  @override
  void initState() {
    super.initState();
    // _loadQuiz reads inherited widgets (the store and repository), which
    // isn't allowed until initState has returned.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadQuiz();
      }
    });
  }

  bool get _canUseFavorites =>
      context.appStore.favorites.where((Art art) => art.webImage?.url != null).length >= QuizPage.choiceCount;

  Future<void> _onSourceSelected(_QuizSource source) async {
    if (source == _source) {
      return;
    }
    if (source == _QuizSource.favorites && !await ensurePremium(context)) {
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() => _source = source);
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    // Read everything from `context` before the first `await` below.
    final List<Art> favorites = context.appStore.favorites;
    setState(() => _phase = _Phase.loading);
    try {
      final List<Art> pool = (_source == _QuizSource.favorites
              ? favorites
              : await context.repository.fetchAll(page: 1, masterpieces: true))
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
      context.appStore.recordQuizResult(score: _score, total: _questions.length);
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
        appBar: AppBar(title: const Text('Art quiz')),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              if (_phase != _Phase.playing) _buildSourceSelector(context),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      );

  Widget _buildSourceSelector(BuildContext context) {
    final bool canUseFavorites = _canUseFavorites;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: ChipRail(
        children: <Widget>[
          PillChip(
            label: 'Masterpieces',
            icon: Icons.auto_awesome_outlined,
            selected: _source == _QuizSource.masterpieces,
            onTap: () => _onSourceSelected(_QuizSource.masterpieces),
          ),
          PillChip(
            label: 'My favorites',
            icon: context.appStore.isPremium ? Icons.favorite_outline_rounded : null,
            selected: _source == _QuizSource.favorites,
            locked: !context.appStore.isPremium,
            onTap: canUseFavorites ? () => _onSourceSelected(_QuizSource.favorites) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (_phase) {
      case _Phase.loading:
        return const LoadingSpinner();
      case _Phase.error:
        return Center(
          child: ErrorDisplayView(
            message: _source == _QuizSource.favorites
                ? 'Favorite at least ${QuizPage.choiceCount} artworks with images to play this mode.'
                : 'Could not load the quiz :(',
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
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.score,
    required this.selectedChoice,
    required this.onSelect,
    required this.onNext,
  });

  final _QuizQuestion question;
  final int questionNumber;
  final int totalQuestions;
  final int score;
  final int? selectedChoice;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final bool answered = selectedChoice != null;
    final int correctIndex = question.choices.indexWhere((Art a) => a.id == question.answer.id);
    final double imageHeight = min(MediaQuery.sizeOf(context).width - 32, MediaQuery.sizeOf(context).height * 0.36);

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    for (int i = 1; i <= totalQuestions; i++) ...<Widget>[
                      if (i > 1) const SizedBox(width: 4),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 4,
                          decoration: BoxDecoration(
                            color: i <= questionNumber ? AppColors.accent : AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: const ShapeDecoration(color: AppColors.surfaceHigh, shape: StadiumBorder()),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.star_rounded, size: 14, color: AppColors.accent),
                          const SizedBox(width: 4),
                          Text('$score', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Question $questionNumber of $totalQuestions',
                    style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                const SizedBox(height: 4),
                Text('Which artwork is this detail from?', style: displayStyle(20)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.push<dynamic>(
                    context,
                    CupertinoPageRoute<dynamic>(builder: (_) => Detail(link: question.cropUrl)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: imageHeight,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Hero(
                            tag: question.cropUrl,
                            child: ColoredBox(
                              color: AppColors.surface,
                              child: CachedImage(url: question.cropUrl, fit: BoxFit.cover),
                            ),
                          ),
                          const Positioned(
                            right: 10,
                            bottom: 10,
                            child: IgnorePointer(
                              child: OverlayIconButton(icon: Icons.zoom_in_rounded, onPressed: null, size: 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                for (int index = 0; index < question.choices.length; index++) ...<Widget>[
                  if (index > 0) const SizedBox(height: 8),
                  _ChoiceTile(
                    letter: String.fromCharCode(65 + index),
                    title: question.choices[index].title,
                    state: !answered
                        ? _ChoiceState.idle
                        : index == correctIndex
                            ? _ChoiceState.correct
                            : index == selectedChoice
                                ? _ChoiceState.wrong
                                : _ChoiceState.dimmed,
                    onTap: answered ? null : () => onSelect(index),
                  ),
                ],
                if (answered) ...<Widget>[
                  const SizedBox(height: 12),
                  Text(
                    '${question.answer.title} — ${question.answer.principalOrFirstMaker}',
                    style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: answered
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: onNext,
                      child: Text(questionNumber == totalQuestions ? 'See results' : 'Next question'),
                    ),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

enum _ChoiceState { idle, correct, wrong, dimmed }

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({required this.letter, required this.title, required this.state, required this.onTap});

  static const Color _green = Color(0xff7ddf8b);
  static const Color _red = Color(0xffff8a80);

  final String letter;
  final String title;
  final _ChoiceState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color? tint = switch (state) {
      _ChoiceState.correct => _green,
      _ChoiceState.wrong => _red,
      _ => null,
    };
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: state == _ChoiceState.dimmed ? 0.5 : 1,
      child: Material(
        color: tint?.withValues(alpha: 0.14) ?? AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: tint ?? Colors.transparent, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: tint ?? AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: tint == null
                      ? Text(letter, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))
                      : Icon(
                          state == _ChoiceState.correct ? Icons.check_rounded : Icons.close_rounded,
                          size: 18,
                          color: AppColors.onAccent,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.5, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.score, required this.total, required this.onPlayAgain});

  final int score;
  final int total;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    final ({int score, int total})? best = context.appStore.quizBestResult;
    final bool isBest = best != null && best.score == score && best.total == total;
    final double ratio = total == 0 ? 0 : score / total;
    final String message = isBest
        ? 'New best score!'
        : ratio >= 0.8
            ? 'A true connoisseur.'
            : ratio >= 0.4
                ? 'Nice eye!'
                : 'Keep looking — it gets easier.';
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.14), shape: BoxShape.circle),
              child: const Icon(Icons.emoji_events_rounded, size: 42, color: AppColors.accent),
            ),
            const SizedBox(height: 18),
            Text('$score / $total', style: displayStyle(44)),
            const SizedBox(height: 6),
            Text(message, style: const TextStyle(fontSize: 15, color: AppColors.textSecondary)),
            if (best != null) ...<Widget>[
              const SizedBox(height: 22),
              SurfaceCard(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: <Widget>[
                    Expanded(child: _Stat(value: '${best.score} / ${best.total}', label: 'Best score')),
                    Container(width: 1, height: 32, color: AppColors.hairline),
                    Expanded(child: _Stat(value: '${context.appStore.quizGamesPlayed}', label: 'Games played')),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: onPlayAgain,
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Play again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
        ],
      );
}
