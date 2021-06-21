import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(primaryColor: Colors.purple.shade400),
    //   initialRoute: '/login',
    //   routes: {
    //     '/': (context) => HomeScreen(),
    //     '/add': (context) => AddRecipe(),
    //     '/login': (context) => LoginScreen(),
    //   },
    // );
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Recipe App'),
            backgroundColor: Colors.purple.shade400,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Add recipe',
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
                },
              )
            ],
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              ListTile(
                title: Text('Recipe 1'),
                subtitle: Text(
                    'Recipe1 description and ingredients and method explained.'),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.vegrecipesofindia.com/wp-content/uploads/2020/11/pizza-recipe.jpg')),
              ),
              SizedBox(height: 10.0),
              Divider(
                height: 10.0,
                thickness: 2,
              ),
              SizedBox(height: 10.0),
              ListTile(
                title: Text('Recipe 2'),
                subtitle: Text(
                    'Recipe2 description and ingredients and method explained.'),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.vegrecipesofindia.com/wp-content/uploads/2020/11/pizza-recipe.jpg')),
              ),
              SizedBox(height: 10.0),
              Divider(
                height: 10.0,
                thickness: 2,
              ),
              SizedBox(height: 10.0),
              ListTile(
                title: Text('Recipe 3'),
                subtitle: Text(
                    'Recipe3 description and ingredients and method explained.'),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.vegrecipesofindia.com/wp-content/uploads/2020/11/pizza-recipe.jpg')),
              ),
            ],
          )),
    );
  }
}
