import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';

Widget enterpriseDetailRowWidget() {
  return Column(
    children: [
      keyValueRowWidget(
        key: 'Subscription',
        value: 'Enterprise',
        topBorder: true,
      ),
      keyValueRowWidget(
        key: '_id',
        value: 'Ukscyu564HDG646733989GYGbgg',
      ),
      keyValueRowWidget(
        key: 'mqsEnterPriseCode',
        value: '1234',
      ),
      keyValueRowWidget(
        key: 'mqsEnterPriseName',
        value: 'Enterprise 1',
      ),
      keyValueRowWidget(
        key: 'mqsSubscriptionExpiryDate',
        value: '2024-11-10T18:21:52.914990',
      ),
    ],
  );
}
