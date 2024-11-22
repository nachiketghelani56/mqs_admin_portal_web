import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

Widget authSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController}) {
  return Container(
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.reporting.authSummary,
                style: FontTextStyleConfig.cardTitleTextStyle,
              ),
            ),
            SizedBox(
              width: SizeConfig.size124,
              child: CustomButton(
                isSelected: false,
                btnText: StringConfig.dashboard.export,
                onTap: () {},
              ),
            ),
            SizeConfig.size12.width,
            SizedBox(
              width: SizeConfig.size55,
              child: CustomButton(
                isSelected: false,
                onTap: () {},
                onTapDown: (details) {
                  final offset = details.globalPosition;
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        offset.dx,
                        offset.dy,
                        context.width - offset.dx,
                        context.height - offset.dy,
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text(StringConfig.reporting.lastDay),
                        ),
                        PopupMenuItem(
                          child: Text(StringConfig.reporting.lastWeek),
                        ),
                        PopupMenuItem(
                          child: Text(StringConfig.reporting.lastMonth),
                        ),
                      ]);
                },
                child: Image.asset(
                  ImageConfig.filterNew,
                  height: SizeConfig.size28,
                  width: SizeConfig.size28,
                ),
              ),
            ),
          ],
        ),
        SizeConfig.size24.height,
        Row(
          children: [
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card1Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${reportingController.totalRegisteredUsers.value}',
                        style: FontTextStyleConfig.cardMainTextStyle,
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.totalRegisteredUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card2Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: FontTextStyleConfig.cardMainTextStyle
                          .copyWith(color: ColorConfig.card2TextColor),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.activeUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card3Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: FontTextStyleConfig.cardMainTextStyle
                          .copyWith(color: ColorConfig.card3TextColor),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.inactiveUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
