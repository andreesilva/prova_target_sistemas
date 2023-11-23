import 'package:prova_target_sistemas/app/core/theme/colors.app.dart';
import 'package:prova_target_sistemas/app/modules/login/controller.dart';
import 'package:prova_target_sistemas/app/routes/routes.dart';
import 'package:prova_target_sistemas/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Stack(children: [
              SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Usuário",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(
                              filled: true,
                              focusColor: Colors.black,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: ColorsApp.background),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              prefixIcon: Icon(Icons.person),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto')),
                          validator: (String? value) {
                            if (value != null && value.isEmpty) {
                              return 'Informe o usuário';
                            } else if (value!.length > 20) {
                              return 'O usuário não deve ter mais de 20 caracteres';
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text(
                              "Senha",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: ColorsApp.background),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto')),
                            obscureText: controller.isObscure.value,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Informe a senha';
                              } else if (value!.length < 2) {
                                return 'A senha deve ter menos de 2 caracteres';
                              } else if (value.length > 20) {
                                return 'A senha não deve ter mais de 20 caracteres';
                              } else if (verificationCaracter(value) == false) {
                                return 'Só é aceito números e letras';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 70.0),
                                child: ElevatedButton(
                                  style: button,
                                  child: AnimatedBuilder(
                                    animation: controller.loadingCircular,
                                    builder: (context, _) {
                                      return controller.loadingCircular.value
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Text('Entrar');
                                    },
                                  ),
                                  onPressed: () => {
                                    if (controller.formKey.currentState!
                                        .validate())
                                      {
                                        controller.loadingCircular.value = true,
                                        Get.toNamed(Routes.home)
                                      },
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: _launchURL,
                          child: const Text(
                            'Política de privacidade',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          )),
    );
  }
}

bool verificationCaracter(String password) {
  var exp = password.trim();

  return RegExp("^[a-zA-Z]*[a-zA-Z]+[a-zA-Z]").hasMatch(exp);
}

_launchURL() async {
  Uri _url = Uri.parse('https://www.google.com');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
