import 'package:prova_target_sistemas/app/modules/home/binding.dart';
import 'package:prova_target_sistemas/app/modules/home/page.dart';
import 'package:prova_target_sistemas/app/modules/login/binding.dart';
import 'package:prova_target_sistemas/app/modules/login/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
