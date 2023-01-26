import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardstore/controller/modelsupport.dart';
import 'package:dashboardstore/model/modelusers.dart';
import 'package:dashboardstore/network/cachehelper.dart';
import 'package:dashboardstore/view/screen/auth/signin.dart';
import 'package:dashboardstore/view/screen/banners/banners.dart';
import 'package:dashboardstore/view/screen/categories/categories.dart';
import 'package:dashboardstore/view/screen/order/order.dart';
import 'package:dashboardstore/view/screen/support/mail.dart';
import 'package:dashboardstore/view/screen/support/support.dart';
import 'package:get/get.dart';

import '../view/screen/coupons/coupons.dart';
import '../view/screen/product/product.dart';
import '../view/screen/users/users.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getsipportmessage();
    super.onInit();
  }

  RxBool menubar = true.obs;
  RxBool isloading = false.obs;
  RxInt curentindex = 0.obs;
  RxList screen = [
    ProductScreen(),
    CategoriesScrren(),
    UsersScreen(),
    OrderScreen(),
    CouponsScreen(),
    BannersScreen(),
    SupportScreen(),
  ].obs;
  RxList support = [].obs;
  RxInt seen = 0.obs;
  void getsipportmessage() {
    isloading.value = true;
    support.value = [];
    seen.value = 0;
    FirebaseFirestore.instance.collection("support").get().then((value) {
      value.docs.forEach((element) {
        support.add(ModelSupport.fromJson(element.data()));
        element.data()['seen'] == false ? seen + 1 : null;
      });
      isloading.value = false;
    });
  }

  void read(ModelSupport support) {
    FirebaseFirestore.instance
        .collection('support')
        .doc(support.id)
        .update({'seen': true}).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(support.idsender)
          .get()
          .then((value) {
        Get.to(() => MailScreen(support, ModelUsers.fromJson(value.data()!)));
        getsipportmessage();
      });
    });
  }

  void logout() {
    CacheHelper.removeData(key: 'id').then((value) {
      Get.offAll(() => SigninScreen());
    });
  }
}
