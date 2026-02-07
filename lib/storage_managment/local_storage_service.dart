import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
