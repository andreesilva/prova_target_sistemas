import 'package:prova_target_sistemas/app/core/theme/app_theme.dart';
import 'package:prova_target_sistemas/app/data/services/auth/service.dart';
import 'package:prova_target_sistemas/app/routes/pages.dart';
import 'package:prova_target_sistemas/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Intl.defaultLocale = "pt_BR";

  RendererBinding.instance.setSemanticsEnabled(true);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.login,
    theme: themeData,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale("pt", "BR")],
  ));
}
