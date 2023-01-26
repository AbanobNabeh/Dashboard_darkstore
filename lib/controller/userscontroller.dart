import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardstore/model/modelusers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  TextEditingController searchcont = TextEditingController();
  RxBool isloading = false.obs;
  @override
  void onInit() {
    getusers();
    super.onInit();
  }

  RxList users = [].obs;
  void getusers() {
    isloading.value = true;
    users.value = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        users.add(ModelUsers.fromJson(element.data()));
      });
      isloading.value = false;
    });
  }

  RxList search = [].obs;
  void searchuser(String searchcase) {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: searchcase)
        .get()
        .then((value) {
      search.value = [];
      value.docs.forEach((element) {
        search.add(ModelUsers.fromJson(element.data()));
      });
    });
  }
}
