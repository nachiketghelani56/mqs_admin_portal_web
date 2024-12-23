import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';

Widget keyValueWrapperWidget(
    {required String key,
    String value = "",
    bool isImage = false,
    bool isFirst = false,
    isLast = false,
    Widget? widget,
    child,
    Function? onTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
    decoration: isFirst
        ? FontTextStyleConfig.headerDecoration
        : FontTextStyleConfig.contentDecoration.copyWith(
            borderRadius: isLast
                ? const BorderRadius.vertical(
                    bottom: Radius.circular(SizeConfig.size12),
                  )
                : null,
          ),
    child: Column(
      children: [
        onTap != null
            ? keyValueRowWidget(isImage, value, key, widget).tap(() {
                onTap();
              })
            : keyValueRowWidget(isImage, value, key, widget),
        if (child != null) child
      ],
    ),
  );
}
