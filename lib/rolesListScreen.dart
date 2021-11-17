import 'package:ekrut/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;

class RolesListScreen extends StatefulWidget {
  @override
  _RolesListScreenState createState() => new _RolesListScreenState();
}

class _RolesListScreenState extends State<RolesListScreen> {
  var _result = [];

  Future<String> fetchUsers() async {
    var result = await UserService().getRoles();
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
                        //print(list['title']);
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 145,
                          width: double.infinity,
                          color: Colors.black12,
                          child: Column(children: <Widget>[
                            Text(
                              list['title'].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.right,
                            ),
                            Container(height: 16),
                            Html(
                              data: list['description'].toString(),
                            ),
                            Html(
                              data: list['requirement'].toString(),
                            ),
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
