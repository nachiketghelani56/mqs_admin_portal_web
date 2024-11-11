class StringConfig {
  static const String mqsAdminPortalWeb = "MQS Admin Portal Web";
  static const String ok = "OK";

  static final login = Login();
  static final regExp = RefExp();
  static final firebase = Firebase();
  static final validation = Validation();
  static final dashboard = Dashboard();
}

class Login {
  final String loginToYourAccount = "Login To Your Account";
  final String fillBelowDetailToGetInWeb = "Fill below details to get in web.";
  final String emailID = "Email ID";
  final String password = "Password";
  final String login = "Login";
}

class Dashboard {
  final String enterprise = "Enterprise";
  final String userIAM = "User-IAM";
  final String filter = "Filter";
  final String export = "Export";
  final String addEnterprise = "Add Enterprice";
  final String searchUserIdNameEmail = "Search User ID, Name etc.";
  final String id = "_id";
  final String mqsEnterPriseCode = "mqsEnterPriseCode";
  final String rowsPerPage = "Rows per page:";
  final String of = "of";
  final String add = "Add";
  final String cancel = "Cancel";
  final String subscription = "Subscription";
  final String enterSubscription = "Enter subscription";
  final String enterId = "Enter id";
  final String enterCode = "Enter code";
  final String mqsEnterPriseName = "mqsEnterPriseName";
  final String enterName = "Enter name";
  final String mqsSubscriptionExpiryDate = "mqsSubscriptionExpiryDate";
  final String enterExpiryDate = "Enter expiry date";
  final String mqsEmployeeEmailList = "mqsEmployeeEmailList";
  final String emailAddress = "Email address";
  final String enterEmailAddress = "Enter email address";
  final String mqsCommonLogin = "mqsCommonLogin";
  final String isSignedUp = "isSignedUp";
  final String trueText = "True";
  final String falseText = "False";
  final String firstName = "First Name";
  final String lastName = "Last Name";
  final String email = "Email";
  final String mqsEnterpriseLocationDetails = "mqsEnterpriseLocationDetails";
  final String address = "Address";
  final String enterAddress = "Enter address";
  final String pinCode = "Pincode";
  final String enterPinCode = "Enter pin code";
  final String mqsEnterprisePOCs = "mqsEnterprisePOCs";
  final String name = "Name";
  final String phoneNumber = "Phone Number";
  final String enterPhoneNumber = "Enter phone number";
  final String edit = "Edit";
  final String delete = "Delete";
}

class RefExp {
  final String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}

class Validation {
  final String plsEnterEmail = "Please enter email address";
  final String plsEnterValidEmail = "Please enter valid email address";
  final String plsEnterPassword = "Please enter password";
}

class Firebase {
  final String firstName = "FirstName";
  final String lastName = "LastName";
  final String email = "Email";
  final String isFirebaseUserID = 'isFirebaseUserID';
  final String password = "password";
  final String isEnterPriseUser = "isEnterPriseUser";
  final String mqsEnterpriseCode = "mqsEnterpriseCode";
  final String enterprise = "enterprise";
  final String isRegister = "isRegister";
  final String isRegisterUserDone = "isRegisterUserDone";
  final String code = "code";
  final String enterPriseID = "enterPriseID";
  final String mqsCreatedTimestamp = "mqsCreatedTimestamp";
}
