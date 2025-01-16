import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget circleDataDetailWidget(
    {required CircleDataController circleDataController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConfig.database.circleInformation,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizeConfig.size24.height,
          keyValueWrapperWidget(
            key: StringConfig.circle.postId,
            value: circleDataController.circleDetail.id ?? "",
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postTitle,
            value: circleDataController.circleDetail.postTitle ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postContent,
            value: circleDataController.circleDetail.postContent ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postViews,
            value: "${circleDataController.circleDetail.postView ?? 0}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.postTime,
            value: (circleDataController.circleDetail.postTime ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        circleDataController.circleDetail.postTime ?? ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.userId,
            value: circleDataController.circleDetail.userId ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.database.userName,
            value: circleDataController.circleDetail.userName ?? "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.database.mainPost,
            value: "${circleDataController.circleDetail.isMainPost ?? false}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.database.userGuide,
            value: "${circleDataController.circleDetail.userIsGuide ?? false}",
          ),
          if (circleDataController.circleDetail.isMainPost == true)
            keyValueWrapperWidget(
              key: StringConfig.reporting.postReplies,
              value:
                  "${circleDataController.circleDetail.postReply?.length ?? 0}",
            ),
          keyValueWrapperWidget(
            key: StringConfig.database.flag,
            value: "${circleDataController.circleDetail.isFlag ?? false}",
            isLast: circleDataController.circleDetail.isFlag == false,
          ),
          if (circleDataController.circleDetail.isFlag ?? false)
            keyValueWrapperWidget(
              key: StringConfig.reporting.flagName,
              value: circleDataController.circleDetail.flagName ?? "",
              isLast: true,
            ),
          if (circleDataController.circleDetail.isMainPost == true)
            if (circleDataController.circleDetail.postReply?.isNotEmpty ??
                false) ...[
              SizeConfig.size34.height,
              titleWidget(
                title: StringConfig.database.postReply,
                isShowContent: circleDataController.showPostReply.value,
              ).tap(() {
                circleDataController.showPostReply.value =
                    !circleDataController.showPostReply.value;
              }),
              if (circleDataController.showPostReply.value) ...[
                SizeConfig.size20.height,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size16),
                  child: Text(
                    circleDataController.circleDetail.postReply
                            ?.map((e) => e)
                            .join("   |   ")
                            .toString() ??
                        "",
                    style: FontTextStyleConfig.labelTextStyle.copyWith(
                      color: ColorConfig.subtitleColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          if (circleDataController.circleDetail.hashtag?.isNotEmpty ??
              false) ...[
            SizeConfig.size34.height,
            titleWidget(
              title: StringConfig.circle.hashTags,
              isShowContent: circleDataController.showHashTag.value,
            ).tap(() {
              circleDataController.showHashTag.value =
                  !circleDataController.showHashTag.value;
            }),
            if (circleDataController.showHashTag.value) ...[
              SizeConfig.size10.height,
              Wrap(
                spacing: SizeConfig.size12,
                runSpacing: SizeConfig.size12,
                children: [
                  for (int i = 0;
                      i <
                          (circleDataController.circleDetail.hashtag?.length ??
                              0);
                      i++)
                    Container(
                      decoration: FontTextStyleConfig.optionDecoration,
                      padding: const EdgeInsets.all(SizeConfig.size10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${circleDataController.circleDetail.hashtag?[i].name ?? ''}',
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
