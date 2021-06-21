import 'package:flutter/material.dart';
// import 'package:recipe_app/screens/AddRecipe.dart';
// import 'package:recipe_app/screens/HomeScreen.dart';
// import 'package:recipe_app/screens/LoginScreen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      "http://192.168.33.10:8080/v1/graphql",
    );

    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
      link: httpLink,
      // cache: GraphQLCache(store: HiveStore(Hive.box('myHiveBox'))),
      cache: GraphQLCache(),
    ));
    return MaterialApp(
      home: GraphQLProvider(
        child: HomePage(),
        client: client,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        backgroundColor: Colors.purple.shade400,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     tooltip: 'Add recipe',
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/add');
        //     },
        //   )
        // ],
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
    );
  }
}
