import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';

class DashboardController extends GetxController {
  RxList<String> tabs = [
    StringConfig.dashboard.enterprise,
    StringConfig.dashboard.userIAM,
  ].obs;
  RxInt selectedTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController subscriptionController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController mqsEnterpriseCodeController =
      TextEditingController();
  final TextEditingController mqsEnterpriseNameController =
      TextEditingController();
  final TextEditingController mqsSubscriptionExpiryDateController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController pocAddressController = TextEditingController();
  final TextEditingController pocEmailController = TextEditingController();
  final TextEditingController pocNameController = TextEditingController();
  final TextEditingController pocPhoneNumberController =
      TextEditingController();
  RxBool mqsCommonLogin = false.obs, isSignedUp = false.obs;
  RxBool showMqsEmpEmailList = false.obs,
      showMqsEnterpriseLocationDetails = false.obs,
      showMqsEnterprisePOCs = false.obs,
      isAddEnterprise = false.obs;
  RxList<MenuOptionModel> options = [
    MenuOptionModel(
      icon: ImageConfig.edit,
      title: StringConfig.dashboard.edit,
    ),
    MenuOptionModel(
      icon: ImageConfig.delete,
      title: StringConfig.dashboard.delete,
      color: ColorConfig.deleteColor,
    ),
  ].obs;
}
