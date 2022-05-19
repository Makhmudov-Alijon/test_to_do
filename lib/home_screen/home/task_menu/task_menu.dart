import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_to_do/controller/home_controller.dart';

import 'package:test_to_do/home_screen/home/task_menu/meeting/meeting_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/person/person_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/study/study_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/work/work_task.dart';
import 'package:get/get.dart';
import 'package:test_to_do/router/app_roters.dart';
import '../../../model/task_model.dart';
import '../../../controller/home_controller.dart';

class TaskMenu extends StatefulWidget {
  const TaskMenu({Key? key}) : super(key: key);

  @override
  State<TaskMenu> createState() => _TaskMenuState();
}

class _TaskMenuState extends State<TaskMenu> {
  HomeController _toDo = Get.put(HomeController());
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
         top: 35.h
      ),
      height: 57.5.h,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        crossAxisSpacing: 4.h,
        mainAxisSpacing: 4.h,
        padding: EdgeInsets.only(left: 24, right: 24,top: 20),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          GestureDetector(
            child: Container(
              height: 20.h,
              width: 20.w,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 3
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 3.h
                    )
                    ,child: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 25,
                      child: Icon(Icons.person,color: Colors.orange,size: 30,),
                    ),
                  ),
                  Container(
                    child: Text('Person'),
                  ),
                  Text("")
                ],
              ),
            ),
            onTap: (){
             Get.toNamed(AppRouters.person,arguments: "Person");
            },
          ),
          GestureDetector(
            child: Container(
              height: 20.h,
              width: 20.w,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 3
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 3.h
                    )
                    ,child: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    radius: 25,
                    child: Icon(Icons.shopping_bag,color: Colors.green,size: 30,),
                  ),
                  ),
                  Container(
                    child: Text('Work'),
                  ),
                  Text("task")
                ],
              ),
            ),
            onTap: (){
              Get.toNamed(AppRouters.work,arguments: "Work");
            },
          ),
          GestureDetector(
            child: Container(
              height: 20.h,
              width: 20.w,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 3
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 3.h
                    )
                    ,child: CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    radius: 25,
                    child: Icon(Icons.meeting_room,color: Colors.purple,size: 30,),
                  ),
                  ),
                  Container(
                    child: Text('Meeting'),
                  ),
                  Text("task")
                ],
              ),
            ),
            onTap: (){
              Get.toNamed(AppRouters.meting,arguments: "Meeting");
            },
          ),
          GestureDetector(
            child: Container(
              height: 20.h,
              width: 20.w,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 3
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 3.h
                    )
                    ,child: CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    radius: 25,
                    child: Icon(Icons.shopping_basket_outlined,color: Colors.orange,size: 30,),
                  ),
                  ),
                  Container(
                    child: Text('Stduy'),
                  ),
                  Text("task")
                ],
              ),
            ),
            onTap: (){
              Get.toNamed(AppRouters.study,arguments: "Study");
            },
          ),

        ],
      ),
    );
  }
}
