import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/controller/productcontroller.dart';
import 'package:dashboardstore/model/modelproduct.dart';
import 'package:dashboardstore/view/screen/product/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      body: GetX<ProductController>(
        init: ProductController(),
        builder: (controller) => controller.isloading.value == true
            ? Center(
                child: defcirculer(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width >= 1280
                        ? 6
                        : size.width >= 880
                            ? 4
                            : size.width >= 620
                                ? 2
                                : 1,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return products(controller.product[index], context);
                  },
                  itemCount: controller.product.length,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.bottomSheet(
              addproduct(),
              backgroundColor: defgraycolor,
            );
          },
          label: defText(text: 'addproduct'),
          backgroundColor: defgraycolor,
          icon: Icon(Icons.add)),
    );
  }
}

Widget addproduct() {
  ProductController controller = Get.put(ProductController());
  controller.getcategory();
  controller.id_category.value = '1';
  controller.active.value = 1;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  return GetX<ProductController>(
    builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: GetBuilder<ProductController>(
                  builder: (controller) => InkWell(
                      onTap: () {
                        controller.selectImage();
                      },
                      child: controller.image == null
                          ? defborder(
                              child: Center(
                                  child: defText(
                              text: 'addphoto',
                            )))
                          : Image.memory(
                              controller.webimage,
                              fit: BoxFit.fill,
                            )),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Form(
                key: formstate,
                child: Expanded(
                  flex: 2,
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                    controller.id_category.value = value!;
                                  },
                                  value: controller.id_category.value,
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      controller.errorimage.value == 1
                          ? defText(text: 'addphoto', color: Colors.red)
                          : SizedBox(
                              width: 0,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          defbutton(
                              width: 200,
                              text: 'add',
                              tap: () {
                                if (controller.image == null) {
                                  controller.errorimage.value = 1;
                                } else {
                                  controller.errorimage.value = 0;
                                  if (formstate.currentState!.validate()) {
                                    controller.addproduct();
                                  }
                                }
                              }),
                          TextButton(
                            onPressed: () => Get.back(),
                            child: defText(text: 'cancel', color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    },
  );
}

Widget products(ModelProduct product, BuildContext context) => InkWell(
      onTap: () {
        Get.to(() => ProductDetails(product));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            HexColor('FFFFFF').withOpacity(0),
            HexColor('F4F5F8').withOpacity(0.3),
          ], begin: FractionalOffset(1, 0.0)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                  tag: product.image!,
                  child:
                      Image(image: NetworkImage("${STORAGE}${product.image}"))),
            ),
            defText(
                text: trans() == 'ar' ? product.titleAr! : product.titleEn!,
                maxlines: 1,
                size: 16)
          ],
        ),
      ),
    );
