import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class FirebaseModelImportService {

  FirebaseModelImportService._();

  static final i = FirebaseModelImportService._();

  Future<List<List<dynamic>>> importCSV() async {
    List<List<dynamic>> isValue = [];
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['csv']);
      if(result == null){
        return isValue;
      } else {
        final csvData = utf8.decode(result.files.first.bytes ?? []);
        return const CsvToListConverter().convert(csvData);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally{}
    return isValue;
  }
}