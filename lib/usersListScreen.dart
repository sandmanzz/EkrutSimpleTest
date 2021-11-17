import 'package:ekrut/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => new _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  var _result = [];

  Future<String> fetchUsers() async {
    var result = await UserService().getLists();
    result.forEach((key, value) {
      _result.add(value);
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //print(snapshot.data);
              //print(snapshot);
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      ..._result[0].map<Widget>((list) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 100,
                          width: double.infinity,
                          color: Colors.black12,
                          child: Column(children: <Widget>[
                            Text(
                              list['fullname'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            Container(height: 16),
                            Text(list['email']),
                            Container(height: 8),
                            Text(list['phone'])
                          ]),
                        );
                      })
                    ]));
              } else {
                return Container(child: Text('nodata'));
              }
            }));
  }
}
