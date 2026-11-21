import 'package:flutter/material.dart';
import 'package:museumLovers/screens/search_detail_page.dart';

import 'ui_kit.dart';

class ArtMaterialRow extends StatelessWidget {
  const ArtMaterialRow({Key? key, required this.materials}) : super(key: key);

  final List<String> materials;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 6,
        runSpacing: 6,
        children: <Widget>[
          for (final String material in Set<String>.of(materials))
            PillChip(
              key: Key(material),
              label: material,
              dense: true,
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(builder: (BuildContext context) => SearchDetailPage(searchTerm: material)),
              ),
            ),
        ],
      );
}
