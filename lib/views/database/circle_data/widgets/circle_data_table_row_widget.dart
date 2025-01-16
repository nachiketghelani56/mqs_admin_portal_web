import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_delete_dialog_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget circleDataTableRowWidget({
  required CircleDataController circleDataController,
  required MqsDashboardController mqsDashboardController,
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
    child: context.width > SizeConfig.size1500
        ? Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].userName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postTitle ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postContent ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postView
                            .toString() ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postTime ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      ImageConfig.eyeOpened,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataController.isAdd.value = false;
                      circleDataController.isEdit.value = false;
                      circleDataController.viewIndex.value = index;
                      mqsDashboardController.circleStatus.value = "view_circle";
                    }),
                    Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataController.viewIndex.value = index;
                      circleDataController.isAdd.value = false;
                      circleDataController.isEdit.value = true;
                      circleDataController.showHashTag.value = false;
                      circleDataController.setCircleForm();

                      mqsDashboardController.circleStatus.value = "add_circle";

                      // if (context.width < SizeConfig.size1500) {
                      //   Get.toNamed(AppRoutes.addCircle);
                      // }
                    }),
                    Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataDeleteDialogWidget(
                        context: context,
                        circleDataController: circleDataController,
                        docId:
                            circleDataController.searchedCircle[index].id ?? "",
                      );
                    }),
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    circleDataController.searchedCircle[index].userName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postTitle ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    circleDataController.searchedCircle[index].postContent ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.eyeOpened,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataController.isAdd.value = false;
                      circleDataController.isEdit.value = false;
                      circleDataController.viewIndex.value = index;
                      mqsDashboardController.circleStatus.value = "view_circle";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataController.viewIndex.value = index;
                      circleDataController.isAdd.value = false;
                      circleDataController.isEdit.value = true;
                      circleDataController.showHashTag.value = false;
                      circleDataController.setCircleForm();
                      mqsDashboardController.circleStatus.value = "add_circle";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      circleDataDeleteDialogWidget(
                        context: context,
                        circleDataController: circleDataController,
                        docId:
                            circleDataController.searchedCircle[index].id ?? "",
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
  );
}
