import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/enterprise_data_detail/widgets/enterprise_data_detail_widget.dart';

class EnterpriseDataDetailScreen extends StatelessWidget {
  EnterpriseDataDetailScreen({super.key});

  final EnterpriseDataController _enterpriseDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
              () =>
                  enterpriseDataDetailWidget(enterpriseDataController: _enterpriseDataController),
        ),
      ),
    );
  }
}
