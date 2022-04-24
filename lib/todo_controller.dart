import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_to_do/task_model.dart';

import 'utils.dart';
class ToDo extends GetxController {
  var controller = TextEditingController();
  var textFieldController = TextEditingController();
  final Box tasksBox = Hive.box('task');
  var date=''.obs;
  var a=0.h.obs;
  var b=100.w.obs;
  var c=Icon(Icons.add).obs;
  var d=Icon(Icons.clear).obs;
  var color_person = Colors.grey.obs;
  var color_work = Colors.grey.obs;
  Rx<String?> color = Rx(null);
  var tabIndex = 0.obs;
  bool value = false;
  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
  addTask(String date) {
    if (controller.text.isNotEmpty) {
      var randomId = getRandomString(200);
      var taskModel = TaskModel(randomId, controller.value.text, color.value,date);
      tasksBox.add(jsonEncode(taskModel.toJson()));
      controller.clear();
      update();
    } else {
      return null;
    }
    update();
  }

  void deleteTask(int index) {
    tasksBox.deleteAt(index);

    update();
  }

  void editTAsk(int index) {
    String json = tasksBox.getAt(index);
    var taskModel = TaskModel.fromJson(jsonDecode(json));
    taskModel.title = textFieldController.text;

    tasksBox.putAt(index, jsonEncode(taskModel.toJson()));
    update();
  }



}