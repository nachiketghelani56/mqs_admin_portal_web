import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';

Widget userDetailRowWidget() {
  return Column(
    children: [
      keyValueRowWidget(
        key: StringConfig.dashboard.about,
        value: 'About',
        topBorder: true,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.aboutValue,
        value: 'False',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.country,
        value: '-',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsEnterPriseName,
        value: 'Enterprise 1',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.countryValue,
        value: 'False',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.email,
        value: 'testdevboard@gmail.com',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.firstName,
        value: 'Test',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.lastName,
        value: 'Board',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.pronouns,
        value: '-',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.pronounsValue,
        value: 'False',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.userImage,
        value: '-',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.isEnterPriseUser,
        value: 'False',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.isFirebaseUserId,
        value: 'OF9AA3ZAGFY635nBF6739FGb',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.isMongoDBUserId,
        value: 'OF9AA3ZAGFY635nBF6739FGb',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.isRegister,
        value: 'IsRegisterUserDone',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.loginWith,
        value: 'Email',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsExpiryDate,
        value: '2024-11-10T18:21:52.914990',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsSubscriptionActivePlan,
        value: 'mqsmyqstudiosub1.subscription_202409_dev',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsSubscriptionPlatform,
        value: 'IOS',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsSubscriptionStatus,
        value: 'Active',
      ),
    ],
  );
}
