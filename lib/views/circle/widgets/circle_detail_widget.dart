import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget circleDetailWidget({required CircleController circleController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.dashboard.circleInformation,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueRowWidget(
            key: StringConfig.reporting.postTitle,
            value: circleController.circleDetail.postTitle ?? "",
            isFirst: true,
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.postContent,
            value: circleController.circleDetail.postContent ?? "",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.postViews,
            value: "${circleController.circleDetail.postView ?? 0}",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.postTime,
            value: (circleController.circleDetail.postTime ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        circleController.circleDetail.postTime ?? ""))
                : "",
          ),
          keyValueRowWidget(
            key: StringConfig.dashboard.fullName,
            value: circleController.circleDetail.userName ?? "",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.isMainPost,
            value: "${circleController.circleDetail.isMainPost ?? false}",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.userIsGuide,
            value: "${circleController.circleDetail.userIsGuide ?? false}",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.isFlag,
            value: "${circleController.circleDetail.isFlag ?? false}",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.flagName,
            value: circleController.circleDetail.flagName ?? "",
          ),
          keyValueRowWidget(
            key: StringConfig.reporting.hashTags,
            value: circleController.circleDetail.hashtag?.join(', ') ?? "",
            isLast: true,
          ),
        ],
      ),
    ),
  );
}
