import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardstore/network/cachehelper.dart';
import 'package:dashboardstore/view/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isloading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString error = ''.obs;
  RxBool visible = true.obs;
  Rx<IconData> iconvisible = Icons.visibility.obs;
  RxBool rememberme = false.obs;
  void changevisible() {
    if (visible.value == true) {
      visible.value = false;
      iconvisible.value = Icons.visibility_off;
    } else {
      visible.value = true;
      iconvisible.value = Icons.visibility;
    }
  }

  void login() {
    isloading.value = true;
    FirebaseFirestore.instance
        .collection('admin')
        .where('username', isEqualTo: username.text)
        .where('password', isEqualTo: password.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        error.value = "loginerror";
      } else {
        if (rememberme.value == true) {
          CacheHelper.saveData(key: 'id', value: username.text);
          Get.off(() => HomeScreen());
        }
        Get.off(() => HomeScreen());
      }

      isloading.value = false;
    });
  }
}
