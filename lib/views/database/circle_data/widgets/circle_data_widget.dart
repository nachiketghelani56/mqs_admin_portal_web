import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_widget.dart';
import 'package:mqs_admin_portal_web/widgets/common_search_field.dart';
import 'package:mqs_admin_portal_web/widgets/custom_secondary_button.dart';

/// old
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
// import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_bottom_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_row_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_title_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_top_buttons_widget.dart';
// import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
// import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';
//
// Widget circleDataWidget({
//   required BuildContext context,
//   required CircleDataController circleDataController,required MqsDashboardController mqsDashboardController,
//   required GlobalKey<ScaffoldState> scaffoldKey,
//
// }) {
//   return Obx(
//     () => circleDataController.circleLoader.value
//         ? const LoaderWidget()
//         : Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.only(bottom: SizeConfig.size25),
//                   child: Container(
//                     decoration: circleDataController.circle.isNotEmpty
//                         ? FontTextStyleConfig.cardDecoration
//                         : null,
//                     padding: const EdgeInsets.all(SizeConfig.size16),
//                     child: Column(
//                       children: [
//
//                         circleDataTopButtonsWidget(
//                           circleDataController: circleDataController,
//                           scaffoldKey: scaffoldKey,
//                           context: context,
//                             mqsDashboardController:mqsDashboardController,
//                         ),
//                         SizeConfig.size26.height,
//                         circleDataController.searchedCircle.isEmpty
//                             ? Text(
//                                 StringConfig.dashboard.noDataFound,
//                                 style: FontTextStyleConfig.subtitleStyle,
//                               ).center
//                             : SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     circleDataTableTitleWidget(context: context),
//                                     for (int i = circleDataController.offset.value;
//                                         i < circleDataController.getMaxOffset();
//                                         i++)
//                                       circleDataTableRowWidget(
//                                         circleDataController: circleDataController,
//                                         isSelected:
//                                             circleDataController.viewIndex.value ==
//                                                 i,
//                                         context: context,
//                                         mqsDashboardController:
//                                             mqsDashboardController,
//                                         index: i,
//
//                                       ),
//                                     circleDataTableBottomWidget(
//                                         circleDataController: circleDataController),
//                                   ],
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ).paddingOnly(
//             left: SizeConfig.size40,
//             right: SizeConfig.size40,
//             top: SizeConfig.size25,
//           ),
//   );
// }

///
Widget circleDataWidget({
  required CircleDataController circleDataController,
  // required ModuleController moduleController,
  required BuildContext context,
  // required DashboardController dashboardController
}) {
  return Card(
    color: ColorConfig.whiteColor,
    margin: const EdgeInsets.only(left:SizeConfig.size20,right: SizeConfig.size20,bottom: SizeConfig.size20),
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.size22)),
    child: Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                CustomSecondaryButton(
                  onTap: () {},
                  isButtonShow:
                      context.width < SizeConfig.size1500 ? true : false,
                  btnText: StringConfig.dashboard.filter,
                  icon: ImageConfig.filterIcon,
                ),
                CommonSearchField(
                  controller: circleDataController.searchController,
                  hintText: StringConfig.circle.searchByName,
                  color: ColorConfig.textFieldColor,
                ).paddingSymmetric(horizontal: SizeConfig.size16),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                CustomSecondaryButton(
                  onTap: () {},
                  isButtonShow:
                      context.width < SizeConfig.size1500 ? true : false,
                  btnText: StringConfig.dashboard.export,
                  icon: ImageConfig.exportIcon,
                ).paddingOnly(left: SizeConfig.size16),
                CustomSecondaryButton(
                  onTap: () {},
                  isButtonShow:
                      context.width < SizeConfig.size1500 ? true : false,
                  btnText: StringConfig.circle.import,
                  icon: ImageConfig.importIcon,
                ).paddingSymmetric(horizontal: SizeConfig.size16),
                CustomSecondaryButton(
                  isButtonShow:
                      context.width < SizeConfig.size1500 ? true : false,
                  onTap: () {},
                  buttonColor: ColorConfig.primaryColor,
                  textColor: ColorConfig.whiteColor,
                  btnText: StringConfig.circle.addCircle,
                  iconData: Icons.add,
                ),
              ],
            ),
          ],
        ),
        SizeConfig.size20.height,
        circleDataTableWidget(

          circleDataController: circleDataController,
            context: context,
            // moduleController: moduleController,
            // pathwayController: pathwayController
        )
      ],
    ).paddingAll(SizeConfig.size20),
  );
}
