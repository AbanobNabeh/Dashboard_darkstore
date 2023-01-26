import 'package:dashboardstore/view/screen/product/productdetails.dart';
import 'package:dio/dio.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/model/modelcategory.dart';
import 'package:dashboardstore/model/modelproduct.dart';
import 'package:dashboardstore/network/dioapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  RxBool loadcategory = false.obs;
  List<ModelProduct> product = [];
  RxBool isloading = false.obs;
  RxBool productdetails = false.obs;
  RxInt errorimage = 0.obs;
  TextEditingController titlear = TextEditingController();
  TextEditingController titleen = TextEditingController();
  TextEditingController descriptionar = TextEditingController();
  TextEditingController descriptionen = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController discount = TextEditingController();
  RxInt active = 0.obs;
  RxString id_category = ''.obs;
  RxList category = [].obs;
  @override
  void onInit() {
    getproducts();
    super.onInit();
  }

  void getproducts() {
    isloading.value = true;
    product = [];
    DioApp.getData(url: PRODUCT).then((value) {
      value.data.forEach((element) {
        product.add(ModelProduct.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void deleteproduct(String uid) {
    DioApp.postData(url: DELETEPRODUCT, data: {'id': uid}).then((value) {
      getproducts();
      Get.back();
      Get.back();
    });
  }

  void getcategory() {
    loadcategory.value == true;
    category.value = [];
    DioApp.getData(url: CATEGORY).then((value) {
      print(value.data);
      value.data.forEach((element) {
        category.add(ModelCategory.fromJson(element));
      });
      loadcategory.value == false;
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

  ModelProduct? modelProduct;
  void editproductwithimage(
      {required int idproduct, required ModelProduct products}) async {
    modelProduct = ModelProduct(
      id: idproduct,
      active: active.value,
      idCategorie: int.parse(id_category.value),
      descriptionAr: descriptionar.text,
      descriptionEn: descriptionen.text,
      discount: int.parse(discount.text),
      titleAr: titlear.text,
      titleEn: titleen.text,
      quantity: int.parse(quantity.text),
      image: imagename,
      price: int.parse(price.text),
    );
    DioApp.uploadImage(
      url: EDITPRODUCT,
      data: modelProduct!.toMap(),
      file: image,
    ).then((value) {
      products.active = modelProduct!.active;
      products.idCategorie = modelProduct!.idCategorie;
      products.descriptionAr = modelProduct!.descriptionAr;
      products.descriptionEn = modelProduct!.descriptionEn;
      products.discount = modelProduct!.discount;
      products.titleAr = modelProduct!.titleAr;
      products.titleEn = modelProduct!.titleEn;
      products.quantity = modelProduct!.quantity;
      products.image = imagename;
      products.price = modelProduct!.price;
      getproducts();
      Get.back();
    });
  }

  void editproduct(
      {required int idproduct, required ModelProduct products}) async {
    isloading.value = true;
    modelProduct = ModelProduct(
      id: idproduct,
      active: active.value,
      idCategorie: int.parse(id_category.value),
      descriptionAr: descriptionar.text,
      descriptionEn: descriptionen.text,
      discount: int.parse(discount.text),
      titleAr: titlear.text,
      titleEn: titleen.text,
      quantity: int.parse(quantity.text),
      image: imagename,
      price: int.parse(price.text),
    );
    DioApp.postData(url: EDITPRODUCT, data: modelProduct!.toMap())
        .then((value) {
      products.active = modelProduct!.active;
      products.idCategorie = modelProduct!.idCategorie;
      products.descriptionAr = modelProduct!.descriptionAr;
      products.descriptionEn = modelProduct!.descriptionEn;
      products.discount = modelProduct!.discount;
      products.titleAr = modelProduct!.titleAr;
      products.titleEn = modelProduct!.titleEn;
      products.quantity = modelProduct!.quantity;
      products.image = imagename;
      products.price = modelProduct!.price;
      getproducts();
      Get.back();
    });
  }

  void addproduct() {
    modelProduct = ModelProduct(
      active: active.value,
      idCategorie: int.parse(id_category.value),
      descriptionAr: descriptionar.text,
      descriptionEn: descriptionen.text,
      discount: int.parse(discount.text),
      titleAr: titlear.text,
      titleEn: titleen.text,
      quantity: int.parse(quantity.text),
      image: imagename,
      price: int.parse(price.text),
    );
    DioApp.uploadImage(
            url: ADDPRODUCT, data: modelProduct!.toMap(), file: image)
        .then((value) {
      getproducts();
      image = null;
      titlear.text = '';
      titleen.text = '';
      descriptionar.text = '';
      descriptionen.text = '';
      Get.back();
    });
  }
}
