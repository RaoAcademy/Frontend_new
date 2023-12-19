import 'package:fluttertoast/fluttertoast.dart';
import 'package:rao_academy/core/utli/logger.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

Future<void> handleError(Object? error) async {
  await Fluttertoast.showToast(
    msg: error.toString(),
    textColor: LoopsColors.colorRed,
    backgroundColor: LoopsColors.tertiaryColor,
    toastLength: Toast.LENGTH_LONG,
  );
  logger.e(error);
}
