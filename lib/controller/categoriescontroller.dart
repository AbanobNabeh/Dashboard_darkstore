import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../components/linkapi.dart';
import '../model/modelcategory.dart';
import '../network/dioapp.dart';

class CategoriesController extends GetxController {
  RxBool isloading = false.obs;
  RxList category = [].obs;
  TextEditingController namear = TextEditingController();
  TextEditingController nameen = TextEditingController();
  RxInt errorimage = 0.obs;
  @override
  void onInit() {
    getcategory();
    super.onInit();
  }

  void getcategory() {
    isloading.value = true;
    category.value = [];
    DioApp.getData(url: CATEGORY).then((value) {
      value.data.forEach((element) {
        category.add(ModelCategory.fromJson(element));
      });
      isloading.value = false;
    });
  }

  List<int>? image;
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

  ModelCategory? modelCategory;

  void addcategory() {
    modelCategory = ModelCategory(
        nameAr: namear.text, nameEn: nameen.text, image: imagename);
    DioApp.uploadImage(
            url: ADDCATEGORY, data: modelCategory!.toMap(), file: image)
        .then((value) {
      namear.text = '';
      nameen.text = '';
      image = null;

      getcategory();
      Get.back();
    });
  }

  void deletecategory({required int idcate}) {
    DioApp.postData(url: DELETECATEGORY, data: {'id': idcate}).then((value) {
      getcategory();
      Get.back();
      Get.back();
    });
  }

  void editcategory({required int idcate}) {
    modelCategory = ModelCategory(
        nameAr: namear.text, nameEn: nameen.text, image: imagename, id: idcate);
    DioApp.postData(url: EDITCATEGORY, data: modelCategory!.toMap())
        .then((value) {
      getcategory();
      Get.back();
    });
  }

  void editcateimage({required int idcate}) {
    modelCategory = ModelCategory(
        nameAr: namear.text, nameEn: nameen.text, image: imagename, id: idcate);
    DioApp.uploadImage(
            url: EDITCATEGORY, data: modelCategory!.toMap(), file: image)
        .then((value) {
      getcategory();
      Get.back();
    });
  }
}
