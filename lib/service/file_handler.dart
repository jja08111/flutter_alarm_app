import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class FileHandler<T> {
  String get fileName;

  T parse(dynamic jsonObject);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> write(T object) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(object));
  }

  Future<T?> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return parse(jsonDecode(contents));
    } catch (e) {
      return null;
    }
  }
}
