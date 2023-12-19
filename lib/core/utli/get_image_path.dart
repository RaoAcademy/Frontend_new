import 'dart:developer';

// import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

Future<String> getImagePath(String src) async {
  final imageUrl =
    await storageRef.child("/images/${src.split('/').last.replaceAll(' ', '')}").getDownloadURL();
  // final String imagePath = '${LoopsUrls.baseUrl}/$src';
  log(imageUrl);
  return imageUrl;
}
