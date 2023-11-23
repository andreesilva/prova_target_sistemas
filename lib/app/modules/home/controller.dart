import 'dart:convert';

import 'package:prova_target_sistemas/app/data/models/typed_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  HomeController();

  final formKey = GlobalKey<FormState>();

  int selectedIndex = -1;

  var typedText = TextEditingController();

  final loadingCircular = ValueNotifier<bool>(false);

  List<TypedText> texts = <TypedText>[].obs;

  late SharedPreferences sp;

  @override
  void onInit() {
    getSharedPreferences();

    super.onInit();
  }

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readSh();
  }

  saveSh() {
    List<String> textListString =
        texts.map((text) => jsonEncode(text.toJson())).toList();
    sp.setStringList('myData', textListString);

    typedText.clear();

    loadingCircular.value = false;
  }

  readSh() async {
    List<String>? textListString = sp.getStringList('myData');
    if (textListString != null) {
      texts = textListString
          .map((text) => TypedText.fromJson(json.decode(text)))
          .toList();
    }
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
