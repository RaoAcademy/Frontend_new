import 'dart:io';

// import 'package:rao_academy/core/utli/logger.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        /* logger.i(host);
        logger.i(cert);
        logger.i(port); */
        return true;
      };
  }
}
