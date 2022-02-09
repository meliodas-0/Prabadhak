import 'package:flutter/material.dart';
import 'package:prabandhak/Screens/main_screen/meeting.dart';

class SearchPageWidget extends StatelessWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              decoration: InputDecoration(hintText: 'Search'),
            ),
            trailing: TextButton(
              child: Text('Search'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Center(
                child: ElevatedButton(
              child: Text('Join meeting or create one.'),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Meeting(
                      isFromSearch: true,
                    ),
                  )),
            )),
          ),
        ],
      ),
    );
  }
}
