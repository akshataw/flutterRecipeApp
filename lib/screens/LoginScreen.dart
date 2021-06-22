import 'package:flutter/material.dart';
import 'package:recipe_app/screens/HomeScreen.dart';

import '../network-manager.dart';

class UserData {
  static final UserData _userData = new UserData._internal();
  late String username = '';
  // late String email;

  factory UserData() {
    return _userData;
  }

  UserData._internal();
}

final userData = UserData();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({Key? key}) : super(key: key);
  bool isLoggingIn = false;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = userData.username;

    Future<void> login(BuildContext context) async {
      if (isLoggingIn) {
        return;
      }
      isLoggingIn = true;

      try {
        await NetworkManager.shared.login();
        // Navigator.of(context).pushNamed("/");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      loggedInUser: userData.username,
                    )));
        return;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
          ),
        );
      } finally {
        isLoggingIn = false;
      }
    }

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: Colors.purple.shade200,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.lock_clock_outlined),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: Text(
                    "Session Management made secure, open source and easy to use.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter Username',
                            border: OutlineInputBorder()),
                        onChanged: (username) {
                          userData.username = username;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      print("context in login");
                      print(context);
                      login(context);
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                          top: 6,
                          bottom: 6,
                          left: 12,
                          right: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                        ),
                        child: Text("Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                ),
              ],
            )));
  }
}
