import 'dart:math';

import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/model/modelbanner.dart';
import 'package:dashboardstore/network/dioapp.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BannersController extends GetxController {
  RxBool isloading = false.obs;
  @override
  void onInit() {
    getbanners();
    super.onInit();
  }

  RxList banners = [].obs;
  void getbanners() {
    banners.value = [];
    isloading.value = true;
    DioApp.getData(url: GETBANNER).then((value) {
      value.data.forEach((element) {
        banners.add(ModelBanner.fromJson(element));
      });
      isloading.value = false;
    });
  }

  List<int> image = [];
  String? imagename;
  Uint8List webimage = Uint8List(8);
  final ImagePicker pickerimage = ImagePicker();
  Future<void> selectImage() async {
    XFile? cover = await pickerimage.pickImage(source: ImageSource.gallery);
    if (cover != null) {
      imagename = cover.name;
      var f = await cover.readAsBytes();
      webimage = f;
      image = webimage;
      update();
    } else {}
  }

  void addbanner() {
    DioApp.uploadImage(url: ADDBANNER, data: {"image": imagename}, file: image)
        .then((value) {
      getbanners();
      removeimage();
    });
  }

  void removeimage() {
    image = [];
    update();
  }

  void removebanner(int idbanner) {
    DioApp.postData(url: REMOVEBANNER, data: {"id": idbanner}).then((value) {
      getbanners();
      Get.back();
    });
  }
}
