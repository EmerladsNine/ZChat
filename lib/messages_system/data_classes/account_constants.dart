
import 'dart:convert';
import 'dart:typed_data';

class AccountConstants {
  static const int maxUsernameLength = 20;
  static const int maxPasswordLength = 128;
  static const int maxEmailLength = 254;
  static const int minUsernameLength = 1;
  static const int minPasswordLength = 12;
  static const int minEmailLength = 5;

  static const String emailInvalidMsg = "Invalid Email";
  static const String passwordInvalidMsg = "Invalid Password";
  static const String usernameInvalidMsg = "Invalid Username";
  static bool isValidEmail(Uint8List emailBytes)
  {
      if(emailBytes.length < minEmailLength || emailBytes.length > maxEmailLength)
      {
          return false;
      }
      final email = utf8.decode(emailBytes);
      final emailRegex = RegExp(r"(^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$)");
      return emailRegex.hasMatch(email);
  }

  static bool isValidUsername(Uint8List usernameUTF8)
  {
    if(usernameUTF8.length < minUsernameLength || usernameUTF8.length > maxUsernameLength)
    {
      return false;
    }
    for (int i = 0; i < usernameUTF8.length; i++)
    {
      int c = usernameUTF8[i];
      bool isDigit = (c >= 48 && c <= 57);
      bool isUpper = (c >= 65 && c <= 90);
      bool isLower = (c >= 97 && c <= 122);
      bool isSpecial = (c == 45 || c == 95);
      if ((i == 0 || i == usernameUTF8.length - 1) && isSpecial)
      {
          return false;
      }
      if (!(isDigit || isUpper || isLower || isSpecial))
      {
        return false;
      }
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