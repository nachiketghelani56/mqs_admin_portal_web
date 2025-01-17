import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget userSubscriptionReceiptTableTitleWidget(
    {required BuildContext context}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableTitleDecoration.copyWith(
      border: Border(
        top: BorderSide.none,
        bottom: BorderSide(
            color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4)),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: context.width > SizeConfig.size1500
        ? Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.firebaseUserId,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.mongoDbUserId,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size15),
                  child: Text(
                    StringConfig.reporting.subscriptionActivePlan,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.subscriptionStatus,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.subscriptionPlatform,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const SizedBox(),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.firebaseUserId,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size15),
                  child: Text(
                    StringConfig.reporting.subscriptionActivePlan,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    StringConfig.reporting.subscriptionPlatform,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                      fontSize: FontSizeConfig.fontSize15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: SizeConfig.size22,
                  ).paddingSymmetric(horizontal: SizeConfig.size10),
                  Container(
                    width: SizeConfig.size22,
                  ).paddingOnly(right: SizeConfig.size10),
                  Container(
                    width: SizeConfig.size22,
                  ).paddingOnly(right: SizeConfig.size10),
                ],
              )
            ],
          ),
  );
}
