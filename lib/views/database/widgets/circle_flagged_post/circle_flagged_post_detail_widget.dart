import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/widgets/circle_flagged_post/circle_data_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget circleFlaggedPostDetailWidget(
    {required CircleFlaggedPostController circleFlaggedPostController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.database.circleFlaggedPost,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueWrapperWidget(
            key: StringConfig.reporting.flagName,
            value:
                circleFlaggedPostController.circleFlaggedPostDetail.flagName ??
                    "",
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.database.flagUserID,
            value: circleFlaggedPostController
                    .circleFlaggedPostDetail.flagUserId ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.database.posterUserID,
            value: circleFlaggedPostController
                    .circleFlaggedPostDetail.posterUserId ??
                "",
            isLast: true,
          ),
          SizeConfig.size34.height,
          circleDataDetailWidget(
              circleFlaggedPostController: circleFlaggedPostController),
        ],
      ),
    ),
  );
}
