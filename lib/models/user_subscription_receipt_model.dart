class UserSubscriptionReceiptModel {
  final String mqsFirebaseUserID;
  final String mqsMONGODBUserID;
  final String mqsAppSpecificSharedSecret;
  final String mqsSubscriptionExpiryDate;
  final String mqsLocalVerificationData;
  final String mqsPackageName;
  final String mqsPurchaseID;
  final String mqsServerVerificationData;
  final String mqsSource;
  final String mqsSubscriptionActivePlan;
  final String mqsSubscriptionPlatform;
  final String mqsTransactionID;
  final String mqsSubscriptionStatus;
  final String mqsCreatedTimestamp;
  final String mqsUpdateTimestamp;

  UserSubscriptionReceiptModel(
      {required this.mqsFirebaseUserID,
      required this.mqsMONGODBUserID,
      required this.mqsAppSpecificSharedSecret,
      required this.mqsSubscriptionExpiryDate,
      required this.mqsLocalVerificationData,
      required this.mqsPackageName,
      required this.mqsPurchaseID,
      required this.mqsServerVerificationData,
      required this.mqsSource,
      required this.mqsSubscriptionActivePlan,
      required this.mqsSubscriptionPlatform,
      required this.mqsTransactionID,
      required this.mqsSubscriptionStatus,
      required this.mqsCreatedTimestamp,
      required this.mqsUpdateTimestamp});

  UserSubscriptionReceiptModel.fromJson(Map json)
      :
        mqsFirebaseUserID = json['mqsFirebaseUserID'] ?? json['isFirebaseUserID'] ?? "",
        mqsMONGODBUserID = json['mqsMONGODBUserID'] ?? json['isMONGODBUserID'] ?? "",
        mqsAppSpecificSharedSecret = json['mqsAppSpecificSharedSecret'] ?? "",
        mqsSubscriptionExpiryDate = json['mqsSubscriptionExpiryDate'] ?? json['mqsExpiryDate'] ?? "",
        mqsLocalVerificationData = json['mqsLocalVerificationData'] ?? "",
        mqsPackageName = json['mqsPackageName'] ?? "",
        mqsPurchaseID = json['mqsPurchaseID'] ?? "",
        mqsServerVerificationData = json['mqsServerVerificationData'] ?? "",
        mqsSource = json['mqsSource'] ?? "",
        mqsSubscriptionActivePlan = json['mqsSubscriptionActivePlan'] ?? "",
        mqsSubscriptionPlatform = json['mqsSubscriptionPlatform'] ?? "",
        mqsTransactionID = json['mqsTransactionID'] ?? "",
        mqsSubscriptionStatus = json['mqsSubscriptionStatus'] ??
            json['mqsUserSubscriptionStatus'] ??
            "",
        mqsCreatedTimestamp = json['mqsCreatedTimestamp'] ?? "",
        mqsUpdateTimestamp = json['mqsUpdateTimestamp'] ?? "";


  Map<String, dynamic> toJson() {
    return {
      'mqsFirebaseUserID': mqsFirebaseUserID,
      'mqsMONGODBUserID': mqsMONGODBUserID,
      'mqsAppSpecificSharedSecret': mqsAppSpecificSharedSecret,
      'mqsSubscriptionExpiryDate': mqsSubscriptionExpiryDate,
      'mqsLocalVerificationData': mqsLocalVerificationData,
      'mqsPackageName': mqsPackageName,
      'mqsPurchaseID': mqsPurchaseID,
      'mqsServerVerificationData': mqsServerVerificationData,
      'mqsSource': mqsSource,
      'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      'mqsSubscriptionPlatform': mqsSubscriptionPlatform,
      'mqsTransactionID': mqsTransactionID,
      'mqsSubscriptionStatus': mqsSubscriptionStatus,
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'mqsUpdateTimestamp': mqsUpdateTimestamp,
    };
  }
}
