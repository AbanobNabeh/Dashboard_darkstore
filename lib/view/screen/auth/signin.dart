import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<LoginController>(
          init: LoginController(),
          builder: (controller) => Form(
            key: formstate,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defTextForm(
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.person,
                            controller: controller.username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'username'.tr;
                              }
                            },
                            hint: 'username'),
                        SizedBox(
                          height: 20,
                        ),
                        defTextForm(
                            prefixIcon: Icons.lock,
                            controller: controller.password,
                            obscureText: controller.visible.value,
                            suffixIcon: controller.iconvisible.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password'.tr;
                              }
                            },
                            ontapSuff: () => controller.changevisible(),
                            hint: 'password'),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                activeColor: defcolor,
                                value: controller.rememberme.value,
                                onChanged: (value) {
                                  controller.rememberme.value = value!;
                                }),
                            defText(
                                text: "rememberme", color: defcolor, size: 16)
                          ],
                        ),
                        controller.error == ""
                            ? SizedBox(
                                width: 0,
                              )
                            : defText(
                                text: controller.error.value,
                                color: Colors.red,
                                size: 14)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (formstate.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  child: defborder(
                      child: controller.isloading.value == true
                          ? defcirculer()
                          : Icon(
                              Icons.forward,
                              color: Colors.white,
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
