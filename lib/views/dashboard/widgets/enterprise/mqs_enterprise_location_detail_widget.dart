// import 'package:flutter/material.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
// import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
// import 'package:mqs_admin_portal_web/widgets/title_widget.dart';
//
// Widget mqsEnterpriseLocationDetailWidget(
//     {required DashboardController dashboardController}) {
//   return Column(
//     children: [
//       titleWidget(
//         title: StringConfig.dashboard.mqsEnterpriseLocationDetails,
//         isShowContent:
//             dashboardController.showMqsEnterpriseLocationDetails.value,
//       ).tap(() {
//         dashboardController.showMqsEnterpriseLocationDetails.value =
//             !dashboardController.showMqsEnterpriseLocationDetails.value;
//       }),
//       if (dashboardController.showMqsEnterpriseLocationDetails.value) ...[
//         SizeConfig.size10.height,
//         keyValueRowWidget(
//           key: StringConfig.dashboard.address,
//           value: dashboardController
//               .enterpriseDetail.mqsEnterpriseLocationDetails.address,
//           topBorder: true,
//         ),
//         keyValueRowWidget(
//             key: StringConfig.dashboard.pinCode,
//             value: dashboardController
//                 .enterpriseDetail.mqsEnterpriseLocationDetails.pinCode),
//       ],
//     ],
//   );
// }
