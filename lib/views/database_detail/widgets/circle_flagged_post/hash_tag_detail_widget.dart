import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget hashTagDetailWidget(
    {required CircleFlaggedPostController circleFlaggedPostController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.circle.hashTags,
        isShowContent: circleFlaggedPostController.showHashTag.value,
      ).tap(() {
        circleFlaggedPostController.showHashTag.value =
            !circleFlaggedPostController.showHashTag.value;
      }),
      if (circleFlaggedPostController.showHashTag.value) ...[
        SizeConfig.size10.height,
        Wrap(
          spacing: SizeConfig.size12,
          runSpacing: SizeConfig.size12,
          children: [
            for (int i = 0;
                i <
                    (circleFlaggedPostController.circleFlaggedPostDetail
                            .circleData?.hashtag?.length ??
                        0);
                i++)
              Container(
                decoration: FontTextStyleConfig.optionDecoration,
                padding: const EdgeInsets.all(SizeConfig.size10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '#${circleFlaggedPostController.circleFlaggedPostDetail.circleData?.hashtag?[i].name ?? ''}',
                      style: FontTextStyleConfig.labelTextStyle
                          .copyWith(color: ColorConfig.whiteColor),
                    ),
                  ],
                ),
              )
          ],
        ).paddingSymmetric(horizontal: SizeConfig.size10),
      ],
    ],
  );
}
