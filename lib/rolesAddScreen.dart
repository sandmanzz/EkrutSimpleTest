import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RolesAddScreen extends StatelessWidget {
  const RolesAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add New User';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class _RoleData {
  String title = '';
  String description = '';
  String requirement = '';
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  _RoleData _data = new _RoleData();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: TextFormField(

          //     // The validator receives the text that the user has entered.
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some text';
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                //  controller: _passwordController,
                // obscureText: true,
                onSaved: (value) {
                  this._data.title = value!;
                }),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: new TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                //  controller: _passwordController,
                // obscureText: true,
                onSaved: (value) {
                  this._data.description = value!;
                }),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Requirement',
                  labelStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                //  controller: _passwordController,
                // obscureText: true,
                onSaved: (value) {
                  this._data.requirement = value!;
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _formKey.currentState!.save();
                  print('Email: ${_data.title}');
                  print('Password: ${_data.description}');

                  var url = 'http://hr.ekrut.co/Items/role';
                  //SharedPreferences myPrefs = await SharedPreferences.getInstance();
                  //var id = myPrefs.getInt('id');
                  try {
                    print('sending');
                    final response = await http.post(
                      url,
                      body: json.encode({
                        'title': _data.title,
                        'description': _data.description,
                        'requirement': _data.requirement,
                      }),
                      headers: {'Content-Type': 'application/json'},
                    );
                    print(response.body);
                    //print('responseData: $response.body');
                    final responseData = response.body;
                    print(responseData);
                  } catch (error) {
                    throw error;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submited')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
