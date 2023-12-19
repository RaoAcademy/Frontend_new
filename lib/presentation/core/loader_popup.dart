// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';

class LoaderPopup extends StatelessWidget {
  const LoaderPopup({
    Key? key,
    required this.getValue,
  }) : super(key: key);
  final ValueChanged<BuildContext> getValue;

  @override
  Widget build(BuildContext context) {
    getValue.call(context);
    return const Center(
      child: CurvedCircularProgressIndicator(),
    );
  }
}

Future<void> showLoaderPopup(
    BuildContext context, ValueChanged<BuildContext> getValue) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return LoaderPopup(getValue: getValue);
    },
  );
}
