import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/common_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_checkbox.dart';

class DashedFieldWidget extends StatelessWidget {
  final int i;
  final CircleDataController circleDataController;
  // final DashboardController dashboardController;
  // final PathwayController pathwayController;
  // final ModuleController moduleController;

  DashedFieldWidget({
    super.key,
    required this.i,
    required this.circleDataController,
    // required this.dashboardController,
    // required this.pathwayController,
    // required this.moduleController,
  });

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Container(
            height: SizeConfig.size65,
            decoration: FontTextStyleConfig.cardDecoration.copyWith(
              color: _isHovered ? ColorConfig.bgColor : Colors.white,
              borderRadius: BorderRadius.circular(SizeConfig.size0),
              // color: isSelected ? ColorConfig.bg2Color : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
            child: Row(
              children: [
                const CustomCheckbox(
                  value: false,
                ).paddingSymmetric(horizontal: SizeConfig.size8),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size4),
                    child: Text(
                      circleDataController.searchedCircle[i].userName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: FontTextStyleConfig.tableTextStyle.copyWith(
                        color: ColorConfig.navigationTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size4),
                    child: Text(
                      circleDataController.searchedCircle[i].postTitle ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: FontTextStyleConfig.tableTextStyle.copyWith(
                        color: ColorConfig.navigationTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size4),
                    child: Text(
                      circleDataController.searchedCircle[i].postView
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: FontTextStyleConfig.tableTextStyle.copyWith(
                        color: ColorConfig.navigationTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size4),
                    child: Text(
                      circleDataController.searchedCircle[i].postTime ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: FontTextStyleConfig.tableTextStyle.copyWith(
                        color: ColorConfig.navigationTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    StringConfig.database.replyPost,
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableBottomTextStyle.copyWith(
                      color: ColorConfig.replyTextColor,
                    ),
                  ),
                ),
                if (context.width > SizeConfig.size1500) ...[
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 20,
                          child: CommonIconButton(
                            icon: ImageConfig.viewIcon,
                            onTap: () {
                              // pathwayController.isEdit.value = 0;
                              // pathwayController.tapViewButton(
                              //     pathwayController.pathwayList[i].id);
                              // dashboardController.routeList
                              //     .add(StringConfig.pathwayConst.viewPathway);
                              // dashboardController.switchView(
                              //     StringConfig.pathwayConst.viewPathway);
                            },
                            color: ColorConfig.blueColor,
                          ),
                        ),
                        SizeConfig.size10.width,
                        Flexible(
                          flex: 20,
                          child: CommonIconButton(
                            icon: ImageConfig.editIcon,
                            onTap: () {
                              // pathwayController.isEdit.value = 1;
                              // pathwayController.tapViewButton(
                              //     pathwayController.pathwayList[i].id);
                              // dashboardController.routeList
                              //     .add(StringConfig.pathwayConst.editPathway);
                              // dashboardController.switchView(
                              //     StringConfig.pathwayConst.editPathway);
                            },
                            color: ColorConfig.greenColor,
                          ),
                        ),
                        SizeConfig.size10.width,
                        Flexible(
                          flex: 20,
                          child: CommonIconButton(
                            icon: ImageConfig.deleteIcon,
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return CustomDeleteDialog(
                              //       title: pathwayController.pathwayList[i].id,
                              //       moduleName:
                              //       StringConfig.pathwayConst.pathways,
                              //       deleteOnTap: () {
                              //         pathwayController.deletePathway(
                              //             pathwayController.pathwayList[i]);
                              //       },
                              //       cancelOnTap: () {
                              //         Get.back();
                              //       },
                              //     );
                              //   },
                              // );
                            },
                            color: ColorConfig.redColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // if (context.width < SizeConfig.size1500) ...[
                //   Expanded(
                //     child: Theme(
                //       data: ThemeData(
                //         hoverColor: ColorConfig.lessonHeaderColor,
                //         primaryColor: Colors.purple,
                //       ),
                //       child: PopupMenuButton<String>(
                //         padding: const EdgeInsets.all(20),
                //         borderRadius: BorderRadius.circular(80),
                //         color: ColorConfig.whiteColor,
                //         // shadowColor: ColorConfig.textFieldColor,
                //         onSelected: (value) {
                //           if (value == StringConfig.view) {
                //             pathwayController.isEdit.value = 1;
                //             pathwayController.tapViewButton(
                //                 pathwayController.pathwayList[i].id);
                //
                //             dashboardController.routeList
                //                 .add(StringConfig.pathwayConst.viewPathway);
                //             dashboardController.switchView(
                //                 StringConfig.pathwayConst.viewPathway);
                //           } else if (value == StringConfig.edit) {
                //             pathwayController.tapViewButton(
                //                 pathwayController.pathwayList[i].id);
                //
                //             pathwayController.isEdit.value = 0;
                //             dashboardController.routeList
                //                 .add(StringConfig.pathwayConst.editPathway);
                //             dashboardController.switchView(
                //                 StringConfig.pathwayConst.editPathway);
                //           } else {
                //             showDialog(
                //               context: context,
                //               builder: (context) {
                //                 return CustomDeleteDialog(
                //                   title: pathwayController.pathwayList[i].id,
                //                   moduleName:
                //                   StringConfig.pathwayConst.pathways,
                //                   deleteOnTap: () {
                //                     pathwayController.deletePathway(
                //                         pathwayController.pathwayList[i]);
                //                   },
                //                   cancelOnTap: () {
                //                     Get.back();
                //                   },
                //                 );
                //               },
                //             );
                //           }
                //         },
                //
                //         enableFeedback: false,
                //         tooltip: "",
                //         elevation: 1.9,
                //         constraints: const BoxConstraints.expand(
                //             height: SizeConfig.size160,
                //             width: SizeConfig.size140),
                //         icon: const Icon(Icons.more_vert),
                //         itemBuilder: (BuildContext context) {
                //           return [
                //             StringConfig.view,
                //             StringConfig.edit,
                //             StringConfig.delete
                //           ].map((String option) {
                //             return PopupMenuItem(
                //               value: option,
                //               child: Text(
                //                 option,
                //                 style: TextStyleConfig.tableTitleTextStyle
                //                     .copyWith(
                //                     color: ColorConfig.primaryColor,
                //                     fontWeight: FontWeight.w600),
                //               ),
                //             );
                //           }).toList();
                //         },
                //       ),
                //     ),
                //   )
                // ]
              ],
            ),
          ).tap(() {
            // dashboardController.scaffoldKey.currentState?.openEndDrawer();
            // pathwayController.pathway = pathwayController.pathwayList[i];
            // dashboardController
            //     .switchDrawerView(StringConfig.moduleConst.modules);
            // pathwayController.moduleList.value =
            //     pathwayController.pathwayList[i].mqsPathwayDetail.mqsModules;
          }),
        );
      },
    );
  }
}
