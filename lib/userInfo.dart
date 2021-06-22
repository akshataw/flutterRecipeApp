import 'package:flutter/material.dart';
import 'package:recipe_app/screens/HomeScreen.dart';

import 'network-manager.dart';

class UserInfo extends StatefulWidget {
  final int threadNumber;
  final UserInfoCommunicator communicator;

  const UserInfo(this.threadNumber, this.communicator);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late int numberOfAPICallsMade;
  bool shouldFetch = true;

  void initState() {
    numberOfAPICallsMade = 0;
    super.initState();
    startFetch();
  }

  void dispose() {
    shouldFetch = false;
    super.dispose();
  }

  Future<void> startFetch() async {
    if (!shouldFetch) {
      return;
    }

    try {
      String name = await NetworkManager.shared.getUserInfo();
      setState(() {
        numberOfAPICallsMade++;
      });
      widget.communicator.updateUserName(name);
    } catch (e) {
      print("Catch in userinfo");
      print(e);
    }

    Future.delayed(Duration(seconds: 1), () {
      startFetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("welcome $numberOfAPICallsMade"),
    );
  }
}
