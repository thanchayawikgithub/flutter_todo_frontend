import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_getx/app/data/todo.dart';

Future<void> main(List<String> args) async {
  final response = await http.get(Uri.parse('http://localhost:3000/todos'));
  if (response.statusCode == 200) {
    print(response.body.runtimeType);
    final list = json.decode(response.body);
    final todoList = list.map<Todo>((item) => Todo.fromMap(item)).toList();
    print(todoList.runtimeType);
    print(todoList);
  } else {
    throw Exception('Failed to load todo');
  }
}
