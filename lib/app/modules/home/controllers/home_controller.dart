import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/app/data/services/todo_service.dart';
import 'package:test_getx/app/data/todo.dart';

class HomeController extends GetxController {
  final TodoService todoService = Get.find();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final titleFocus = FocusNode();

  void setEditedTodo(Todo todo) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
  }

  void clearForm() {
    titleController.text = '';
    descriptionController.text = '';
  }

  void addNewTodo() {
    todoService.addTodo(Todo(
        title: titleController.text, description: descriptionController.text));
    clearForm();
  }

  void editTodo(int index) {
    todoService.editTodo(
        index,
        Todo(
            title: titleController.text,
            description: descriptionController.text));
    clearForm();
  }

  void toggleTodoStatus(int index) {
    todoService.toggleTodoStatus(index);
  }

  void removeTodoAt(int index) {
    todoService.removeTodoAt(index);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    titleFocus.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    titleController.dispose();
    super.onClose();
  }
}
