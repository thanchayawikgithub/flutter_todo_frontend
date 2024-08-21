import 'package:http/http.dart' as http;
import 'package:test_getx/app/data/todo.dart';

Future<void> main(List<String> args) async {
  final response = await http.get(Uri.parse('http://localhost:3000/todos/1'));
  if (response.statusCode == 200) {
    print(response.body.runtimeType);
    final todo = Todo.fromJson(response.body);
    print(todo);
  } else {
    throw Exception('Failed to load todo');
  }
}
