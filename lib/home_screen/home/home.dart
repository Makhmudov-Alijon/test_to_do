import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:test_to_do/controller/home_controller.dart';
import 'package:test_to_do/home_screen/home/home_menu/home_menu.dart';
import 'package:test_to_do/home_screen/home/task_menu/task_menu.dart';
import 'package:test_to_do/controller/home_controller.dart';

import '../../model/category_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var b = ''.obs;
  final Box box =Hive.box('user');
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
  HomeController controller=Get.put( HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      init: HomeController(),
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
                            alignment: Alignment(-0.9, -0.6),
                            child: Text(
                              "Hello ${box.get('key')} !",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                      index: controller.tabIndex.value,
                      children: [HomeMenu(), TaskMenu()],
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Obx(() {
            return FloatingActionButton(
              child: controller.isSelect.value ?Icon(Icons.clear):Icon(Icons.add),
              backgroundColor: Colors.red,
              onPressed: () {
                if (controller.isSelect.value) {
                  controller.isSelect.value=false;
                  // controller.a.value = 0.h;
                } else{
                  // controller.a.value = 50.h;
                  controller.isSelect.value=true;
                }
                FocusManager.instance.primaryFocus?.unfocus();
                controller.controller.clear();
                controller.isSelectColor.value=false;
                controller.color.value=null;
                _selectedTime=null;
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
                    Icons.home_filled,
                  ),
                  label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "menu")
            ],
          ),
          bottomSheet: Obx(() {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: controller.isSelect.value ?50.h :0.h,
              width: controller.isSelect.value ?100.w :100.w,
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
                        controller: controller.controller,
                        decoration: InputDecoration(

                          hintText: 'Text'

                        ),
                        autofocus: false,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (CategoryModel cat in CategoryModel.categories) ...{
                              _color(cat.color, cat.title),
                            }
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2.h, left: 3.w),
                          child: Text('Choose date'),
                        ),
                        Container(
                          margin: EdgeInsets.only( left: 3.w),
                          child: IconButton(
                              icon: Icon(Icons.access_time_rounded),
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
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text('Add task',style: TextStyle(color: Colors.white),),
                          )),
                      onTap: () {
                        controller.addTask(_selectedTime ?? '');
                        controller.controller.clear();
                        if (controller.isSelect.value=true) {
                          controller.isSelect.value=false;
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.date.value = _selectedTime.toString();
                        controller.isSelectColor.value=false;
                        controller.color.value=null;
                        _selectedTime=null;
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
    controller.isSelectColor.value = controller.color.value == color;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.h),
      child: GestureDetector(
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: controller.isSelectColor.value ? 9.h : 7.h,
            width: controller.isSelectColor.value ? 13.h : 10.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.h),
                color: controller.isSelectColor.value ? HexColor(color) : HexColor('#ffffff'),

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
                SizedBox(width: 2.w,),
                Container(
                  child: Text(name),
                )
              ],
            )),
        onTap: () {
          controller.isSelectColor.value=true;
          controller.color.value = color;
          // controller.update();
        },
      ),
    );
  }
}
