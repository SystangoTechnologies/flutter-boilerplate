import 'package:validators/validators.dart';
import 'package:contact_list_demo/constants/strings.dart';

class EmailFormValidator {
  static String validate(String value){
    final isEmailValid = isEmail(value);   
    if (value.isEmpty) {
      return EMAIL_EMPTY_ERROR_MESSAGE;
    } else if (!isEmailValid) {
      return EMAIL_NOT_VALID_ERROR_MESSAGE;
    }
    return null;
  }
}

class PasswordFormValidator {
  static String validate(String value){
    if (value.isEmpty) {
      return PASSWORD_EMPTY_ERROR_MESSAGE;
    } else if(value.length<6) {
      return PASSWORD_NOT_VALID_ERROR_MESSAGE;
    }
    return null;
  }
}
