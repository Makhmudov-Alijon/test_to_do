import 'dart:convert';
import 'dart:ui';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

import 'package:sizer/sizer.dart';
import 'package:test_to_do/controller/home_controller.dart';
import 'package:test_to_do/model/task_model.dart';

import '../../../controller/home_controller.dart';
import 'package:get/get.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  HomeController _toDo = Get.put(HomeController());
  Set<String> selectedTasks = {};
  final Box tasksBox = Hive.box('task');
  @override
  Widget build(BuildContext context) {

    if(tasksBox.isEmpty==false){
      return Container(
        margin: EdgeInsets.only(top: 35.h),
        height: 57.5.h,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: _toDo.tasksBox.length,
          itemBuilder: (context, index) {
            var model = _toDo.tasksBox.getAt(index);
            var taskMap = jsonDecode(model);
            var taskModel = TaskModel.fromJson(taskMap);

            return Slidable(
              closeOnScroll: true,
              useTextDirection: true,
              key: const ValueKey(1),

              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dragDismissible: true,
                children: [
                  SizedBox(width: 3.w,),
                  Slidable(
                    closeOnScroll: true,
                   child: GestureDetector(
                     child: Container(
                       height: 9.h,
                       width: 20.w,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4.w),
                         color: Colors.deepPurple
                       ),
                       child: Icon(Icons.edit,color: Colors.white,),
                     ),
                     onTap: (){
                       _toDo.textFieldController.text = taskModel.title;
                       Get.defaultDialog(
                         title: 'Task',
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
                                         borderRadius: BorderRadius.circular(2.h),


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
                                         borderRadius: BorderRadius.circular(2.h),

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
                  ),
                  SizedBox(width: 3.w,),
                  Slidable(
                    closeOnScroll: true,
                   child: GestureDetector(
                     child: Container(
                       height: 9.h,
                       width: 20.w,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(4.w),
                           color: Colors.deepPurple
                       ),
                       child: Icon(Icons.delete,color: Colors.white,),
                     ),
                     onTap: (){
                       Get.defaultDialog(
                           title: 'Task',
                           content: Column(
                             children: [
                               Container(
                                 child: Text(taskModel.title),
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
                                         borderRadius: BorderRadius.circular(2.h),


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
                                         borderRadius: BorderRadius.circular(2.h),

                                       ),
                                       child: Center(
                                         child: Text('Delete'),
                                       ),
                                     ),
                                     onTap: () {
                                       _toDo.deleteTask(index);
                                       Get.back();
                                     },
                                   ),
                                 ],
                               )
                             ],
                           ));

                     },
                   ),
                  ),
                ],
              ),
              child: Container(
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
                        width: 5.w,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.h),
                        ),
                        child: Expanded(

                          child: Container(
                            margin: EdgeInsets.only(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.w),
                                bottomLeft: Radius.circular(3.w),
                              ),
                              color: HexColor(taskModel.color ?? '#FFFFFF'),
                            ),
                          ),
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
                        child: Text(taskModel.date.toString()),
                      ),
                      SizedBox(width: 3.w,),
                      Container(
                        width: 55.w,
                        child: Text(taskModel.title),
                      ),
                    ],
                  )),
            );

          },
        ),
      );
    }else{
      return Container(
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
      );
    }
  }
}
