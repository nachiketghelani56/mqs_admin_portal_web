import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/enterprise_data_detail/widgets/mqs_enterprise_data_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/enterprise_data_detail/widgets/mqs_enterprise_data_pocs_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/enterprise_data_detail/widgets/mqs_enterprise_data_subscription_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/enterprise_data_detail/widgets/mqs_enterprise_data_team_list_widget.dart';

Widget enterpriseDataDetailWidget(
    {required EnterpriseDataController enterpriseDataController }) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (enterpriseDataController.enterpriseDetail.mqsEnterprisePOCsList.isNotEmpty) ...[
            SizeConfig.size34.height,
            mqsEnterpriseDataPOCsWidget(enterpriseDataController: enterpriseDataController),
          ],
          SizeConfig.size34.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration.copyWith( borderRadius: const BorderRadius.all(
              Radius.circular(SizeConfig.size12),
            ),),
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    StringConfig.dashboard.mqsEnterPriseCode,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    enterpriseDataController.enterpriseDetail.mqsEnterpriseCode,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),

              ],
            ),
          ),
          if (enterpriseDataController.enterpriseDetail.mqsTeamList.isNotEmpty) ...[
            SizeConfig.size34.height,
            mqsEnterpriseDataTeamListWidget(enterpriseDataController: enterpriseDataController),
          ],
          if (enterpriseDataController
              .enterpriseDetail.mqsEmployeeList.isNotEmpty) ...[
            SizeConfig.size34.height,
            mqsEnterpriseDataEmployeeEmailListWidget(
                enterpriseDataController: enterpriseDataController),
          ],
          if (enterpriseDataController.checkEnterprisePOCsSubscriptionDetail()) ...[
            SizeConfig.size34.height,
            mqsEnterpriseDataSubscriptionDetailWidget(
                enterpriseDataController: enterpriseDataController),
          ],
          SizeConfig.size34.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    StringConfig.csv.createdTimestamp,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.csv.updatedTimestamp,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.contentDecoration.copyWith(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(SizeConfig.size12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    enterpriseDataController.dateConvert(enterpriseDataController
                        .enterpriseDetail.mqsCreatedTimestamp),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    enterpriseDataController.dateConvert(enterpriseDataController
                        .enterpriseDetail.mqsUpdatedTimestamp),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
