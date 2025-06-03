import 'package:shared_preferences/shared_preferences.dart';

class PreferenceData {
  static PreferenceData? _preferenceData;
  static SharedPreferences? _preferences;

  static String token = "token";
  static String fcmToken = "fcm_token";
  static String userInfo = "user_info";
  static String userType = "user_type";

  static Future getInstance() async {
    if (_preferenceData == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = PreferenceData._();
      await secureStorage._init();
      _preferenceData = secureStorage;
    }
    return _preferenceData;
  }

  PreferenceData._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getToken() {
    if (_preferences == null) return '';
    return _preferences!.getString(token) ?? '';
  }

  static Future? setToken(String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(token, value);
  }
  static String getFCMToken() {
    if (_preferences == null) return '';
    return _preferences!.getString(fcmToken) ?? '';
  }

  static Future? setFCMToken(String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(fcmToken, value);
  }

  static String getUserInfo() {
    if (_preferences == null) return '';
    return _preferences!.getString(userInfo) ?? '';
  }

  static Future? setUserInfo(String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(userInfo, value);
  }

  static String getUserType() {
    if (_preferences == null) return '';
    return _preferences!.getString(userType) ?? '';
  }

  static Future? setUserType(String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(userType, value);
  }


  static void clearData() {
    PreferenceData.setToken("");
    PreferenceData.setUserInfo('');
    PreferenceData.setUserType('');
  }
}
