// This is a basic Flutter unit test.
import 'package:flutter_test/flutter_test.dart';
import 'package:contact_list_demo/utils/validators.dart';
import 'package:contact_list_demo/constants/strings.dart';

void main() {

  test('empty email in email field in login form', () {
    var result = EmailFormValidator.validate('');
    expect(result, EMAIL_EMPTY_ERROR_MESSAGE);
  });

  test('wrong email format in email field in login form', () {
    var result = EmailFormValidator.validate('test.com');
    expect(result, EMAIL_NOT_VALID_ERROR_MESSAGE);
  });

  test('correct email format in email field in login form', () {
    var result = EmailFormValidator.validate('test@gmail.com');
    expect(result, null);
  });

  test('empty text in password field in login form', () {
    var result = PasswordFormValidator.validate('');
    expect(result, PASSWORD_EMPTY_ERROR_MESSAGE);
  });

  test('short text in password field in login form', () {
    var result = PasswordFormValidator.validate('test');
    expect(result, PASSWORD_NOT_VALID_ERROR_MESSAGE);
  });

  test('valid text in password field in login form', () {
    var result = PasswordFormValidator.validate('test123');
    expect(result, null);
  });
}
