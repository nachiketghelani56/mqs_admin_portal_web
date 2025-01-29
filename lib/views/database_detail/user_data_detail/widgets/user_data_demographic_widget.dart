// import 'package:flutter/material.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
// import 'package:mqs_admin_portal_web/widgets/title_widget.dart';
//
// Widget userDataDemographicWidget(
//     {required UserDataController userDataController}) {
//   return Column(
//     children: [
//       titleWidget(
//         title: StringConfig.dashboard.mqsDemoGraphicDetails,
//         isShowContent: userDataController.showDemographic.value,
//       ).tap(() {
//         userDataController.showDemographic.value =
//             !userDataController.showDemographic.value;
//       }),
//       if (userDataController.showDemographic.value) ...[
//         SizeConfig.size10.height,
//         Container(
//           height: SizeConfig.size55,
//           padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
//           decoration: FontTextStyleConfig.headerDecoration,
//           child: Row(
//             children: [
//               Expanded(
//                 flex: SizeConfig.size2.toInt(),
//                 child: Text(
//                   StringConfig.dashboard.currentSelectedAnswer,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   StringConfig.dashboard.selectedIndex,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         for (int i = 0;
//             i <
//               (  userDataController
//                     .userDetail.mqsOnboardingDetails?.mqsDemoGraphicDetails?.length ?? 0);
//             i++)
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
//             decoration: i ==
//                    ( userDataController.userDetail.mqsOnboardingDetails
//                             ?.mqsDemoGraphicDetails?.length ?? 0) -
//                         1
//                 ? FontTextStyleConfig.contentDecoration.copyWith(
//                     borderRadius: const BorderRadius.vertical(
//                       bottom: Radius.circular(SizeConfig.size12),
//                     ),
//                   )
//                 : FontTextStyleConfig.contentDecoration,
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: SizeConfig.size2.toInt(),
//                   child: Text(
//                     userDataController.userDetail.mqsOnboardingDetails
//                         ?.mqsDemoGraphicDetails?[i].currentSelectedAnswer ?? "",
//                     style: FontTextStyleConfig.tableContentTextStyle,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     "${userDataController.userDetail.mqsOnboardingDetails?.mqsDemoGraphicDetails?[i].selectedIndex}",
//                     style: FontTextStyleConfig.tableContentTextStyle,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     ],
//   );
// }
