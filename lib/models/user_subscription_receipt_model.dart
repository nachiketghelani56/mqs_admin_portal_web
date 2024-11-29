class UserSubscriptionReceiptModel {
  final String isFirebaseUserID;
  final String isMONGODBUserID;
  final String mqsAppSpecificSharedSecret;
  final String mqsExpiryDate;
  final String mqsLocalVerificationData;
  final String mqsPackageName;
  final String mqsPurchaseID;
  final String mqsServerVerificationData;
  final String mqsSource;
  final String mqsSubscriptionActivePlan;
  final String mqsSubscriptionPlatform;
  final String mqsTransactionID;
  final String mqsUserSubscriptionStatus;

  UserSubscriptionReceiptModel(
      {required this.isFirebaseUserID,
      required this.isMONGODBUserID,
      required this.mqsAppSpecificSharedSecret,
      required this.mqsExpiryDate,
      required this.mqsLocalVerificationData,
      required this.mqsPackageName,
      required this.mqsPurchaseID,
      required this.mqsServerVerificationData,
      required this.mqsSource,
      required this.mqsSubscriptionActivePlan,
      required this.mqsSubscriptionPlatform,
      required this.mqsTransactionID,
      required this.mqsUserSubscriptionStatus});

  UserSubscriptionReceiptModel.fromJson(Map json)
      : isFirebaseUserID = json['isFirebaseUserID'] ?? "",
        isMONGODBUserID = json['isMONGODBUserID'] ?? "",
        mqsAppSpecificSharedSecret = json['mqsAppSpecificSharedSecret'] ?? "",
        mqsExpiryDate = json['mqsExpiryDate'] ?? "",
        mqsLocalVerificationData = json['mqsLocalVerificationData'] ?? "",
        mqsPackageName = json['mqsPackageName'] ?? "",
        mqsPurchaseID = json['mqsPurchaseID'] ?? "",
        mqsServerVerificationData = json['mqsServerVerificationData'] ?? "",
        mqsSource = json['mqsSource'] ?? "",
        mqsSubscriptionActivePlan = json['mqsSubscriptionActivePlan'] ?? "",
        mqsSubscriptionPlatform = json['mqsSubscriptionPlatform'] ?? "",
        mqsTransactionID = json['mqsTransactionID'] ?? "",
        mqsUserSubscriptionStatus = json['mqsUserSubscriptionStatus'] ?? "";

  Map<String, dynamic> toJson() {
    return {
      'isFirebaseUserID': isFirebaseUserID,
      'isMONGODBUserID': isMONGODBUserID,
      'mqsAppSpecificSharedSecret': mqsAppSpecificSharedSecret,
      'mqsExpiryDate': mqsExpiryDate,
      'mqsLocalVerificationData': mqsLocalVerificationData,
      'mqsPackageName': mqsPackageName,
      'mqsPurchaseID': mqsPurchaseID,
      'mqsServerVerificationData': mqsServerVerificationData,
      'mqsSource': mqsSource,
      'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      'mqsSubscriptionPlatform': mqsSubscriptionPlatform,
      'mqsTransactionID': mqsTransactionID,
      'mqsUserSubscriptionStatus': mqsUserSubscriptionStatus,
    };
  }
}
