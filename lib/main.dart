import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MQSAdminPortalWeb());
}
