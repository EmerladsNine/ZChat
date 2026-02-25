
import 'dart:typed_data';

class AccountConstants {
  static const int maxUsernameLength = 20;
  static const int maxPasswordLength = 254;
  static const int maxEmailLength = 254;
  static const int minUsernameLength = 1;
  static const int minPasswordLength = 8;
  static const int minEmailLength = 5;

  static const String emailInvalidMsg = "Invalid Email";
  static const String passwordInvalidMsg = "Invalid Password";
  static const String usernameInvalidMsg = "Invalid Username";
  static bool isValidEmail(Uint8List emailUTF8)
  {
      if(emailUTF8.length < minEmailLength || emailUTF8.length > maxEmailLength)
      {
          return false;
      }
      return true;
  }
  static bool isValidUsername(Uint8List usernameUTF8)
  {
    if(usernameUTF8.length < minUsernameLength || usernameUTF8.length > maxUsernameLength)
    {
      return false;
    }
    return true;
  }

  static bool isValidPassword(Uint8List passwordUTF8)
  {
    if(passwordUTF8.length < minPasswordLength || passwordUTF8.length > maxPasswordLength)
    {
      return false;
    }
    return true;
  }
}