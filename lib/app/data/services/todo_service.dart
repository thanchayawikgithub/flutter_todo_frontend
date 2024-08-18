import 'package:get/get.dart';
import 'package:test_getx/app/data/todo.dart';

class TodoService extends GetxService {
  final todos = <Todo>[
    Todo(title: 'Title 1', description: 'Description 1'),
    Todo(title: 'Title 2', description: 'Description 2'),
    Todo(title: 'Title 3', description: 'Description 3')
  ].obs;

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }

  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void editTodo(int index, Todo todo) {
    todos[index] = todo;
    todos.refresh();
  }
}
