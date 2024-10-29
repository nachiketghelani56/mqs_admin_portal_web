import 'package:mqs_admin_portal_web/config/string_config.dart';

class Validator {
  static String? emailValidator(String text) {
    if (text.isEmpty) {
      return StringConfig.validation.plsEnterEmail;
    } else if (!RegExp(StringConfig.regExp.emailRegExp).hasMatch(text)) {
      return StringConfig.validation.plsEnterValidEmail;
    }
    return null;
  }

  static String? passwordValidator(String text) {
    if (text.isEmpty) {
      return StringConfig.validation.plsEnterPassword;
    }
    return null;
  }
}
