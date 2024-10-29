import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/app.dart';
import 'package:mqs_admin_portal_web/config/env.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Env.apiKey,
      appId: Env.appId,
      messagingSenderId: Env.messageSenderId,
      storageBucket: Env.storageBucketId,
      projectId: Env.projectId,
    ),
  );
  runApp(const MQSAdminPortalWeb());
}
