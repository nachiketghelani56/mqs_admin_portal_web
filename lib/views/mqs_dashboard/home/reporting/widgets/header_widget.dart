import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget headerWidget({required String title}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: FontTextStyleConfig.headerTextStyle,
            ),
          ),
        ],
      ),
    ],
  );
}
