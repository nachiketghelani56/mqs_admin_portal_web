import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseModelExportService{

  FirebaseModelExportService._();

  static final i = FirebaseModelExportService._();

  uploadFileToCSV({required String fileName, required List<List<String>> rows}) async {
    try{
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: fileName,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }
}