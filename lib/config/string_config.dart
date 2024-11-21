class StringConfig {
  static const String mqsAdminPortalWeb = "MQS Admin Portal Web";
  static const String ok = "OK";

  static final login = Login();
  static final regExp = RefExp();
  static final firebase = Firebase();
  static final validation = Validation();
  static final dashboard = Dashboard();
  static final csv = CSV();
  static final mqsDashboard = MQSDashboard();
  static final reporting = Reporting();
  static final home = Home();
  static final teamChart = TeamChart();
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
  final String addEnterprise = "Add Enterprise";
  final String editEnterprise = "Edit Enterprise";
  final String searchUserIdNameEmail = "Search User ID, Name etc.";
  final String id = "id";
  final String mqsEnterPriseCode = "Enterprise Code";
  final String rowsPerPage = "Rows per page:";
  final String of = "of";
  final String add = "Add";
  final String cancel = "Cancel";
  final String subscription = "Subscription";
  final String enterSubscription = "Enter subscription";
  final String enterId = "Enter id";
  final String enterCode = "Enter code";
  final String mqsEnterPriseName = "Enterprise Name";
  final String enterName = "Enter name";
  final String mqsSubscriptionExpiryDate = "Subscription Expiry Date";
  final String enterExpiryDate = "Enter expiry date";
  final String mqsEmployeeEmailList = "Employee Email List";
  final String emailAddress = "Email address";
  final String enterEmailAddress = "Enter email address";
  final String mqsCommonLogin = "Common Login";
  final String isSignedUp = "Is Signed Up";
  final String trueText = "True";
  final String falseText = "False";
  final String firstName = "First Name";
  final String lastName = "Last Name";
  final String email = "Email";
  final String mqsEnterpriseLocationDetails = "Enterprise Location Details";
  final String address = "Address";
  final String enterAddress = "Enter address";
  final String pinCode = "Pin code";
  final String enterPinCode = "Enter pin code";
  final String mqsEnterprisePOCs = "Enterprise POCs";
  final String name = "Name";
  final String phoneNumber = "Phone Number";
  final String enterPhoneNumber = "Enter phone number";
  final String edit = "Edit";
  final String delete = "Delete";
  final String yesDelete = "Yes, Delete";
  final String areYouSureYouWantToDeleteThis =
      "Are you sure you want to Delete this";
  final String filterByField = "Filter By Field";
  final String selectCondition = "Select Condition";
  final String sortResults = "Sort Results";
  final String addCondition = "Add Condition";
  final String ascending = "Ascending";
  final String descending = "Descending";
  final String apply = "Apply";
  final String reset = "Reset";
  final String enterValue = "Enter value";
  final String userId = "User ID";
  final String userName = "User Name";
  final String about = "About";
  final String aboutValue = "AboutValue";
  final String country = "Country";
  final String countryValue = "CountryValue";
  final String pronouns = "Pronouns";
  final String pronounsValue = "PronounsValue";
  final String userImage = "UserImage";
  final String isEnterPriseUser = "IsEnterPriceUser";
  final String isFirebaseUserId = "IsFirebaseUserId";
  final String isMongoDBUserId = "IsMONGODBUserId";
  final String isRegister = "IsRegister";
  final String loginWith = "LoginWith";
  final String mqsExpiryDate = "mqsExpiryDate";
  final String mqsSubscriptionActivePlan = "mqsSubscriptionActivePlan";
  final String mqsSubscriptionPlatform = "mqsSubscriptionPlatform";
  final String mqsSubscriptionStatus = "mqsSubscriptionStatus";
  final String onboardingData = "onboardingData";
  final String checkINValue = "Check IN Value";
  final String checkInScore = "checkInScore";
  final String mqsCINValue = "mqsCINValue";
  final String mqsTimestamp = "mqsTimestamp";
  final String demoGraphicValue = "Demographic Value";
  final String currentSelectedAnswer = "currentSelectedAnswer";
  final String selectedIndex = "selectedIndex";
  final String scenesValue = "Scenes Value";
  final String wOLValue = "WOL Value";
  final String family = "family";
  final String finance = "finance";
  final String fun = "fun";
  final String health = "health";
  final String mqsTimeStamp = "mqsTimeStamp";
  final String purpose = "purpose";
  final String relationship = "relationship";
  final String social = "social";
  final String work = "work";
  final String mqsSceneID = "mqsSceneID";
  final String mqsSceneOptionGrScore = "mqsSceneOptionGrScore";
  final String mqsSceneOptionText = "mqsSceneOptionText";
  final String mqsSceneOptionWeight = "mqsSceneOptionWeight";
  final String mqsSceneStScore = "mqsSceneStScore";
  final String mqsSceneStmt = "mqsSceneStmt";
  final String mqsUserOBRegDate = "mqsUserOBRegDate";
  final String mqsUserOBSceneScore = "mqsUserOBSceneScore";
  final String equalTo = "(==) equal to";
  final String notEqualTo = "(!=) not equal to";
  final String greaterThan = "(>) greater than";
  final String greaterThanEqualTo = "(>=) greater than or equal to";
  final String lessThan = "(<) less than";
  final String lessThanEqualTo = "(<=) less than or equal to";
  final String noDataFound = "No data found";
  final String enterpriseCollection = "enterprise_collection";
  final String invalidCSVFile = "Invalid CSV file";
}

class RefExp {
  final String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}

class Validation {
  final String plsEnterEmail = "Please enter email address";
  final String plsEnterValidEmail = "Please enter valid email address";
  final String plsEnterPassword = "Please enter password";
  final String plsEnter = "Please enter ";
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

class CSV {
  final String subscription = "Subscription";
  final String mqsEmployeeEmailListEmail = "mqsEmployeeEmailList__email";
  final String mqsEmployeeEmailListFirstName =
      "mqsEmployeeEmailList__firstName";
  final String mqsEmployeeEmailListIsSignedUp =
      "mqsEmployeeEmailList__isSignedUp";
  final String mqsEmployeeEmailListLastName = "mqsEmployeeEmailList__lastName";
  final String mqsEmployeeEmailListMqsCommonLogin =
      "mqsEmployeeEmailList__mqsCommonLogin";
  final String mqsEnterpriseCode = "mqsEnterpriseCode";
  final String mqsEnterpriseLocationDetailsAddress =
      "mqsEnterpriseLocationDetails__address";
  final String mqsEnterpriseLocationDetailsPinCode =
      "mqsEnterpriseLocationDetails__pinCode";
  final String mqsEnterpriseName = "mqsEnterpriseName";
  final String mqsEnterprisePOCsAddress = "mqsEnterprisePOCs__address";
  final String mqsEnterprisePOCsEmail = "mqsEnterprisePOCs__email";
  final String mqsEnterprisePOCsName = "mqsEnterprisePOCs__name";
  final String mqsEnterprisePOCsPhoneNumber = "mqsEnterprisePOCs__phoneNumber";
  final String mqsSubscriptionExpiryDat = "mqsSubscriptionExpiryDate";
  final String employeeEmails = "Employee Emails";
  final String enterpriseLocation = "Enterprise Location";
  final String pocs = "POCs";
}

class MQSDashboard {
  final String home = "Home";
  final String onboarding = "Onboarding";
  final String communication = "Communication";
  final String training = "Training";
  final String survey = "Survey";
  final String space = "Space";
  final String reporting = "Reporting";
  final String documents = "Documents";
  final String chat = "Chat";
  final String profile = "Profile";
  final String settings = "Settings";
  final String pathway = "Pathway";
  final String challenge = "Challenge";
}

class Reporting {
  final String lastUpdate = "Last update: 26 Dec 2023, 03:34 pm";
  final String entity = "Entity";
  final String unit = "Unit";
  final String function = "Function";
  final String wellAboveScore = "WellAbove Score";
  final String strategy = "Strategy";
  final String execution = "Execution";
  final String outcome = "Outcome";
  final String wellAboveIndicators = "WellAbove Indicators";
  final String leadership = "Leadership";
  final String management = "Management";
  final String team = "Team";
  final String employees = "Employees";
  final String advocacy = "Advocacy";
  final String awareness = "Awareness";
  final String acceptance = "Acceptance";
  final String aptitude = "Aptitude";
  final String adoption = "Adoption";
  final String wellAboveDrivers = "WellAbove Drivers";
  final String trainingProgram = "Training Program";
  final String leadershipSupport = "Leadership Support";
  final String recognitionProgram = "Recognition Program";
  final String may = "May";
  final String june = "June";
  final String july = "July";
}

class Home {
  final String wellAbove = "WELLABOVE";
  final String tm = "TM";
  final String search = "Search...";
}

class TeamChart {
  final String teamChart = "Team Chart";
  final String lastUpdate = "Last update: 26 Dec 2023, 03:34 pm";
  final String teamMyQEngagement = "Team MyQ Engagement";
  final String teamMyQEngagementDesc =
      "Through consistent usage of MyQ the team has been building mind skills and applying them to the team’s ways of working. The team hit an all time high of MyQ log in of 25 days in a row!";
  final String dailyLogIn = "Daily log-in";
  final String teamDevelopment = "Team Development";
  final String learn = "Learn";
  final String practice = "Practice";
  final String reflect = "Reflect";
  final String teamConnection = "Team Connection";
  final String teamGoals = "Team Goals";
  final String teamGoalsDesc =
      "Team exceeded the goals set for July in recording Moments That Matter, Bravo ...";
  final String ofPathways = "# of Pathways";
  final String ofMomentsThatMatter = "# of Moments That Matter";
  final String showMore = "Show more";
}
