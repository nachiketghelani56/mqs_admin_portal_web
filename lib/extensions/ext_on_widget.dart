import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/color_config.dart';

extension ExtOnWidget on Widget {
  Widget tap(Function onTap) => InkWell(
        onTap: () {
          onTap();
        },
        child: this,
      );
  Widget hoverTap(Function onTap) => InkWell(
        onTap: () {
          onTap();
        },
        overlayColor:
            const WidgetStatePropertyAll(ColorConfig.transparentColor),
        hoverColor: ColorConfig.transparentColor,
        child: this,
      );

  Widget get center => Center(child: this);
  Widget get centerRight =>
      Align(alignment: Alignment.centerRight, child: this);
  Widget get centerLeft => Align(alignment: Alignment.centerLeft, child: this);
}
