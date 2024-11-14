class EnterpriseModel {
  final String subscription;
  final String id;
  final List<MqsEmployeeEmailModel> mqsEmployeeEmailList;
  final String mqsEnterpriseCode;
  final MqsEnterpriseLocationDetails mqsEnterpriseLocationDetails;
  final String mqsEnterpriseName;
  final List<MqsEnterprisePOC> mqsEnterprisePOCs;
  final String mqsSubscriptionExpiryDate;

  EnterpriseModel({
    required this.subscription,
    required this.id,
    required this.mqsEmployeeEmailList,
    required this.mqsEnterpriseCode,
    required this.mqsEnterpriseLocationDetails,
    required this.mqsEnterpriseName,
    required this.mqsEnterprisePOCs,
    required this.mqsSubscriptionExpiryDate,
  });

  EnterpriseModel.fromJson(Map json)
      : id = json['_id'] ?? "",
        subscription = json['Subscription'] ?? "",
        mqsEmployeeEmailList = json['mqsEmployeeEmailList'] != null
            ? List<MqsEmployeeEmailModel>.from(
                ((json['mqsEmployeeEmailList'] ?? []) as List)
                    .map((model) => MqsEmployeeEmailModel.fromJson(model)))
            : [],
        mqsEnterpriseCode = json['mqsEnterpriseCode'] ?? "",
        mqsEnterpriseLocationDetails =
            json['mqsEnterpriseLocationDetails'] != null
                ? MqsEnterpriseLocationDetails.fromJson(
                    json['mqsEnterpriseLocationDetails'])
                : MqsEnterpriseLocationDetails(
                    address: '',
                    pinCode: '',
                  ),
        mqsEnterpriseName = json['mqsEnterpriseName'] ?? "",
        mqsEnterprisePOCs = json['mqsEnterprisePOCs'] != null
            ? List<MqsEnterprisePOC>.from(
                ((json['mqsEnterprisePOCs'] ?? []) as List).map(
                  (model) => MqsEnterprisePOC.fromJson(model),
                ),
              )
            : [],
        mqsSubscriptionExpiryDate = json['mqsSubscriptionExpiryDate'] ?? "";

  Map<String, dynamic> toJson() => {
        '_id': id,
        'Subscription': subscription,
        'mqsEmployeeEmailList':
            mqsEmployeeEmailList.map((e) => e.toJson()).toList(),
        'mqsEnterpriseCode': mqsEnterpriseCode,
        'mqsEnterpriseLocationDetails': mqsEnterpriseLocationDetails.toJson(),
        'mqsEnterpriseName': mqsEnterpriseName,
        'mqsEnterprisePOCs': mqsEnterprisePOCs.map((e) => e.toJson()).toList(),
        'mqsSubscriptionExpiryDate': mqsSubscriptionExpiryDate,
      };
}

class MqsEmployeeEmailModel {
  String email;
  String firstname;
  bool isSignedUp;
  String lastname;
  bool mqsCommonLogin;

  MqsEmployeeEmailModel({
    required this.email,
    required this.firstname,
    required this.isSignedUp,
    required this.lastname,
    required this.mqsCommonLogin,
  });

  MqsEmployeeEmailModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] ?? "",
        firstname = json['firstName'] ?? "",
        isSignedUp = json['isSignedUp'] ?? "",
        mqsCommonLogin = json['mqsCommonLogin'] ?? false,
        lastname = json['lastName'] ?? "";

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstname,
        'isSignedUp': isSignedUp,
        'mqsCommonLogin': mqsCommonLogin,
        'lastName': lastname,
      };
}

class MqsEnterprisePOC {
  String address;
  String email;
  String name;
  String phoneNumber;

  MqsEnterprisePOC(
      {required this.address,
      required this.email,
      required this.name,
      required this.phoneNumber});

  MqsEnterprisePOC.fromJson(Map<String, dynamic> json)
      : address = json['address'] ?? "",
        email = json['email'] ?? "",
        name = json['name'] ?? "",
        phoneNumber = json['phoneNumber'] ?? "";

  Map<String, dynamic> toJson() => {
        'address': address,
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
      };
}

class MqsEnterpriseLocationDetails {
  final String address;
  final String pinCode;

  MqsEnterpriseLocationDetails({required this.address, required this.pinCode});

  MqsEnterpriseLocationDetails.fromJson(Map<String, dynamic> json)
      : address = json['address'] ?? "",
        pinCode = json['pinCode'] ?? "";

  Map<String, dynamic> toJson() => {
        'address': address,
        'pinCode': pinCode,
      };
}
