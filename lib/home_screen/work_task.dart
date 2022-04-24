import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../task_model.dart';
import '../todo_controller.dart';

class WorkTask extends StatefulWidget {
  const WorkTask({Key? key}) : super(key: key);

  @override
  State<WorkTask> createState() => _WorkTaskState();
}

class _WorkTaskState extends State<WorkTask> {
  ToDo _toDo = Get.put(ToDo());
  bool value = false;
  var taskModel;
  Set<String> selectedTasks = {};
  final Box tasksBox = Hive.box('task');
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToDo>(builder: (_toDo) {
      if(tasksBox.isEmpty==false){
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white54,

              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ),
          body: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _toDo.tasksBox.length,
              itemBuilder: (context, index) {
                var at = _toDo.tasksBox.getAt(index);
                var taskMap = jsonDecode(at);
                taskModel = TaskModel.fromJson(taskMap);
                return Slidable(
                  key: const ValueKey(1),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        onPressed: (BuildContext context) {
                          _toDo.textFieldController.text = taskModel.title;
                          Get.defaultDialog(
                              content: Column(
                                children: [
                                  TextField(
                                    controller: _toDo.textFieldController,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 2.h),
                                          height: 5.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                2.h),
                                            color: Colors.green,
                                          ),
                                          child: Center(
                                            child: Text('Cancel'),
                                          ),
                                        ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                      SizedBox(
                                        width: 8.h,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          height: 5.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                2.h),
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: Text('Save'),
                                          ),
                                        ),
                                        onTap: () {
                                          _toDo.editTAsk(index);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _toDo.deleteTask(index);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: item(),
                );
              },
            ),
          ),

        );
      }else{
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white54,

              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ),
          body:  Container(
            margin: EdgeInsets.only(top: 45.h,left: 35.w),
            child:Column(
              children: [
                Image(
                  width: 30.w,
                  image: AssetImage('images/Group.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.h,),
                  child: Text('No Task',style: TextStyle(fontSize: 20),),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  Widget item() {
    if (taskModel.color == "#5DE61A") {
      return Container(
          height: 10.h,
          width: 100.w,
          margin: EdgeInsets.only(
              top: 1.h, left: 2.h, right: 2.h, bottom: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.h),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 1.w
                ),
                height: 10.h,
                width: 3.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.h),
                  color: HexColor(taskModel.color ?? '#FFFFFF'),
                ),

              ),
              Container(
                child: Checkbox(
                  value: selectedTasks.contains(taskModel.id),
                  onChanged: (value) {
                    setState(() {
                      if (selectedTasks.contains(taskModel.id)) {
                        selectedTasks.remove(taskModel.id);
                      } else {
                        selectedTasks.add(taskModel.id);
                      }
                    });
                  },
                ),
              ),
              Container(
                child: Text(taskModel.title),
              )
            ],
          )
      );
    } else {
      return Container();
    }
  }
}
