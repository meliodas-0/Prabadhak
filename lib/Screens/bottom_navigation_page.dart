import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prabandhak/Screens/main_screen/create_session_page.dart';
import 'package:prabandhak/Screens/main_screen/home_page.dart';
import 'package:prabandhak/Screens/main_screen/meeting.dart';
import 'package:prabandhak/Screens/main_screen/search_page.dart';
import 'package:prabandhak/Screens/main_screen/settings_page.dart';
import 'package:prabandhak/helpers/back_helper.dart';
import 'package:prabandhak/helpers/constants.dart';
import 'package:prabandhak/helpers/methods_helper.dart';
import 'package:prabandhak/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final GlobalKey<ScaffoldState> _scaffoldStateGlobalKey =
      GlobalKey<ScaffoldState>();
  int _selectedPage = 0;
  List<Widget> widgets = [
    HomePageWidget(),
    SearchPageWidget(),
    SettingsPageWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          await backPressed(context, _scaffoldStateGlobalKey),
      child: Scaffold(
        key: _scaffoldStateGlobalKey,
        appBar: _selectedPage == 0
            ? AppBar(
                title: const Text('Prabandhak'),
                elevation: 0,
              )
            : null,
        //TODO: Drawer
        drawer: _selectedPage == 0 ? drawer() : null,
        body: SafeArea(
          child: widgets[_selectedPage],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateSession(),
              )),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.black.withOpacity(.1),
            ),
          ]),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: brightness == Brightness.light ? Colors.black : Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedPage,
            onTabChange: (value) => setState(() {
              _selectedPage = value;
            }),
          ),
        ),
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Todo: Change this image to actual user image. For now use this as is.
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://static0.cbrimages.com/wordpress/wp-content/uploads/2019/09/One-Piece-Monkey-D.-Luffy-Cropped.jpg',
                  ),
                  radius: 50.0,
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) => Text(
                    value.user.fullname,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            )),
          ),
          ListTile(
            title: const Text('Create meeting anonymously. '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Meeting(
                    anonymous: true,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Feedback. '),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Sign out'),
            leading: const Icon(Icons.logout),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
