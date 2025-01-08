import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_enterprise_data_widget.dart';

class AddEnterpriseDataScreen extends StatelessWidget {
  AddEnterpriseDataScreen({super.key});

  final EnterpriseDataController _enterpriseDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
          () => addEnterpriseDataWidget(
              enterpriseDataController: _enterpriseDataController, context: context),
        ),
      ),
    );
  }
}
