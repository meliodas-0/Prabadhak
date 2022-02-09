import 'dart:convert';

import 'package:http/http.dart';
import 'package:prabandhak/helpers/shared_preference.dart';

class ApiHelper {
  static late Response _response;
  static late Map<String, dynamic> _data;
  static const _serverName = 'http://localhost:8000';
  static const _api = '/api';
  static const _event = '/event';
  static const _session = '/session';
  static const _auth = '/auth';
  static const _register = '/register';
  static const _token = '/token';
  static const _for_session = '/for_session';
  static const _ticket = '/ticket';

  static Future<String?> getAccessCode(String username, String password) async {
    String? accessCode;

    // const _path = _serverName + _api + _token;
    // const p = 'http://localhost:8000/api/token/';

    Uri _uri = getURI([
      _serverName,
      _api,
      _token,
    ]);
    _response = await post(_uri, body: {
      'username': username,
      'password': password,
    });
    if (_response.statusCode == 200) {
      getData();
      accessCode = _data['access'];
    }

    return accessCode;
  }

  static Future<bool> registerNewUser(
    String username,
    String password,
    String fullName,
  ) async {
    bool? result;

    Uri uri = getURI([
      _serverName,
      _api,
      _auth,
      _register,
    ]);

    _response = await post(uri, body: {
      'username': username,
      'password': password,
      'fullname': fullName,
      'interests': [1, 2, 3], //TODO: remove this later
    });

    if (isResponseOK()) {
      result = true;
    }

    return Future.value(result);
  }

  static getAllSessions() async {
    Uri uri = getURI([
      _serverName,
      _api,
      _event,
      _session,
    ]);
    String accessToken = await getStringFromCache(ACCESS_TOKEN);
    _response = await get(uri, headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (isResponseOK()) {
      getData();
      print(_data['data']);
      return _data['data'];
    }
    return false;
  }

  static createNewSession(Map<String, dynamic> form) async {
    Uri uri = getURI([_serverName, _api, _event, _session]);
    String accessToken = await getStringFromCache(ACCESS_TOKEN);
    _response = await post(uri, body: form, headers: {
      'Authorization': 'Bearer $accessToken',
    });
    print(_response.body);
  }

  static getSessionDetails(String eid) async {
    Uri uri = getURI([
      _serverName,
      _api,
      _event,
      _session,
      '/$eid',
    ]);
    String accessToken = await getStringFromCache(ACCESS_TOKEN);
    _response = await get(uri, headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (isResponseOK()) {
      getData();
      return _data['data'];
    }
    return false;
  }

  static bool isResponseOK() => _response.statusCode / 100 == 2;

  static void getData() => _data = jsonDecode(_response.body);

  static Uri getURI(List<String> pathSegments) {
    String s = '';

    for (String pathSegment in pathSegments) {
      s += pathSegment;
    }

    s += '/';

    Uri uri = Uri.parse(s);
    return uri;
  }
}
