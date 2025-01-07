import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/circle_flagged_post/circle_flagged_post_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/circle_flagged_post/circle_flagged_post_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/circle_flagged_post/circle_flagged_post_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/circle_flagged_post/circle_flagged_post_table_title_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget circleFlaggedPostWidget({
  required BuildContext context,
  required CircleFlaggedPostController circleFlaggedPostController,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return Obx(
    () => circleFlaggedPostController.circleFlaggedPostLoader.value
        ? const LoaderWidget()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                  child: Container(
                    decoration: FontTextStyleConfig.cardDecoration,
                    padding: const EdgeInsets.all(SizeConfig.size16),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              circleFlaggedPostTableTitleWidget(context: context),
                              for (int i = circleFlaggedPostController.offset.value;
                                  i < circleFlaggedPostController.getMaxOffset();
                                  i++)
                                circleFlaggedPostTableRowWidget(
                                    isSelected:
                                        i == circleFlaggedPostController.viewIndex.value,
                                    context: context,
                                    index: i,
                                    circleFlaggedPostController: circleFlaggedPostController),
                              circleFlaggedPostTableBottomWidget(
                                circleFlaggedPostController: circleFlaggedPostController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (context.width > SizeConfig.size1500 &&
                  circleFlaggedPostController.circleFlaggedPost.isNotEmpty) ...[
                SizeConfig.size20.width,
                Expanded(
                  child: circleFlaggedPostController.viewIndex.value >= 0
                      ? circleFlaggedPostDetailWidget(circleFlaggedPostController: circleFlaggedPostController)
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ).paddingOnly(
            left: SizeConfig.size40,
            right: SizeConfig.size40,
            top: SizeConfig.size25,
          ),
  );
}
