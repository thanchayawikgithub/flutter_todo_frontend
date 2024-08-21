import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:test_getx/app/data/todo.dart';

class TodoService extends GetxService {
  final todos = <Todo>[].obs;

  Future<void> getTodos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/todos'));
    if (response.statusCode == 200) {
      final list = json.decode(response.body);
      final todoList = list.map<Todo>((item) => Todo.fromMap(item)).toList();
      todos.assignAll(todoList);
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: todo.toJson(),
    );
    if (response.statusCode == 201) {
      await getTodos();
      log(Todo.fromJson(response.body).toJson());
    } else {
      throw Exception('Failed to load todo');
    }
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }

  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  Future<void> editTodo(int id, Todo todo) async {
    final response = await http.patch(
      Uri.parse('http://localhost:3000/todos/${todo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: todo.toJson(),
    );
    if (response.statusCode == 200) {
      await getTodos();
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<void> removeTodo(Todo todo) async {
    final response =
        await http.delete(Uri.parse('http://localhost:3000/todos/${todo.id}'));
    if (response.statusCode == 200) {
      await getTodos();
    } else {
      throw Exception('Failed to load todo');
    }
  }
}
