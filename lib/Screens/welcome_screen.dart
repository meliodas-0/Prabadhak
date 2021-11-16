import 'package:flutter/material.dart';
import 'package:prabandhak/helpers/snackbar_helper.dart';

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
                            radius: 50.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              'Let\'s get you started for new journey.',
                              style: TextStyle(color: Colors.grey),
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
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.cyan.shade300,
                    ),
                  ),
                  onPressed: signUP,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
    if (email.isEmpty || !email.contains('@') || password.isEmpty) {
      showMessageSnackBar(context, 'Enter correct email.');
    }

    if (email == 'prabandhak@') {
      //TODO: Remove this when actually logging in.
      showLoaderDialog(context);
      setState(() {
        loaderVisible = true;
      });
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      setState(() {
        loaderVisible = false;
      });
      Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.push(context, route);
    }

    //TODO: Complete sign in functionality
  }

  void signInHelp() {
    showMessageSnackBar(context, 'Sign in help clicked.');
  }

  void signUP() {
    showMessageSnackBar(context, 'Sign up clicked');
  }

  void showLoaderDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      content: Flexible(
        child: Container(
          margin: const EdgeInsets.only(left: 7),
          child: const Text(
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
