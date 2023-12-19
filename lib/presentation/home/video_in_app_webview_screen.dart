import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoInAppWebViewScreen extends StatefulWidget {
  final String videoUrl;
  VideoInAppWebViewScreen({required this.videoUrl});

  @override
  State<VideoInAppWebViewScreen> createState() => _VideoInAppWebViewScreenState();
}

class _VideoInAppWebViewScreenState extends State<VideoInAppWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.videoUrl)),
      ),
    );
  }
}
