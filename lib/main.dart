import 'package:flutter/material.dart';
import 'package:recipe_app/screens/AddRecipe.dart';
import 'package:recipe_app/screens/HomeScreen.dart';
import 'package:recipe_app/screens/LoginScreen.dart';
import 'package:supertokens/supertokens.dart';
import 'network-manager.dart';

void main() {
  SuperTokens.initialise(
    refreshTokenEndpoint: "${NetworkManager.baseURL}/refresh",
    sessionExpiryStatusCode: 401,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple.shade400),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(
              loggedInUser: "DefaultUser",
            ),
        '/add': (context) => AddRecipe(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
