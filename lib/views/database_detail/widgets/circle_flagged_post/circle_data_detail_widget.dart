import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/widgets/circle_flagged_post/hash_tag_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/widgets/circle_flagged_post/post_reply_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget circleDataDetailWidget(
    {required CircleFlaggedPostController circleFlaggedPostController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.database.circleData,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.reporting.flagName,
        value: circleFlaggedPostController
                .circleFlaggedPostDetail.circleData?.flagName ??
            "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.postTitle,
        value: circleFlaggedPostController
                .circleFlaggedPostDetail.circleData?.postTitle ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.postContent,
        value: circleFlaggedPostController
                .circleFlaggedPostDetail.circleData?.postContent ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.postViews,
        value:
            "${circleFlaggedPostController.circleFlaggedPostDetail.circleData?.postView ?? 0}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.postTime,
        value: (circleFlaggedPostController
                        .circleFlaggedPostDetail.circleData?.postTime ??
                    "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(circleFlaggedPostController
                        .circleFlaggedPostDetail.circleData?.postTime ??
                    ""))
            : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userId,
        value: circleFlaggedPostController
                .circleFlaggedPostDetail.circleData?.userId ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.database.username,
        value: circleFlaggedPostController
                .circleFlaggedPostDetail.circleData?.userName ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.database.mainPost,
        value:
            "${circleFlaggedPostController.circleFlaggedPostDetail.circleData?.isMainPost.toString().capitalize ?? false}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.userIsGuide,
        value:
            "${circleFlaggedPostController.circleFlaggedPostDetail.circleData?.userIsGuide.toString().capitalize ?? false}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.database.flag,
        value:
            "${circleFlaggedPostController.circleFlaggedPostDetail.circleData?.isFlag.toString().capitalize ?? false}",
        isLast: true,
      ),
      if (circleFlaggedPostController
              .circleFlaggedPostDetail.circleData?.hashtag?.isNotEmpty ??
          false) ...[
        SizeConfig.size34.height,
        hashTagDetailWidget(
            circleFlaggedPostController: circleFlaggedPostController),
      ],
      if (circleFlaggedPostController
              .circleFlaggedPostDetail.circleData?.postReply?.isNotEmpty ??
          false) ...[
        SizeConfig.size34.height,
        postReplyDetailWidget(
            circleFlaggedPostController: circleFlaggedPostController),
      ],
    ],
  );
}
