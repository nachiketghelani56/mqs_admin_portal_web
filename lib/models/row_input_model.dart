import 'package:flutter/material.dart';

class RowInputModel {
  String dataType;
  TextEditingController textController;
  String? selectedBoolean;

  RowInputModel({
    required this.dataType,
    required this.textController,
    this.selectedBoolean,
  });
}
