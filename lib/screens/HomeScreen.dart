import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recipe_app/network-manager.dart';

class UserInfoCommunicator {
  void updateUserName(String name) {}
}

class HomeScreen extends StatefulWidget {
  final String loggedInUser;
  const HomeScreen({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements UserInfoCommunicator {
  // final List<int> list = List<int>.generate(5, (index) => index + 1);
  bool isLoggingout = false;

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      "http://192.168.33.10:8080/v1/graphql",
    );

    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ));

    final String userName = widget.loggedInUser;

    final String query = r"""
          query fetchRecipes {
            recipes {
              id
              name
              description
              image_url
              ingredients {
                name
              }
            }
          }
        """;

    return MaterialApp(
        home: GraphQLProvider(
      child: Scaffold(
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                ),
                child: Text(
                  "Welcome $userName",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Profile"),
                onTap: () {
                  print("Profile Page");
                },
              ),
              Divider(height: 10.0),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  print("Invoking Logout");
                  logout(context);
                },
              ),
            ],
          ),
        ),
        body: Query(
          options: QueryOptions(document: gql(query)),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data == null) {
              return Text("No recipe found!");
            }
            // return Text("Loading recipes...");
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(result.data!['recipes'][index]['name']),
                      subtitle:
                          Text(result.data!['recipes'][index]['description']),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              result.data!['recipes'][index]['image_url'])),
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      height: 10.0,
                      thickness: 2,
                    )
                  ],
                );
              },
              itemCount: result.data!['recipes'].length,
            );
          },
        ),
      ),
      client: client,
    ));
  }

  @override
  void updateUserName(String name) {
    // if (userName != "" && name != userName) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("User name changed"),
    //     ),
    //   );
    // }

    // setState(() {
    //   userName = name;
    // });
  }

  Future<void> logout(BuildContext context) async {
    if (isLoggingout) {
      return;
    }

    isLoggingout = true;

    try {
      await NetworkManager.shared.logout();
    } catch (e) {
      print("Catch in HomeScreen");
      print(e);
    } finally {
      isLoggingout = false;
    }

    Navigator.of(context).pop();
  }
}
