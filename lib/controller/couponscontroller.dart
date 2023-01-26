import 'package:dashboardstore/model/ModelCoupons.dart';
import 'package:dashboardstore/network/dioapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../components/linkapi.dart';

class CouponsController extends GetxController {
  RxBool isloading = false.obs;
  RxList coupons = [].obs;
  TextEditingController code = TextEditingController();
  TextEditingController discount = TextEditingController();
  RxString error = ''.obs;
  @override
  void onInit() {
    getcoupons();
    super.onInit();
  }

  void getcoupons() {
    isloading.value = true;
    coupons.value = [];
    DioApp.getData(url: GETCOUPONS).then((value) {
      value.data.forEach((element) {
        coupons.add(ModelCoupons.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void enablecoupon(int idcoupon) {
    DioApp.postData(url: ENABLECOUPON, data: {'id': idcoupon}).then((value) {
      getcoupons();
    });
  }

  void disablecoupon(int idcoupon) {
    DioApp.postData(url: DISABLECOUPON, data: {'id': idcoupon}).then((value) {
      getcoupons();
    });
  }

  void addcoupon() {
    DioApp.postData(
            url: ADDCOUPON,
            data: {"code": code.text.toUpperCase(), "discount": discount.text})
        .then((value) {
      if (value.data == "This Code Already Used") {
        error.value = value.data;
      } else {
        code.text = "";
        discount.text = "";
        getcoupons();
        Get.back();
      }
    });
  }
}
