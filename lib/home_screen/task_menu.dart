import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_to_do/home_screen/meeting_task.dart';
import 'package:test_to_do/home_screen/person_task.dart';
import 'package:test_to_do/home_screen/study_task.dart';
import 'package:test_to_do/home_screen/work_task.dart';
import 'package:get/get.dart';
import '../task_model.dart';
import '../todo_controller.dart';

class TaskMenu extends StatefulWidget {
  const TaskMenu({Key? key}) : super(key: key);

  @override
  State<TaskMenu> createState() => _TaskMenuState();
}

class _TaskMenuState extends State<TaskMenu> {
  ToDo _toDo = Get.put(ToDo());
  
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonTask()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkTask()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MetingTask()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopTask()));
            },
          ),
          Container(
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
                  child: Icon(Icons.person,color: Colors.orange,size: 30,),
                ),
                ),
                Container(
                  child: Text('Person'),
                ),
                Text("task")
              ],
            ),
          ),
          Container(
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
                  child: Icon(Icons.person,color: Colors.orange,size: 30,),
                ),
                ),
                Container(
                  child: Text('Person'),
                ),
                Text("task")
              ],
            ),
          ),

        ],
      ),
    );
  }
}
