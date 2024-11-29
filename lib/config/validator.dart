import 'package:mqs_admin_portal_web/config/string_config.dart';

class Validator {
  static String? emailValidator(String text, String field) {
    if (text.isEmpty) {
      return StringConfig.validation.pleaseProvideYour +
          field +
          StringConfig.validation.toProceed;
    } else if (!RegExp(StringConfig.regExp.emailRegExp).hasMatch(text)) {
      return StringConfig.validation.pleaseProvideValidEmail;
    }
    return null;
  }

  static String? passwordValidator(String text, String field) {
    if (text.isEmpty) {
      return StringConfig.validation.pleaseProvideYour +
          field +
          StringConfig.validation.toProceed;
    }
    return null;
  }

  static String? emptyValidator(String text, String field) {
    if (text.isEmpty) {
      return StringConfig.validation.pleaseProvideYour +
          field +
          StringConfig.validation.toProceed;
    }
    return null;
  }
}
