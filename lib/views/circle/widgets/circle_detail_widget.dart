import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
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
            title: StringConfig.circle.circleInformation,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueWrapperWidget(
            key: StringConfig.circle.postId,
            value: circleController.circleDetail.id ?? "",
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postTitle,
            value: circleController.circleDetail.postTitle ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postContent,
            value: circleController.circleDetail.postContent ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postViews,
            value: "${circleController.circleDetail.postView ?? 0}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postTime,
            value: (circleController.circleDetail.postTime ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        circleController.circleDetail.postTime ?? ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.fullName,
            value: circleController.circleDetail.userName ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.isMainPost,
            value: "${circleController.circleDetail.isMainPost ?? false}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.userIsGuide,
            value: "${circleController.circleDetail.userIsGuide ?? false}",
          ),
          if (circleController.circleDetail.isMainPost == true)
            keyValueWrapperWidget(
              key: StringConfig.reporting.postReplies,
              value: "${circleController.circleDetail.postReply?.length ?? 0}",
            ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.isFlag,
            value: "${circleController.circleDetail.isFlag ?? false}",
            isLast: circleController.circleDetail.isFlag == false,
          ),
          if (circleController.circleDetail.isFlag ?? false)
            keyValueWrapperWidget(
              key: StringConfig.reporting.flagName,
              value: circleController.circleDetail.flagName ?? "",
              isLast: true,
            ),
          if (circleController.circleDetail.hashtag?.isNotEmpty ?? false) ...[
            SizeConfig.size34.height,
            titleWidget(
              title: StringConfig.circle.hashTags,
              isShowContent: circleController.showHashTag.value,
            ).tap(() {
              circleController.showHashTag.value =
                  !circleController.showHashTag.value;
            }),
            if (circleController.showHashTag.value) ...[
              SizeConfig.size10.height,
              Wrap(
                spacing: SizeConfig.size12,
                runSpacing: SizeConfig.size12,
                children: [
                  for (int i = 0;
                      i < (circleController.circleDetail.hashtag?.length ?? 0);
                      i++)
                    Container(
                      decoration: FontTextStyleConfig.optionDecoration,
                      padding: const EdgeInsets.all(SizeConfig.size10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${circleController.circleDetail.hashtag?[i].name ?? ''}',
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
        ],
      ),
    ),
  );
}
