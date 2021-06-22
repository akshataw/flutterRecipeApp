import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  // const AddRecipe({ Key? key }) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        backgroundColor: Colors.purple.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.local_pizza),
                  hintText: 'Enter recipe name',
                  labelText: 'Recipe Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.info),
                  hintText: 'Enter recipe description',
                  labelText: 'Recipe Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.photo_album),
                  hintText: 'Enter recipe image url',
                  labelText: 'Recipe Image URL',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            Container(
              padding: EdgeInsets.only(
                left: 150.0,
                top: 40.0,
              ),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ignore: deprecated_member_use
                    // Scaffold.of(context).showSnackBar(SnackBar(
                    //   content: Text('Data is processing...'),
                    // ));
                    print("linr 79");
                    print(_formKey.currentState);
                    Text("Data is processing...");
                  }
                  print("line 82:");
                  print(_formKey.currentState);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
