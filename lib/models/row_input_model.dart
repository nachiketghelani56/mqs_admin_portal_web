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
  factory RowInputModel.fromJson(Map<String, dynamic> json) {
    return RowInputModel(
      dataType: json['dataType'],
      textController: json['textController'],
      selectedBoolean: json['selectedBoolean'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataType': dataType,
      'textController': textController,
      'selectedBoolean': selectedBoolean,
    };
  }
}
