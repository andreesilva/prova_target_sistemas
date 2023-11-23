import 'package:prova_target_sistemas/app/core/theme/colors.app.dart';
import 'package:prova_target_sistemas/app/data/models/typed_text.dart';
import 'package:prova_target_sistemas/app/modules/home/controller.dart';
import 'package:prova_target_sistemas/app/routes/routes.dart';
import 'package:prova_target_sistemas/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 40, right: 20, left: 20, bottom: 0),
              child: Column(
                children: [
                  SizedBox(
                      height: 800,
                      child: Center(
                        child: Stack(children: [
                          Column(children: [
                            Obx(
                              () => controller.texts.isEmpty
                                  ? const Text(
                                      '',
                                      style: TextStyle(fontSize: 22),
                                    )
                                  : Expanded(
                                      child: Card(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 100, 0, 100),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        elevation: 4,
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => controller.texts.isEmpty
                                                  ? const Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    )
                                                  : Expanded(
                                                      child: ListView.builder(
                                                        itemCount: controller
                                                            .texts.length,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            getRow(index,
                                                                context:
                                                                    context),
                                                      ),
                                                    ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 0),
                                  Center(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      autofocus: true,
                                      controller: controller.typedText,
                                      decoration: const InputDecoration(
                                          hintText: "Digite seu texto",
                                          helperStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          focusColor: Colors.black,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: ColorsApp.background),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Roboto')),
                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Informe o texto';
                                        } else if (value!.length > 20) {
                                          return 'O usuário não deve ter mais de 20 caracteres';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0),
                                    child: ElevatedButton(
                                      style: button,
                                      child: AnimatedBuilder(
                                        animation: controller.loadingCircular,
                                        builder: (context, _) {
                                          return controller
                                                  .loadingCircular.value
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : const Text('Salvar');
                                        },
                                      ),
                                      onPressed: () => {
                                        if (controller.formKey.currentState!
                                            .validate())
                                          {
                                            controller.loadingCircular.value =
                                                true,
                                            controller.texts.add(TypedText(
                                                text:
                                                    controller.typedText.text)),
                                            controller.saveSh(),
                                          }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //const SizedBox(height: 50),
                            const InkWell(
                              onTap: _launchURL,
                              child: Text(
                                'Política de privacidade',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ])
                        ]),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getRow(int index, {required BuildContext context}) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.texts[index].text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(onTap: () {}, child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Deseja realmente excluir este registro?",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto'),
                            ),
                            titleTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            actionsOverflowButtonSpacing: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 7,
                            actions: [
                              ElevatedButton(
                                  style: button,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Não")),
                              ElevatedButton(
                                  style: button,
                                  onPressed: () {
                                    controller.texts.removeAt(index);

                                    controller.saveSh();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Sim")),
                            ],
                          );
                        });
                  }),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

bool verificationCaracter(String password) {
  password.trim();
  return RegExp("^[a-zA-Z]*[a-zA-Z]+[a-zA-Z]").hasMatch(password);
}

_launchURL() async {
  Uri _url = Uri.parse('https://www.google.com');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
