import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget teamConnectionWidget() {
  return Container(
    height: SizeConfig.size444,
    decoration: FontTextStyleConfig.cardDecoration,
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size27, vertical: SizeConfig.size24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.teamChart.teamConnection,
          style: FontTextStyleConfig.chartTitleTextStyle,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  ImageConfig.connect,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
