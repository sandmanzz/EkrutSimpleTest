import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';

import 'environment.dart';

class UserService {
  final _headers = {'Content-Type': 'application/json'};

  getLists() async {
    var url = Environment.getApiPath;

    var result = await http.get(url);

    final responseData = json.decode(result.body);

    return responseData;
  }

  getRoles() async {
    var url = Environment.getApiPath2;

    var result = await http.get(url);

    final responseData = json.decode(result.body);

    return responseData;
  }

  addItem(params) async {
    var url = Environment.postApiPath;

    final response =
        await http.post(url, body: json.encode(params), headers: _headers);
    final responseData = json.decode(response.body);

    return responseData;
  }
}
