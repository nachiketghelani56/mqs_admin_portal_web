// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_check_in_widget.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_demographic_widget.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_scenes_widget.dart';
// import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_wol_widget.dart';
// import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
// import 'package:mqs_admin_portal_web/widgets/title_widget.dart';
//
// Widget userOnboardingDataWidget(
//     {required DashboardController dashboardController}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       titleWidget(
//         title: StringConfig.dashboard.onboardingData,
//         showArrowIcon: false,
//       ),
//       if (dashboardController
//               .userDetail.mqsOnboardingDetails?.mqsCheckInDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size24.height,
//         userCheckInWidget(dashboardController: dashboardController),
//       ],
//       if (dashboardController.userDetail.mqsOnboardingDetails
//               ?.mqsDemoGraphicDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size34.height,
//         userDemographicWidget(dashboardController: dashboardController),
//       ],
//       if (dashboardController
//               .userDetail.mqsOnboardingDetails?.mqsScenesDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size34.height,
//         userScenesWidget(dashboardController: dashboardController),
//       ],
//       if (dashboardController
//               .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails
//               ?.toJson()
//               .toString() !=
//           "{}") ...[
//         SizeConfig.size34.height,
//         userWOLWidget(dashboardController: dashboardController),
//       ],
//       SizeConfig.size34.height,
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBStart,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBStart.toString().capitalize}",
//         isFirst: true,
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDemoGraphic,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDemoGraphic.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBScenes,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBScenes.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBScenesScore,
//         value: dashboardController
//                 .userDetail.mqsOnboardingDetails?.mqsOBScenesScore
//                 .toString() ??
//             "",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCheckIn,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBCheckIn.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCheckInScore,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBCheckInScore.toString()}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBWheelOfLife,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBWheelOfLife.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv1,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDiv1.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv2,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDiv2.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv3,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDiv3.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv4,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDiv4.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBRegister,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBRegister.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBSkip,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBSkip.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDone,
//         value:
//             "${dashboardController.userDetail.mqsOnboardingDetails?.mqsOBDone.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBStartTimestamp,
//         value: dashboardController.dateConvert(dashboardController
//                 .userDetail.mqsOnboardingDetails?.mqsOBStartTimestamp ??
//             ""),
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCompletedTimestamp,
//         value: dashboardController.dateConvert(dashboardController
//                 .userDetail.mqsOnboardingDetails?.mqsOBCompletedTimestamp ??
//             ""),
//         isLast: true,
//       ),
//     ],
//   );
// }
