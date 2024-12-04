import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_detail_widget.dart';

class CircleDetailScreen extends StatelessWidget {
  CircleDetailScreen({super.key});

  final CircleController _circleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
          () => circleDetailWidget(circleController: _circleController),
        ),
      ),
    );
  }
}
