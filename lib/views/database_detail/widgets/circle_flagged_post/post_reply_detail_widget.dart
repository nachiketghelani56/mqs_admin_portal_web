import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget postReplyDetailWidget(
    {required CircleFlaggedPostController circleFlaggedPostController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.database.postReply,
        isShowContent: circleFlaggedPostController.showPostReply.value,
      ).tap(() {
        circleFlaggedPostController.showPostReply.value =
            !circleFlaggedPostController.showPostReply.value;
      }),
      if (circleFlaggedPostController.showPostReply.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Text(
                StringConfig.database.id,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ],
          ),
        ),
        for (int i = 0;
            i <
                (circleFlaggedPostController.circleFlaggedPostDetail.circleData
                        ?.postReply?.length ??
                    0);
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration: i ==
                    (circleFlaggedPostController.circleFlaggedPostDetail
                                .circleData?.postReply?.length ??
                            0) -
                        1
                ? FontTextStyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextStyleConfig.contentDecoration,
            child: Row(
              children: [
                Text(
                  circleFlaggedPostController
                          .circleFlaggedPostDetail.circleData?.postReply?[i] ??
                      "",
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
