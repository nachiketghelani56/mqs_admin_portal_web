// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
// import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
// import 'package:mqs_admin_portal_web/widgets/title_widget.dart';
//
// Widget userDataCheckInWidget({required UserDataController userDataController}) {
//   return Column(
//     children: [
//       titleWidget(
//         title: StringConfig.dashboard.mqsCheckInDetails,
//         isShowContent: userDataController.showCheckIn.value,
//       ).tap(() {
//         userDataController.showCheckIn.value =
//             !userDataController.showCheckIn.value;
//       }),
//       if (userDataController.showCheckIn.value) ...[
//         SizeConfig.size10.height,
//         Container(
//           height: SizeConfig.size55,
//           padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
//           decoration: FontTextStyleConfig.headerDecoration,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   StringConfig.dashboard.checkInScore,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   StringConfig.dashboard.id,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   StringConfig.dashboard.mqsCINValue,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   StringConfig.dashboard.mqsTimeStamp,
//                   style: FontTextStyleConfig.tableBottomTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         for (int i = 0;
//             i <
//                 (userDataController
//                     .userDetail.mqsOnboardingDetails?.mqsCheckInDetails?.length ?? 0);
//             i++)
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
//             decoration: i ==
//                     (userDataController
//                             .userDetail.mqsOnboardingDetails?.mqsCheckInDetails?.length ?? 0) -
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
//                   child: Text(
//                     "${userDataController.userDetail.mqsOnboardingDetails?.mqsCheckInDetails?[i].checkInScore}",
//                     style: FontTextStyleConfig.tableContentTextStyle,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     userDataController
//                         .userDetail.mqsOnboardingDetails?.mqsCheckInDetails?[i].id??"",
//                     style: FontTextStyleConfig.tableContentTextStyle,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     "${userDataController.userDetail.mqsOnboardingDetails?.mqsCheckInDetails?[i].mqsCINValue}",
//                     style: FontTextStyleConfig.tableContentTextStyle,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(userDataController.userDetail.mqsOnboardingDetails
//                       ?.mqsCheckInDetails?[i].mqsTimestamp?.isNotEmpty ?? false  ?
//                     DateFormat('dd-MM-yyyy').format(DateTime.parse(
//                         userDataController.userDetail.mqsOnboardingDetails
//                             ?.mqsCheckInDetails?[i].mqsTimestamp ?? "")) : "",
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
