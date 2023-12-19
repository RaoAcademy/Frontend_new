import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SvgPictureUL extends StatelessWidget {
  const SvgPictureUL({
    Key? key,
    required this.asset,
    required this.colorCode,
  }) : super(key: key);
  final String asset;
  final String colorCode;

  @override
  Widget build(BuildContext context) {
    return WebView(
      zoomEnabled: false,
      initialUrl: 'about:blank',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {
        final String svgText = await rootBundle.loadString(asset);
        final String fileText =
            '<html><style>html,body {background: #$colorCode;padding: 0;margin: 0;} svg {width: 100vw; height: 100vh;}</style><body>$svgText</body></html>';
        await webViewController.loadUrl(
          Uri.dataFromString(
            fileText,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ).toString(),
        );
      },
    );
  }
}
