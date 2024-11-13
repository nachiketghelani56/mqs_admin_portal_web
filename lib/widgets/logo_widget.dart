import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget logoWidget({MainAxisSize mainAxisSize = MainAxisSize.max}) {
  return Row(
    mainAxisSize: mainAxisSize,
    children: [
      Image.asset(
        ImageConfig.qStudioLogo,
        width: SizeConfig.size140,
      ),
    ],
  );
}
