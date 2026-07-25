import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';

class ArtColorRow extends StatelessWidget {
  const ArtColorRow({Key? key, required this.colors, this.size = 24, this.onColorTap}) : super(key: key);

  final List<ArtColor> colors;
  final double size;
  final ValueChanged<ArtColor>? onColorTap;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 6,
        runSpacing: 6,
        children: <Widget>[
          for (final ArtColor item in colors)
            GestureDetector(
              onTap: onColorTap != null ? () => onColorTap!(item) : null,
              child: Container(
                key: Key(item.hex),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Color(item.hexAsInt ?? 0x0),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white24),
                ),
              ),
            ),
        ],
      );
}
