import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class CircleScreen extends StatelessWidget {
  CircleScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController _homeController = Get.find();
  final CircleController _circleController = Get.put(CircleController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
            homeController: _homeController,
            context: context,
            scaffoldKey: scaffoldKey),
        SizeConfig.size15.height,
        Expanded(
          child: circleWidget(
            context: context,
            circleController: _circleController,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ],
    );
  }
}
