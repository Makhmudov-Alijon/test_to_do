import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:test_to_do/home_screen/home/home.dart';
import 'package:test_to_do/router/app_roters.dart';
class RegisterPage extends StatelessWidget {
   RegisterPage({Key? key}) : super(key: key);
final TextEditingController controller=TextEditingController();
 final Box box =Hive.box('user');
  @override
  Widget build(BuildContext context) {
    if(box.isEmpty){
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 30.h,),
            Container(
              margin: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'UserName',
                    border: OutlineInputBorder()
                ),
              ),
            )
          ],
        ),
        bottomSheet: GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 5.h, left: 5.w,right: 5.w),
            height: 7.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onTap: () {
            box.put('key', controller.text.toString());
            Get.toNamed(AppRouters.home);
          },
        ),
      );
    }else{
     return Home();
    }
  }
}
