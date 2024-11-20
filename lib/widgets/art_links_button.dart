import 'package:flutter/material.dart';
import 'package:museumLovers/domain.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtLinksButton extends StatelessWidget {
  ArtLinksButton({Key? key, required this.links, ArtLinksBrowser? browser})
      : browser = browser ?? _NativeBrowser(),
        super(key: key);

  final ArtLinks links;
  final ArtLinksBrowser browser;

  @override
  Widget build(BuildContext context) => links.url != null
      ? InkWell(
          // borderRadius: BorderRadius.circular(25),
          // type: MaterialType.transparency,
          child: IconButton(
              iconSize: 25,
              onPressed: () => browser.open(links.url!),
              icon: const Icon(Icons.link)),
        )
      : const SizedBox.shrink();
}

abstract class ArtLinksBrowser {
  void open(String url);
}

class _NativeBrowser implements ArtLinksBrowser {
  @override
  void open(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    }
  }
}
