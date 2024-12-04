import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget keyValueRowWidget(
    {required String key,
    required String value,
    bool isImage = false,
    bool isFirst = false,
    isLast = false}) {
  return Container(
    // height: SizeConfig.size55,
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
    child: Row(
      children: isImage && value.isNotEmpty
          ? [
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  key,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Flexible(
                flex: SizeConfig.size4.toInt(),
                child: isImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(SizeConfig.size10),
                        child: CachedNetworkImage(
                          imageUrl: value,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Container(),
                          fit: BoxFit.cover,
                          height: SizeConfig.size100,
                          width: SizeConfig.size100,
                        ),
                      )
                    : Text(
                        value,
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
              ),
            ]
          : [
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  key,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size4.toInt(),
                child: Text(
                  value,
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
            ],
    ),
  );
}
