class MQSMyQUserSubscriptionReceiptModel {
  String? id;
  String? mqsFirebaseUserID;
  String? mqsMONGODBUserID;
  String? mqsAppSpecificSharedSecret;
  String? mqsSubscriptionExpiryTimestamp;
  String? mqsLocalVerificationData;
  String? mqsPackageName;
  String? mqsPurchaseID;
  String? mqsServerVerificationData;
  String? mqsSource;
  String? mqsSubscriptionActivePlan;
  String? mqsSubscriptionPlatform;
  String? mqsTransactionID;
  String? mqsSubscriptionStatus;
  String? mqsCreatedTimestamp;
  String? mqsUpdatedTimestamp;
  String? mqsSubscriptionActivationTimestamp;
  String? mqsSubscriptionRenewalTimestamp;

  MQSMyQUserSubscriptionReceiptModel(
      {
        this.id,this.mqsFirebaseUserID,
        this.mqsMONGODBUserID,
        this.mqsAppSpecificSharedSecret,
        this.mqsSubscriptionExpiryTimestamp,
        this.mqsLocalVerificationData,
        this.mqsPackageName,
        this.mqsPurchaseID,
        this.mqsServerVerificationData,
        this.mqsSource,
        this.mqsSubscriptionActivePlan,
        this.mqsSubscriptionPlatform,
        this.mqsTransactionID,
        this.mqsSubscriptionStatus,
        this.mqsCreatedTimestamp,
        this.mqsUpdatedTimestamp,
        this.mqsSubscriptionActivationTimestamp,
        this.mqsSubscriptionRenewalTimestamp,
      });

  MQSMyQUserSubscriptionReceiptModel.fromJson(Map json, String docId)
      :
        id =docId,
        mqsFirebaseUserID = json['mqsFirebaseUserID'] ?? json['isFirebaseUserID'] ?? "",
        mqsMONGODBUserID = json['mqsMONGODBUserID'] ?? json['isMONGODBUserID'] ?? "",
        mqsAppSpecificSharedSecret = json['mqsAppSpecificSharedSecret'] ?? "",
        mqsSubscriptionExpiryTimestamp = json['mqsSubscriptionExpiryTimestamp'] ?? json['mqsSubscriptionExpiryDate'] ?? json['mqsExpiryDate'] ?? "",
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
        mqsUpdatedTimestamp = json['mqsUpdatedTimestamp'] ?? json['mqsUpdateTimestamp'] ?? "",
        mqsSubscriptionActivationTimestamp = json['mqsSubscriptionActivationTimestamp'] ?? "",
        mqsSubscriptionRenewalTimestamp = json['mqsSubscriptionRenewalTimestamp'] ?? "";


  Map<String, dynamic> toJson() {
    return {
      'mqsFirebaseUserID': mqsFirebaseUserID,
      'mqsMONGODBUserID': mqsMONGODBUserID,
      'mqsAppSpecificSharedSecret': mqsAppSpecificSharedSecret,
      'mqsSubscriptionExpiryTimestamp': mqsSubscriptionExpiryTimestamp,
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
      'mqsUpdatedTimestamp': mqsUpdatedTimestamp,
      'mqsSubscriptionActivationTimestamp': mqsSubscriptionActivationTimestamp,
      'mqsSubscriptionRenewalTimestamp': mqsSubscriptionRenewalTimestamp,
    };
  }
}