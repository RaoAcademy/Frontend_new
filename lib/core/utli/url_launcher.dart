import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url,
    {bool? forceSafariVC,
    bool? forceExternalApp,
    bool? forceWebView,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    LaunchMode? mode,
    String? webOnlyWindowName}) async {
  if (forceWebView != null && (forceWebView == forceExternalApp)) {
    throw 'Either inside App as webView or External App, Can not be both.';
  }
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      mode: (forceWebView ?? false)
          ? LaunchMode.inAppWebView
          : (forceExternalApp ?? false)
              ? LaunchMode.externalApplication
              : mode ?? LaunchMode.platformDefault,
      webViewConfiguration: webViewConfiguration,
      webOnlyWindowName: webOnlyWindowName,
    );
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> dialNumber(String contactNumber) async {
  final String url = 'tel:$contactNumber';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not call $contactNumber';
  }
}
