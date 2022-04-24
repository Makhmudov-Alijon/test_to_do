import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:test_to_do/home_screen/home_menu.dart';
import 'package:test_to_do/home_screen/task_menu.dart';
import 'package:test_to_do/todo_controller.dart';

import '../category_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDo _toDo = Get.put(ToDo());
  var b = ''.obs;

  // show time picker method
  String? _selectedTime;

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToDo>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          backgroundColor: HexColor('#F9FCFF'),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50.h,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        fit: StackFit.loose,
                        children: [
                          Container(
                            height: 35.h,
                            width: 100.w,
                            decoration: BoxDecoration(color: Colors.blue),
                          ),
                          Align(
                            alignment: Alignment(-1.5, -1.5),
                            child: Container(
                              height: 23.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1.1, -1.1),
                            child: Container(
                              height: 13.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment(-0.9, -0.7),
                            child: Text(
                              "Hello Brenda!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment(-0.9, -0.55),
                            child: Text(
                              "Today 7 Task Add",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment(.85, -.57),
                            child: Container(
                              height: 7.h,
                              width: 14.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 18.h, left: 5.w),
                              height: 15.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white54),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 2.h, left: 3.w),
                                        child: Text(
                                          'Today Reminder',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Container(
                                        child: Text('Meeting with client',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Container(
                                        child: Text('13.00 PM',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 2.h, left: 10.w),
                                    child: Image(
                                      image: AssetImage('images/bell.png'),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    IndexedStack(
                      index: _toDo.tabIndex.value,
                      children: [HomeMenu(), TaskMenu()],
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Obx(() {
            return FloatingActionButton(
              child: controller.c.value,
              backgroundColor: Colors.red,
              onPressed: () {
                if (controller.a.value == 0) {
                  controller.a.value = 50.h;
                  controller.c.value = controller.d.value;
                } else if (controller.c.value != Icon(Icons.add)) {
                  controller.c.value = Icon(Icons.add);
                  controller.a.value = 0.h;
                }
                FocusManager.instance.primaryFocus?.unfocus();
                _toDo.controller.clear();
              },
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "menu")
            ],
          ),
          bottomSheet: Obx(() {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: controller.a.value,
              width: controller.b.value,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5
                    )
                  ]
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
                      child: TextField(
                        controller: _toDo.controller,
                        autofocus: false,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (CategoryModel cat
                                in CategoryModel.categories) ...{
                              _color(cat.color, cat.title),
                            }
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 3.h, left: 3.w),
                          child: Text('Choose date'),
                        ),
                        Container(
                          child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              onPressed: () {
                                _show();
                              }),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 3.w),
                      child: Text(
                        _selectedTime != null
                            ? _selectedTime!
                            : 'No time selected!',
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(top: 5.h, left: 5.w),
                          height: 8.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text('Add task'),
                          )),
                      onTap: () {
                        _toDo.addTask(_selectedTime ?? '');
                        _toDo.controller.clear();
                        if (controller.a.value == 0) {
                          controller.a.value = 50.h;
                          controller.c.value = controller.d.value;
                        } else if (controller.c.value != Icon(Icons.add)) {
                          controller.c.value = Icon(Icons.add);
                          controller.a.value = 0.h;
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        _toDo.date.value = _selectedTime.toString();
                      },
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _color(String color, String name) {
    bool isSelected = _toDo.color.value == color;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.h),
      child: GestureDetector(
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: isSelected ? 9.h : 7.h,
            width: isSelected ? 15.h : 10.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.h),
                color: isSelected ? HexColor(color) : HexColor('#ffffff'),

            ),
            child: Row(
              children: [
                Container(
                  height: 1.5.h,
                  width: 3.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(color),
                  ),

                ),
                Container(
                  child: Text(name),
                )
              ],
            )),
        onTap: () {
          _toDo.color.value = color;
          _toDo.update();
        },
      ),
    );
  }
}
