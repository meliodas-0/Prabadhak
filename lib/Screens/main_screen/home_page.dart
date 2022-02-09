import 'package:flutter/material.dart';
import 'package:prabandhak/Screens/main_screen/meeting.dart';
import 'package:prabandhak/helpers/constants.dart';
import 'package:prabandhak/helpers/methods_helper.dart';
import 'package:prabandhak/helpers/network/api_helper.dart';
import 'package:prabandhak/models/event.dart';
import 'package:prabandhak/models/user.dart';
import 'package:prabandhak/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({
    Key? key,
  }) : super(key: key);

  late List<Event> events;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return FutureBuilder(
        future: ApiHelper.getAllSessions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          if (snapshot.data.runtimeType == bool) {
            return Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/wow-such-empty.jpg')));
          }
          events = Event.getList(snapshot.data as List);
          return ListView.builder(
            itemBuilder: (context, index) {
              bool isNotRegistered = !events[index].isParticipant(user);

              return ListTile(
                  title: Text(events[index].getTopic),
                  subtitle: Text(
                    events[index].getDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: Hero(
                    tag: index,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: getBannerImage(events[index].image),
                      ),
                    ),
                  ),
                  onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) => ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Container(
                                color: brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.grey.shade900,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (events[index].image.isNotEmpty) ...[
                                      getBannerImage(events[index].image),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                    ListTile(
                                      title: Text(events[index].getTopic),
                                      subtitle: Text(
                                          '${events[index].getDescription}\n Starting from ${formatDateTime(events[index].getStartTime)} till ${formatDateTime(events[index].getEndTime)}'),
                                      trailing: events[index].isLive
                                          ? Column(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all<
                                                                        EdgeInsets>(
                                                                    EdgeInsets
                                                                        .zero)),
                                                    child: Text('Join'),
                                                    onPressed: () =>
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Meeting(
                                                                event: events[
                                                                    index],
                                                              ),
                                                            )),
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: Icon(
                                                    Icons.circle,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : null,
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: isNotRegistered
                                          ? ElevatedButton(
                                              child: const Text(
                                                  'Sign me up for the event'),
                                              onPressed: () => setState(() {
                                                isNotRegistered = false;
                                                events[index]
                                                    .addParticipant(user.uID);
                                              }),
                                            )
                                          : TextButton(
                                              onPressed: () => setState(() {
                                                isNotRegistered = true;
                                                events[index].removeParticipant(
                                                    user.uID);
                                              }),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  ),
                                                  Text('Already Registered'),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ));
            },
            itemCount: events.length,
            padding: const EdgeInsets.only(bottom: 50.0),
          );
        });
  }

  getBannerImage(String image) {
    return Image.network(
      image,
      errorBuilder: (context, error, stackTrace) => Image.network(
          'https://res.cloudinary.com/dwzmsvp7f/image/fetch/q_75,f_auto,w_1316/https%3A%2F%2Fmedia.insider.in%2Fimage%2Fupload%2Fc_crop%2Cg_custom%2Fv1519627962%2Fvltlogy23k1iid9pjffx.jpg'),
    );
  }
}
