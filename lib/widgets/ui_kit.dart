import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:museumLovers/theme.dart';
import 'package:museumLovers/util/image_url.dart';

import 'cached_image.dart';

/// Shared two-column artwork grid geometry, so every grid in the app lines up.
const EdgeInsets kArtGridPadding = EdgeInsets.fromLTRB(16, 8, 16, 24);
const SliverGridDelegate kArtGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 0.74,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
);

class SectionHeader extends StatelessWidget {
  const SectionHeader(
    this.title, {
    super.key,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsets.fromLTRB(16, 22, 8, 10),
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: SizedBox(
          height: 28,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.2),
                ),
              ),
              if (actionLabel != null)
                TextButton(
                  onPressed: onAction,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 28),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  child: Text(actionLabel!),
                ),
            ],
          ),
        ),
      );
}

/// The app's one chip style: filters, suggestions and toggles all use it.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
    this.leading,
    this.locked = false,
    this.dense = false,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Widget? leading;
  final bool locked;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final Color foreground = onTap == null
        ? AppColors.textTertiary
        : selected
            ? AppColors.onAccent
            : AppColors.textPrimary;
    return Material(
      color: selected ? AppColors.accent : AppColors.surfaceHigh,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: dense ? 28 : 34,
          padding: EdgeInsets.only(left: leading != null ? 4 : (dense ? 10 : 14), right: dense ? 10 : 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (leading != null) ...<Widget>[leading!, const SizedBox(width: 8)],
              if (icon != null) ...<Widget>[
                Icon(icon, size: dense ? 13 : 15, color: selected ? foreground : AppColors.textSecondary),
                const SizedBox(width: 6),
              ],
              if (locked) ...<Widget>[
                Icon(Icons.lock_outline, size: 13, color: foreground),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontSize: dense ? 12 : 13,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A horizontally scrolling row of [PillChip]s with consistent insets.
class ChipRail extends StatelessWidget {
  const ChipRail({super.key, required this.children, this.padding = const EdgeInsets.symmetric(horizontal: 16)});

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 34,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding,
          itemCount: children.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
          itemBuilder: (BuildContext context, int index) => children[index],
        ),
      );
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap, this.color});

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) => Material(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: onTap, child: Padding(padding: padding, child: child)),
      );
}

/// Translucent round button for controls laid over artwork.
class OverlayIconButton extends StatelessWidget {
  const OverlayIconButton({super.key, required this.icon, required this.onPressed, this.tooltip, this.size = 40});

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Widget button = Material(
      color: AppColors.scrim,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox.square(dimension: size, child: Icon(icon, size: size * 0.48, color: Colors.white)),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip, child: button);
  }
}

/// Small circle with someone's initials, used for artist suggestions.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.name, {super.key, this.size = 26});

  final String name;
  final double size;

  /// First and last name ("Vincent van Gogh" → "VG"), skipping particles.
  String get _initials {
    final List<String> parts = name.split(RegExp(r'\s+')).where((String part) => part.isNotEmpty).toList();
    if (parts.isEmpty) {
      return '?';
    }
    final String first = parts.first[0];
    return parts.length == 1 ? first.toUpperCase() : '$first${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.16), shape: BoxShape.circle),
        child: Text(
          _initials,
          style: TextStyle(color: AppColors.accent, fontSize: size * 0.38, fontWeight: FontWeight.w700),
        ),
      );
}

/// Portrait thumbnail with title and maker underneath, for horizontal rails.
class ArtThumbnail extends StatelessWidget {
  const ArtThumbnail({super.key, required this.art, required this.onTap, this.width = 108});

  final Art art;
  final VoidCallback onTap;
  final double width;

  static double heightFor(double width) => width * 1.25 + 40;

  @override
  Widget build(BuildContext context) {
    final String? url = art.webImage?.url;
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: width,
                height: width * 1.25,
                color: AppColors.surface,
                child: url == null
                    ? const Icon(Icons.image_not_supported_outlined, color: AppColors.textTertiary)
                    // Rendered at ~108 logical px, so a 300px source is plenty.
                    : CachedImage(url: artImageUrl(url, 300), memCacheWidth: 300),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              art.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
            Text(
              art.principalOrFirstMaker,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5, color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtRail extends StatelessWidget {
  const ArtRail({super.key, required this.arts, required this.onTap, this.padding = const EdgeInsets.symmetric(horizontal: 16)});

  final List<Art> arts;
  final ValueChanged<Art> onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: ArtThumbnail.heightFor(108),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding,
          itemCount: arts.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12),
          itemBuilder: (BuildContext context, int index) =>
              ArtThumbnail(art: arts[index], onTap: () => onTap(arts[index])),
        ),
      );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.message, this.action});

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                child: Icon(icon, size: 28, color: AppColors.textTertiary),
              ),
              const SizedBox(height: 16),
              Text(title,
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
              ),
              if (action != null) ...<Widget>[const SizedBox(height: 16), action!],
            ],
          ),
        ),
      );
}

/// Long museum texts collapse to a few lines with a "Read more" toggle.
class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text, {super.key});

  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  static const int _collapsedLines = 6;
  static const TextStyle _style = TextStyle(fontSize: 15, height: 1.55, color: Color(0xe0ffffff));

  bool _expanded = false;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final TextPainter painter = TextPainter(
            text: TextSpan(text: widget.text, style: _style),
            maxLines: _collapsedLines,
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
          )..layout(maxWidth: constraints.maxWidth);
          final bool overflows = painter.didExceedMaxLines;
          painter.dispose();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.text,
                style: _style,
                maxLines: _expanded ? null : _collapsedLines,
                overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (overflows)
                TextButton(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(_expanded ? 'Show less' : 'Read more'),
                ),
            ],
          );
        },
      );
}
