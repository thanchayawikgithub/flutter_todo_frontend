import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_getx/app/data/todo.dart';
import 'package:test_getx/app/modules/home/views/edit_todo_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.todoService.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todoService.todos[index];
            return Ink(
              color: todo.isDone ? Colors.red : Colors.transparent,
              child: ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.removeTodoAt(index);
                  },
                ),
                onTap: () {
                  Get.to(() => EditTodoView(index: index, todo: todo));
                },
                onLongPress: () {
                  controller.toggleTodoStatus(index);
                  log('${todo.isDone}');
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EditTodoView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
