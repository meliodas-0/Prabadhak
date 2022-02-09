import 'dart:convert';

class User {
  final String _fullname;
  final String _username;
  final String _uID;
  final List<String> _eventsParticipated;
  final List<String> _eventsOrganised;

  User({
    required String name,
    required String uID,
    required String username,
    List<String>? eventsParticipated,
    List<String>? eventsOrganised,
  })  : _fullname = name,
        _uID = uID,
        _username = username,
        _eventsParticipated = eventsParticipated ?? [],
        _eventsOrganised = eventsOrganised ?? [];
  String get fullname => _fullname;

  String get uID => _uID;

  String get username => _username;

  List<String> get interests => _eventsParticipated;

  List<String> get eventsOrganised => _eventsOrganised;

  factory User.fromJson(Map<String, dynamic> data) => User(
      name: data['fullname'] as String,
      uID: data['user_id'].toString(),
      username: data['username'] as String,
      eventsOrganised: _getList(data['eventsOrganized']),
      eventsParticipated: _getList(data['eventsParticipated'])
      //TODO: change this interests to events_participated in backend.
      );
  static List<String> _getList(List<dynamic> data) {
    List<String> list = [];

    for (var d in data) {
      list.add(d.toString());
    }

    return list;
  }

  String toJson() {
    Map<String, dynamic> map = {
      'fullname': _fullname,
      'user_id': _uID,
      'username': _username,
      'eventsOrganized': _eventsOrganised,
      'eventsParticipated': _eventsParticipated
    };
    return jsonEncode(map);
  }
}
