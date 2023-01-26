import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/model/modelorder.dart';
import 'package:dashboardstore/network/dioapp.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxBool isloading = false.obs;
  @override
  void onInit() {
    getorders();
    super.onInit();
  }

  RxList orders = [].obs;
  void getorders() {
    isloading.value = true;
    orders.value = [];
    DioApp.getData(url: GETORDER).then((value) {
      value.data.forEach((element) {
        orders.add(ModelOrder.fromJson(element));
      });

      isloading.value = false;
    });
  }

  String statusorder(ModelOrder order) {
    switch (order.statusOrder) {
      case 'inreview':
        {
          return 'therequestisbeingreviewed'.tr;
        }
      case 'confirmation':
        {
          return 'confirmation'.tr;
        }
      case 'indelivery':
        {
          return 'outfordelivery'.tr;
        }
      case 'delivered':
        {
          return 'delivered'.tr;
        }
    }
    return 'therequestisbeingreviewed'.tr;
  }

  void updateorder(ModelOrder order) {
    DioApp.postData(url: UPDATEORDER, data: {
      "id": order.id,
      "state": order.statusOrder == "inreview"
          ? "confirmation"
          : order.statusOrder == "confirmation"
              ? "indelivery"
              : order.statusOrder == "indelivery"
                  ? "delivered"
                  : "",
    }).then((value) {
      getorders();
      Get.back();
    });
  }
}
