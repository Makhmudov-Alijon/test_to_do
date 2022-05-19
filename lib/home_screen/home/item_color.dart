import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:test_to_do/controller/home_controller.dart';
import 'package:test_to_do/home_screen/home/home.dart';

class ItemColor extends StatelessWidget {
  ItemColor({Key? key, required this.color, required this.name})
      : super(key: key);
  final String color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          controller.isSelectColor.value = controller.color.value == color;
          return Obx(() {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 1.h),
              child: GestureDetector(
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: controller.isSelectColor.value ? 9.h : 7.h,
                    width: controller.isSelectColor.value ? 13.h : 10.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.h),
                      color: controller.isSelectColor.value
                          ? HexColor(color)
                          : HexColor('#ffffff'),

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
                  controller.isSelectColor.value = true;
                  controller.color.value = color;
                  // controller.update();
                },
              ),
            );
          });
        });
  }
}
