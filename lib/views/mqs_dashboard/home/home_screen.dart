import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_options_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          homeHeaderWidget(homeController: _homeController, context: context),
          homeOptionsWidget(homeController: _homeController)
              .paddingAll(SizeConfig.size40),
        ],
      ),
    );
  }
}
