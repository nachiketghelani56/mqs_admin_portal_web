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
  final String searchUserIdNameEmail = "Search User ID, Name, Email etc.";
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
