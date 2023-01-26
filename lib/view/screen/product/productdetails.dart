import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/controller/productcontroller.dart';
import 'package:dashboardstore/model/modelproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  ModelProduct product;
  ProductDetails(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<ProductController>(
      builder: (controller) {
        return controller.isloading.value == true
            ? Scaffold(
                body: Center(
                  child: defcirculer(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: defText(
                      text: trans() == 'ar'
                          ? product.titleAr!
                          : product.titleEn!),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Hero(
                              tag: product.image!,
                              child: Image.network(
                                "$STORAGE${product.image!}",
                                width: size.width / 3,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width / 2,
                                child: defText(
                                    text: trans() == 'ar'
                                        ? product.descriptionAr!
                                        : product.descriptionEn!),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      defText(
                                          text: "quantity",
                                          color: Colors.grey.withOpacity(0.3)),
                                      defText(
                                          text: "${product.quantity}",
                                          color: product.quantity == 0
                                              ? Colors.red
                                              : Colors.green),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      defText(
                                          text: "price",
                                          color: Colors.grey.withOpacity(0.3)),
                                      defText(
                                          text: "${product.price}",
                                          color: Colors.green),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      defText(
                                          text: "discount",
                                          color: Colors.grey.withOpacity(0.3)),
                                      defText(
                                          text: "${product.discount}%",
                                          color: product.discount == 0
                                              ? Colors.red
                                              : Colors.green),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              defText(
                                  text: product.active == 1
                                      ? "instock"
                                      : 'outstock',
                                  color: product.active == 0
                                      ? Colors.red
                                      : Colors.green),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                            editproduct(product, context));
                                      },
                                      child: Center(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              defText(text: "edit", size: 20)
                                            ]),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: 'alert'.tr,
                                          middleText: 'note'.tr,
                                          textConfirm: 'delete'.tr,
                                          onConfirm: () {
                                            controller.deleteproduct(
                                                product.id.toString());
                                          },
                                          confirmTextColor: Colors.white,
                                          buttonColor: Colors.red,
                                          textCancel: 'cancel'.tr,
                                        );
                                      },
                                      child: defText(
                                          text: 'delete', color: Colors.red))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}

Widget editproduct(ModelProduct product, BuildContext context) {
  ProductController controller = Get.put(ProductController());
  controller.getcategory();
  controller.titlear.text = product.titleAr!;
  controller.titleen.text = product.titleEn!;
  controller.descriptionar.text = product.descriptionAr!;
  controller.descriptionen.text = product.descriptionEn!;
  controller.price.text = product.price.toString();
  controller.active.value = product.active!;
  controller.id_category.value = product.idCategorie.toString();
  controller.quantity.text = product.quantity.toString();
  controller.discount.text = product.discount.toString();
  controller.imagename = product.image;
  controller.image = null;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  return SingleChildScrollView(
    child: Container(
      color: defgraycolor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetX<ProductController>(
          builder: (controller) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GetBuilder<ProductController>(
                  builder: (controller) => InkWell(
                      onTap: () {
                        controller.selectImage();
                      },
                      child: controller.image == null
                          ? Container(
                              child: Image(
                                image: NetworkImage("$STORAGE${product.image}"),
                              ),
                            )
                          : Image.memory(
                              controller.webimage,
                              fit: BoxFit.fill,
                            )),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defText(text: 'title'),
                        defTextForm(
                            controller: controller.titlear,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'title'.tr;
                              }
                            },
                            hint: "arabic"),
                        SizedBox(
                          height: 5,
                        ),
                        defTextForm(
                            controller: controller.titleen,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'title'.tr;
                              }
                            },
                            hint: "english"),
                        SizedBox(
                          height: 10,
                        ),
                        defText(text: 'description'),
                        defTextForm(
                            maxLines: 7,
                            controller: controller.descriptionar,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'description'.tr;
                              }
                            },
                            hint: "arabic"),
                        SizedBox(
                          height: 5,
                        ),
                        defTextForm(
                            maxLines: 7,
                            controller: controller.descriptionen,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'description'.tr;
                              }
                            },
                            hint: "english"),
                        SizedBox(
                          height: 10,
                        ),
                        defText(text: 'price'),
                        defTextForm(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputType: TextInputType.number,
                            controller: controller.price,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'price'.tr;
                              }
                            },
                            hint: "price"),
                        SizedBox(
                          height: 10,
                        ),
                        defText(text: 'quantity'),
                        defTextForm(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputType: TextInputType.number,
                            controller: controller.quantity,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'quantity'.tr;
                              }
                            },
                            hint: "quantity"),
                        SizedBox(
                          height: 10,
                        ),
                        defText(text: 'discount'),
                        defTextForm(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputType: TextInputType.number,
                            controller: controller.discount,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'discount'.tr;
                              }
                            },
                            hint: "discount"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            defText(text: 'active'),
                            SizedBox(
                              width: 15,
                            ),
                            DropdownButton(
                              dropdownColor: defcolor,
                              focusColor: defcolor,
                              items: ['yes'.tr, 'no'.tr]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: defText(
                                            text: e,
                                            color: Colors.white,
                                            size: 16),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.active.value =
                                    value == 'yes'.tr ? 1 : 0;
                              },
                              value: controller.active.value == 1
                                  ? 'yes'.tr
                                  : 'no'.tr,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            defText(text: 'categories'),
                            SizedBox(
                              width: 15,
                            ),
                            controller.loadcategory.value == true
                                ? Center(
                                    child: defcirculer(),
                                  )
                                : DropdownButton(
                                    dropdownColor: defcolor,
                                    focusColor: defcolor,
                                    items: controller.category.value
                                        .map((e) => DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: defText(
                                                  text: trans() == "ar"
                                                      ? e.nameAr
                                                      : e.nameEn,
                                                  color: Colors.white,
                                                  size: 16),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      print(value);
                                      controller.id_category.value = value!;
                                    },
                                    value: controller.id_category.value,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        controller.isloading.value == true
                            ? defcirculer()
                            : Row(
                                children: [
                                  defbutton(
                                      width: 200,
                                      text: 'edit',
                                      tap: () {
                                        if (formstate.currentState!
                                            .validate()) {
                                          controller.image == null
                                              ? controller.editproduct(
                                                  idproduct: product.id!,
                                                  products: product)
                                              : controller.editproductwithimage(
                                                  idproduct: product.id!,
                                                  products: product);
                                        }
                                      }),
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: defText(
                                        text: 'cancel', color: Colors.red),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
