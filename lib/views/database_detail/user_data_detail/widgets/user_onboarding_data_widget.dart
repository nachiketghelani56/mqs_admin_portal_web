// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mqs_admin_portal_web/config/config.dart';
// import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
// import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
// import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_check_in_widget.dart';
// import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_demographic_widget.dart';
// import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_scenes_widget.dart';
// import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_wol_widget.dart';
// import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
// import 'package:mqs_admin_portal_web/widgets/title_widget.dart';
//
// Widget userDataOnboardingDataWidget(
//     {required UserDataController userDataController}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       titleWidget(
//         title: StringConfig.dashboard.onboardingData,
//         showArrowIcon: false,
//       ),
//       if (userDataController
//               .userDetail.mqsOnboardingDetails?.mqsCheckInDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size24.height,
//         userDataCheckInWidget(userDataController: userDataController),
//       ],
//       if (userDataController.userDetail.mqsOnboardingDetails
//               ?.mqsDemoGraphicDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size34.height,
//         userDataDemographicWidget(userDataController: userDataController),
//       ],
//       if (userDataController
//               .userDetail.mqsOnboardingDetails?.mqsScenesDetails?.isNotEmpty ??
//           false) ...[
//         SizeConfig.size34.height,
//         userDataScenesWidget(userDataController: userDataController),
//       ],
//       if (userDataController
//               .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails
//               ?.toJson()
//               .toString() !=
//           "{}") ...[
//         SizeConfig.size34.height,
//         userDataWOLWidget(userDataController: userDataController),
//       ],
//       SizeConfig.size34.height,
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBStart,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBStart.toString().capitalize}",
//         isFirst: true,
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDemoGraphic,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDemoGraphic.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBScenes,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBScenes.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBScenesScore,
//         value: userDataController
//                 .userDetail.mqsOnboardingDetails?.mqsOBScenesScore
//                 .toString() ??
//             "",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCheckIn,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBCheckIn.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCheckInScore,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBCheckInScore.toString()}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBWheelOfLife,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBWheelOfLife.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv1,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDiv1.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv2,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDiv2.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv3,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDiv3.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDiv4,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDiv4.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBRegister,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBRegister.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBSkip,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBSkip.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBDone,
//         value:
//             "${userDataController.userDetail.mqsOnboardingDetails?.mqsOBDone.toString().capitalize}",
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBStartTimestamp,
//         value: userDataController.dateConvert(userDataController
//                 .userDetail.mqsOnboardingDetails?.mqsOBStartTimestamp ??
//             ""),
//       ),
//       keyValueWrapperWidget(
//         key: StringConfig.dashboard.oBCompletedTimestamp,
//         value: userDataController.dateConvert(userDataController
//                 .userDetail.mqsOnboardingDetails?.mqsOBCompletedTimestamp ??
//             ""),
//         isLast: true,
//       ),
//     ],
//   );
// }
