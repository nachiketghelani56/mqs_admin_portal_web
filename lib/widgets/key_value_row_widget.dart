import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:readmore/readmore.dart';

Widget keyValueRowWidget(
    bool isImage, String value, String key, Widget? widget) {
  return Row(
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
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: ColorConfig.primaryColor,
                        ),
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
              child: widget ??
                  ReadMoreText(
                    value,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: StringConfig.pathway.showMore,
                    trimExpandedText: StringConfig.pathway.showLess,
                    moreStyle: FontTextStyleConfig.tableContentTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    lessStyle: FontTextStyleConfig.tableContentTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
            ),
          ],
  );
}
