import 'package:fluttertoast/fluttertoast.dart';

void showErrorToast(Object e) {
  Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
}
