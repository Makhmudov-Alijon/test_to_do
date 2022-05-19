import 'package:get/get.dart';
import 'package:test_to_do/home_screen/home/home.dart';
import 'package:test_to_do/home_screen/home/task_menu/meeting/meeting_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/person/person_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/study/study_task.dart';
import 'package:test_to_do/home_screen/home/task_menu/work/work_task.dart';
import 'package:test_to_do/register/register_page.dart';
import 'package:test_to_do/router/app_roters.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRouters.person, page: () => PersonTask()),
    GetPage(name: AppRouters.home, page: () =>const Home()),
    GetPage(name: AppRouters.work, page: ()=>const WorkTask()),
    GetPage(name: AppRouters.meting, page: ()=>const MetingTask()),
    GetPage(name: AppRouters.study, page: ()=>const StudyTask()),
    GetPage(name: AppRouters.register, page: ()=> RegisterPage()),
  ];
}
