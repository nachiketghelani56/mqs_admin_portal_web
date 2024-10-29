import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';

Widget userIAMWidget() {
  return Row(
    children: [
      Expanded(
        child: Column(
          children: [
            Row(
              children: [
                CustomPrefixButton(
                  prefixIcon: ImageConfig.filter,
                  btnText: StringConfig.dashboard.filter,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      Expanded(child: Container()),
    ],
  );
}
