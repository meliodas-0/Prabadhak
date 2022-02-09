import 'package:shared_preferences/shared_preferences.dart';

const String ACCESS_TOKEN = 'access_token';
const String USER_MAP = 'user_map';
const String UID = 'uid';

void setStringIntoCache(String key, String value) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.setString(key, value);
}

void setListIntoCache(String key, List<String> value) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.setStringList(key, value);
}

void removeStringFromCache(String key) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.remove(key);
}

void setBooleanIntoCache(String key, bool value) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.setBool(key, value);
}

void setIntIntoCache(String key, int value) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.setInt(key, value);
}

void setSocietyUrlIntoCache(String societyUrl) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.setString('baseUrl', societyUrl);
}

Future<String> getStringFromCache(String key) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  return _sharedPreferences.getString(key) ?? '';
}

Future<List<String>> getListFromCache(String key) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  return _sharedPreferences.getStringList(key) ?? [];
}

Future<int> getIntFromCache(String key) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  return _sharedPreferences.getInt(key) ?? 0;
}

Future<bool> getBooleanFromCache(String key) async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  return _sharedPreferences.getBool(key) ?? true;
}
