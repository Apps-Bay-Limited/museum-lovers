import 'package:flutter/material.dart';
import 'package:museumLovers/screens/search_detail_page.dart';

class ArtMaterialRow extends StatelessWidget {
  const ArtMaterialRow({Key? key, required this.materials}) : super(key: key);

  final List<String> materials;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Wrap(
      spacing: 4,
      children: <Widget>[
        for (final String material in Set<String>.of(materials))
          InkWell(
            child: Chip(
                key: Key(material),
                label: Text(
                  material,
                  style: const TextStyle(color: Color(0xffD2FCAC)),
                ),
                labelStyle: textTheme.bodyText1),
            onTap: () {
              Navigator.of(context).push<void>(MaterialPageRoute<void>(
                  builder: (BuildContext context) => SearchDetailPage(
                        searchTerm: material,
                      )));
            },
          ),
      ],
    );
  }
}
