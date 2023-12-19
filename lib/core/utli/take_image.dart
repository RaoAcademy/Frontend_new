/* import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rao_academy/core/utli/logger.dart';

Future<Either<Unit, File>> getImage(ImageSource imageSource) async {
  final picker = ImagePicker();

  final pickedFile = await picker.pickImage(source: imageSource);

  if (pickedFile != null) {
    return right(File(pickedFile.path));
  } else {
    logger.d('No image selected.');
  }
  return left(unit);
}
 */
