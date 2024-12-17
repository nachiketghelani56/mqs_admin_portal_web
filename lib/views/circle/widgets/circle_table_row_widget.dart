import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_delete_dialog_widget.dart';

Widget circleTableRowWidget({
  required CircleController circleController,
  required bool isSelected,
  required BuildContext context,
  required int index,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.cardDecoration.copyWith(
      borderRadius: BorderRadius.circular(SizeConfig.size0),
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          child: Text(
            circleController.searchedCircle[index].userName ?? "",
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            circleController.searchedCircle[index].postTitle ?? "",
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {
                circleController.isAdd.value = false;
                circleController.isEdit.value = false;
                circleController.viewIndex.value = index;
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.circleDetail);
                }
              }),
              if (!Get.currentRoute.startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
                Image.asset(
                  ImageConfig.edit,
                  height: SizeConfig.size24,
                ).tap(() {
                  circleController.viewIndex.value = index;
                  circleController.isAdd.value = false;
                  circleController.isEdit.value = true;
                  circleController.showHashTag.value = false;
                  circleController.setCircleForm();
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addCircle);
                  }
                }),
                Image.asset(
                  ImageConfig.delete,
                  height: SizeConfig.size24,
                ).tap(() {
                  circleDeleteDialogWidget(
                    context: context,
                    circleController: circleController,
                    docId: circleController.searchedCircle[index].id ?? "",
                  );
                }),
              ],

            ],
          ),
        ),
      ],
    ),
  );
}
