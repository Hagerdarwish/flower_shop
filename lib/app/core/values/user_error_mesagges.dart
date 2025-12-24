import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';

class UserErrorMessages {
  // Server Errors //////////////////////////////////////////////////////////////////////

  static String get connectionTimeout =>
      LocaleKeys.errors_connectionTimeout.tr();

  static String get noInternet =>
      LocaleKeys.errors_noInternet.tr();

  static String get unauthorized =>
      LocaleKeys.errors_unauthorized.tr();

  static String get serverError =>
      LocaleKeys.errors_serverError.tr();

  static String get unknownError =>
      LocaleKeys.errors_unknownError.tr();

  // Validator Errors ////////////////////////////////////////////////////////////////////

  static String get invalidEmail =>
      LocaleKeys.errors_invalidEmail.tr();

  static String get weakPassword =>
      LocaleKeys.errors_weakPassword.tr();

  static String get emailRequired =>
      LocaleKeys.errors_emailRequired.tr();

  static String get passwordRequired =>
      LocaleKeys.errors_passwordRequired.tr();

  static String get passwordWithCapital =>
      LocaleKeys.errors_passwordWithCapital.tr();

  static String get passwordWithNumber =>
      LocaleKeys.errors_passwordWithNumber.tr();

  static String get passwordDontMatch =>
      LocaleKeys.errors_passwordDontMatch.tr();

  static String get confirmPassword =>
      LocaleKeys.errors_confirmPassword.tr();

  static String get phoneRequired =>
      LocaleKeys.errors_phoneRequired.tr();

  static String get invalidNumber =>
      LocaleKeys.errors_invalidNumber.tr();

  static String get required =>
      LocaleKeys.errors_required.tr();

  static String get least3Characters =>
      LocaleKeys.errors_least3Characters.tr();

  static String get least6Characters =>
      LocaleKeys.errors_least6Characters.tr();

  static String get invalidName =>
      LocaleKeys.errors_invalidName.tr();
}
