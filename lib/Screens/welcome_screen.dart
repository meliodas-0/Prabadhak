import 'package:flutter/material.dart';
import 'package:prabandhak/Screens/bottom_navigation_page.dart';
import 'package:prabandhak/helpers/methods_helper.dart';
import 'package:prabandhak/helpers/network/api_helper.dart';
import 'package:prabandhak/helpers/shared_preference.dart';
import 'package:prabandhak/helpers/snackbar_helper.dart';
import 'package:prabandhak/providers/access_token_provider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController mailController, passwordController;
  bool loaderVisible = false;
  String email = '';
  String password = '';
  final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(
        5.0,
      ),
    ),
    isDense: true,
    contentPadding: const EdgeInsets.all(8.0),
  );

  @override
  void initState() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(38.0),
                        child: Text(
                          'Prabandhak',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://assets.volvo.com/is/image/VolvoInformationTechnologyAB/join-us-banner?qlt=82&wid=1024&ts=1624538498965&fit=constrain',
                            ),
                            radius: 100.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              'Let\'s get you started for new journey.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: mailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Enter email',
                      ),
                      onChanged: (value) => email = value,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Enter password',
                      ),
                      onChanged: (value) => password = value,
                      onFieldSubmitted: (value) => signIn(),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: signIn,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sign in'),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.cyan),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.cyan),
                      ),
                      visible: loaderVisible,
                    ),
                    TextButton(
                      child: const Text('Get help with signing in'),
                      onPressed: signInHelp,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.cyan.shade300,
                    ),
                  ),
                  onPressed: signUP,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      //TODO: Add sign here
                      Text('Sign up for free')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (email.isEmpty || password.isEmpty) {
      showMessageSnackBar(context, 'Enter correct email.');
      return;
    }

    showLoaderDialog(context);
    setState(() {
      loaderVisible = true;
    });

    String? accessToken = await ApiHelper.getAccessCode(email, password);

    setState(() {
      loaderVisible = false;
    });

    if (accessToken != null) {
      showMessageSnackBar(context, 'Welcome');
      print(accessToken);
      setStringIntoCache(ACCESS_TOKEN, accessToken);
      await Provider.of<AccessTokenProvider>(context, listen: false)
          .changeAccessToken(accessToken);
      await setUser(context, accessToken);
      makeThisPageStartOfTheStack(context, const BottomNavigationPage());
    } else {
      Navigator.pop(context);
      showMessageSnackBar(context, 'Something went wrong. try again');
    }
  }

  void signInHelp() {
    showMessageSnackBar(context, 'Sign in help clicked.');
  }

  void signUP() {
    showMessageSnackBar(context, 'Sign up clicked');
  }

  void showLoaderDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      content: Container(
        margin: const EdgeInsets.only(left: 7),
        child: const Flexible(
          child: Text(
            "We are signing you in, please wait...",
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }
}
