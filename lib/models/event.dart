import 'package:intl/intl.dart';
import 'package:prabandhak/models/user.dart';

class Event {
  final String _topic;
  final String _image;
  final DateTime _startTime;
  final DateTime _endTime;
  final String _presenter;
  final String description;
  final List<String> _participants;
  final String _eId;
  final int _totalTickets;
  final int _ticketsSold;

  Event({
    List<String>? participants,
    String? eId,
    DateTime? startTime,
    DateTime? endTime,
    this.description = 'This is event description',
    String? presenter,
    String topic = 'Topic',
    int totalTickets = 50,
    int ticketsSold = 0,
    String image =
        'https://res.cloudinary.com/dwzmsvp7f/image/fetch/q_75,f_auto,w_1316/https%3A%2F%2Fmedia.insider.in%2Fimage%2Fupload%2Fc_crop%2Cg_custom%2Fv1519627962%2Fvltlogy23k1iid9pjffx.jpg',
  })  : _participants = participants ?? [],
        _startTime = startTime ?? DateTime.now(),
        _endTime = endTime ?? DateTime.now(),
        _presenter = presenter ?? 'uID',
        _topic = topic,
        _image = image,
        _eId = eId ?? DateTime.now().toString(),
        _ticketsSold = ticketsSold,
        _totalTickets = totalTickets;

  String get image => _image;

  String get getTopic => _topic;

  DateTime get getStartTime => _startTime;

  String get getPresenter => _presenter;

  String get getDescription => description;

  String get eid => _eId;

  DateTime get getEndTime => _endTime;

  bool get isLive =>
      _startTime.isBefore(DateTime.now()) && _endTime.isAfter(DateTime.now());

  static List<Event> getList(List data) {
    List<Event> events = [];
    DateFormat.ABBR_MONTH_DAY;

    for (Map<String, dynamic> map in data) {
      events.add(Event(
        eId: map['id'].toString(),
        presenter: map['createdBy'].toString(),
        startTime: DateFormat('d-MMM-y hh:mm').parse(map['startTime']),
        endTime: DateFormat('d-MMM-y hh:mm').parse(map['endTime']),
        topic: map['name'],
        description: map['description'],
        image: map['image'],
        ticketsSold: map['ticketsSold'],
        totalTickets: map['totalTickets'],
      ));
    }

    return events;
  }

  bool isParticipant(User user) => _participants.contains(user.uID);

  void addParticipant(String uID) => _participants.add(uID);

  void removeParticipant(String uID) => _participants.remove(uID);
}
