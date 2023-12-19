import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// to tap and copy the coupon codes.
void copyToClipboard(BuildContext context, String data) {
  Clipboard.setData(ClipboardData(text: data)).then((_) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Copied to clipboard!')));
  });
}
