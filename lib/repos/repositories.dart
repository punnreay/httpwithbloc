import 'dart:convert';
import 'package:blochttpget/models/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  static Future<List<todo>> getUsers() async {
    Response response = await get(Uri.parse('https://api.nstack.in/v1/todos'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => todo.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// post data
  static Future<todo> postUser(todo? user) async {
    Response response = await post(Uri.parse('https://api.nstack.in/v1/todos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user!.toJson()));
    if (response.statusCode == 201) {
      return todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //delete data
  static Future<void> deleteUser(String id) async {
    try {
      Response response = await delete(
          Uri.parse('https://api.nstack.in/v1/todos/$id'),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
    }
  }

  //update data
  static Future<void> updateUser(todo user) async {
    try {
      Response response =
          await put(Uri.parse('https://api.nstack.in/v1/todos/${user.sId}'),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'title': user.title,
                'description': user.description,
                'is_completed': false,
              }));
    } catch (e) {
      print(e);
    }
  }
}
