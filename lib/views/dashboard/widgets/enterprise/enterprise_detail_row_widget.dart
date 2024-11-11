import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';

Widget enterpriseDetailRowWidget() {
  return Column(
    children: [
      keyValueRowWidget(
        key: StringConfig.dashboard.subscription,
        value: 'Enterprise',
        topBorder: true,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.id,
        value: 'Ukscyu564HDG646733989GYGbgg',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsEnterPriseCode,
        value: '1234',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsEnterPriseName,
        value: 'Enterprise 1',
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.mqsSubscriptionExpiryDate,
        value: '2024-11-10T18:21:52.914990',
      ),
    ],
  );
}
