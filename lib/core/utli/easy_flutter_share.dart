/* // ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/services.dart';

class Share {
  static const MethodChannel _channel =
      MethodChannel('channel:github.com/orgs/esysberlin/esys-flutter-share');

  /// Sends a text to other apps.
  static void text(String title, String text, String mimeType) {
    final Map argsMap = <String, String>{
      'title': title,
      'text': text,
      'mimeType': mimeType
    };
    _channel.invokeMethod('text', argsMap);
  }

  /* /// Sends a file to other apps.
  static Future<void> file(
      String title, String name, List<int> bytes, String mimeType,
      {String text = ''}) async {
    final Map argsMap = <String, String>{
      'title': title,
      'name': name,
      'mimeType': mimeType,
      'text': text
    };

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$name').create();
    await file.writeAsBytes(bytes);

    _channel.invokeMethod('file', argsMap);
  } */

  /* /// Sends multiple files to other apps.
  static Future<void> files(
      String title, Map<String, List<int>> files, String mimeType,
      {String text = ''}) async {
    final Map argsMap = <String, dynamic>{
      'title': title,
      'names': files.entries.toList().map((x) => x.key).toList(),
      'mimeType': mimeType,
      'text': text
    };

    final tempDir = await getTemporaryDirectory();

    for (final entry in files.entries) {
      final file = await File('${tempDir.path}/${entry.key}').create();
      await file.writeAsBytes(entry.value);
    }

    _channel.invokeMethod('files', argsMap);
  } */
}
 */
