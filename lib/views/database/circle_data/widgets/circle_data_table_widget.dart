import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/dashed_field_widget.dart';
import 'package:mqs_admin_portal_web/widgets/dashed_border.dart';

Widget circleDataTableWidget({
  required BuildContext context,
  required CircleDataController circleDataController,
}) {
  return Column(
    children: [
      Container(
        height: SizeConfig.size65,
        decoration: FontTextStyleConfig.cardDecoration.copyWith(),
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.size4)),
                side: BorderSide.none,
                activeColor: ColorConfig.primaryColor,
                fillColor: true
                    ? WidgetStatePropertyAll(ColorConfig.checkBoxColor
                        .withOpacity(SizeConfig.size0point6))
                    : null,
                onChanged: (value) {},
              ),
            ).paddingSymmetric(horizontal: SizeConfig.size8),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: SizeConfig.size4),
                child: Text(
                  StringConfig.database.userName.toUpperCase(),
                  style: FontTextStyleConfig.mainHeadingTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: SizeConfig.size4),
                child: Text(
                  StringConfig.database.postTitle.toUpperCase(),
                  style: FontTextStyleConfig.mainHeadingTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                child: Text(
                  StringConfig.reporting.postViews.toUpperCase(),
                  style: FontTextStyleConfig.mainHeadingTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                child: Text(
                  StringConfig.reporting.postTime.toUpperCase(),
                  style: FontTextStyleConfig.mainHeadingTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                child: Text(
                  StringConfig.database.actions,
                  style: FontTextStyleConfig.mainHeadingTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      for (var i = circleDataController.startIndex.value;
          i < circleDataController.endIndex.value;
          i++)
        DashedBorder(
          dashWidth: 8.0,
          dashSpace: 2.5,
          borderThickness: 3,
          borderColor:
              ColorConfig.titleColor.withOpacity(SizeConfig.size0point06),
          child: DashedFieldWidget(
            i: i,
            circleDataController: circleDataController,
            // pathwayController: pathwayController,
            // moduleController: moduleController,
          ),
        ),
      // if (pathwayController.pathwayList.isEmpty) ...[
      //   Center(
      //     child: Column(
      //       children: [
      //         SizeConfig.size40.height,
      //         Text(
      //           StringConfig.pathwayConst.noPathwayFound,
      //           textAlign: TextAlign.center,
      //           style: TextStyleConfig.dialogTitleTextStyle.copyWith(
      //             color: ColorConfig.titleColor,
      //           ),
      //         ),
      //         SizeConfig.size10.height,
      //         CustomPrimaryButton(
      //           isButtonShow:
      //           context.width < SizeConfig.size1500 ? true : false,
      //           onTap: () {
      //             dashboardController.isEdit.value = 1;
      //             dashboardController.routeList
      //                 .add(StringConfig.pathwayConst.addPathway);
      //             dashboardController
      //                 .switchView(StringConfig.pathwayConst.addPathway);
      //           },
      //           btnText: StringConfig.pathwayConst.createPathway,
      //           iconData: Icons.add,
      //         ),
      //         SizeConfig.size40.height,
      //       ],
      //     ),
      //   ),
      // ],
      // SizeConfig.size14.height,
      // GetBuilder<DashboardController>(
      //   builder: (dashboardController) {
      //     return Row(
      //       children: [
      //         Expanded(
      //           child: Row(
      //             children: [
      //               Theme(
      //                 data: ThemeData(
      //                   hoverColor: ColorConfig.lessonHeaderColor,
      //                 ),
      //                 child: PopupMenuButton<String>(
      //                   padding: const EdgeInsets.all(20),
      //                   borderRadius: BorderRadius.circular(80),
      //                   color: ColorConfig.whiteColor,
      //                   // shadowColor: ColorConfig.textFieldColor,
      //                   onSelected: (value) {
      //                     pathwayController.itemsPerPage.value =
      //                         int.parse(value);
      //                     pathwayController.currentPage.value = 1;
      //                     pathwayController.startIndex.value = 0;
      //                     pathwayController.endIndex.value = 0;
      //                     pathwayController.countPage();
      //                     pathwayController.update();
      //                   },
      //                   enableFeedback: false,
      //                   elevation: 1.9,
      //                   constraints: const BoxConstraints.expand(
      //                       height: SizeConfig.size160,
      //                       width: SizeConfig.size140),
      //                   itemBuilder: (BuildContext context) {
      //                     return ["10", "15", "20", "25", "50"]
      //                         .map((String option) {
      //                       return PopupMenuItem(
      //                         value: option,
      //                         child: Text(
      //                           option,
      //                           style: TextStyleConfig.tableTitleTextStyle
      //                               .copyWith(
      //                               color: ColorConfig.primaryColor,
      //                               fontWeight: FontWeight.w600),
      //                         ),
      //                       );
      //                     }).toList();
      //                   },
      //                   child: Container(
      //                     height: SizeConfig.size47,
      //                     decoration: BoxDecoration(
      //                       color: ColorConfig.btnColor,
      //                       borderRadius:
      //                       BorderRadius.circular(SizeConfig.size10),
      //                     ),
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: SizeConfig.size14),
      //                     child: Row(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         Text(
      //                           pathwayController.itemsPerPage.value.toString(),
      //                           style: TextStyleConfig.menuTextStyle.copyWith(
      //                               color: ColorConfig.titleColor,
      //                               fontSize: SizeConfig.size18),
      //                         ).paddingOnly(right: SizeConfig.size6),
      //                         Image.asset(ImageConfig.arrowDown)
      //                       ],
      //                     ),
      //                   ).paddingSymmetric(horizontal: SizeConfig.size10),
      //                 ),
      //               ),
      //               Flexible(
      //                 child: Text(
      //                   '${StringConfig.pathwayConst.showing} ${pathwayController.startIndex.value + 1} ${StringConfig.pathwayConst.to.toLowerCase()} ${pathwayController.endIndex.value} ${StringConfig.pathwayConst.of.toLowerCase()} ${pathwayController.pathwayList.length}  ${StringConfig.pathwayConst.entries.toLowerCase()}',
      //                   style: TextStyleConfig.menuTextStyle.copyWith(
      //                       color: ColorConfig.titleColor,
      //                       fontSize: SizeConfig.size18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Image.asset(ImageConfig.altArrowLeft)
      //                 .paddingOnly(right: SizeConfig.size10)
      //                 .tap(() {
      //               if (pathwayController.currentPage.value > 1) {
      //                 pathwayController.currentPage.value--;
      //                 pathwayController.countPage();
      //                 pathwayController.update();
      //               }
      //             }),
      //             CustomPrimaryButton(
      //               onTap: () {},
      //               btnText: pathwayController.currentPage.value >
      //                   pathwayController.totalPages.value
      //                   ? pathwayController.totalPages.toString()
      //                   : pathwayController.currentPage.toString(),
      //             ),
      //             if (pathwayController.currentPage.value + 1 <=
      //                 pathwayController.totalPages.value)
      //               Text(
      //                 '${pathwayController.currentPage.value + 1}',
      //                 style: TextStyleConfig.menuTextStyle.copyWith(
      //                     color: ColorConfig.titleColor,
      //                     fontSize: SizeConfig.size18),
      //               ).paddingSymmetric(horizontal: 15).tap(() {
      //                 if (pathwayController.currentPage.value <
      //                     pathwayController.totalPages.value) {
      //                   pathwayController.currentPage.value =
      //                       pathwayController.currentPage.value + 1;
      //                   pathwayController.countPage();
      //                   pathwayController.update();
      //                 }
      //               }),
      //             if (pathwayController.currentPage.value + 2 <=
      //                 pathwayController.totalPages.value)
      //               Text(
      //                 '${pathwayController.currentPage.value + 2}',
      //                 style: TextStyleConfig.menuTextStyle.copyWith(
      //                     color: ColorConfig.titleColor,
      //                     fontSize: SizeConfig.size18),
      //               ).paddingSymmetric(horizontal: 15).tap(() {
      //                 if (pathwayController.currentPage.value <
      //                     pathwayController.totalPages.value) {
      //                   pathwayController.currentPage.value =
      //                       pathwayController.currentPage.value + 2;
      //                   pathwayController.countPage();
      //                   pathwayController.update();
      //                 }
      //               }),
      //             Image.asset(ImageConfig.arrowRight).tap(() {
      //               if (pathwayController.currentPage.value <
      //                   pathwayController.totalPages.value) {
      //                 pathwayController.currentPage.value++;
      //                 pathwayController.countPage();
      //                 pathwayController.update();
      //               }
      //             }),
      //           ],
      //         )
      //       ],
      //     );
      //   },
      // )
    ],
  );
}
