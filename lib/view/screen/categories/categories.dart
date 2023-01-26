import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/controller/categoriescontroller.dart';
import 'package:dashboardstore/model/modelcategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/constants.dart';

class CategoriesScrren extends StatelessWidget {
  const CategoriesScrren({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetX<CategoriesController>(
          init: CategoriesController(),
          builder: (controller) {
            return controller.isloading.value == true
                ? Center(child: defcirculer())
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
                        return viewcategory(controller.category[index]);
                      },
                      itemCount: controller.category.length,
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.bottomSheet(addcategory());
          },
          label: defText(text: 'addcategory'),
          backgroundColor: defgraycolor,
          icon: Icon(Icons.add)),
    );
  }
}

Widget viewcategory(ModelCategory category) {
  return GetBuilder<CategoriesController>(
    builder: (controller) => InkWell(
      onLongPress: () => Get.bottomSheet(editcategory(category, controller)),
      child: Card(
        color: defgraycolor,
        child: Column(
          children: [
            Expanded(
              child: Image(image: NetworkImage('$STORAGE${category.image}')),
            ),
            defText(
              text: trans() == 'ar' ? category.nameAr! : category.nameEn!,
            )
          ],
        ),
      ),
    ),
  );
}

Widget editcategory(ModelCategory category, CategoriesController controller) {
  controller.namear.text = category.nameAr.toString();
  controller.nameen.text = category.nameEn.toString();
  controller.image = null;
  controller.imagename = category.image;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  return Container(
    color: defgraycolor,
    child: SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formstate,
        child: Row(
          children: [
            Expanded(
              child: GetBuilder<CategoriesController>(
                builder: (controller) => InkWell(
                    onTap: () {
                      controller.selectImage();
                    },
                    child: controller.image == null
                        ? Container(
                            child: Image(
                              image: NetworkImage("$STORAGE${category.image}"),
                            ),
                          )
                        : Image.memory(
                            controller.webimage,
                            fit: BoxFit.fill,
                          )),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defText(text: 'name'),
                  defTextForm(
                      controller: controller.namear,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name'.tr;
                        }
                      },
                      hint: "arabic"),
                  SizedBox(
                    height: 5,
                  ),
                  defTextForm(
                      controller: controller.nameen,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name'.tr;
                        }
                      },
                      hint: "english"),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      defbutton(
                          width: 200,
                          text: 'edit',
                          tap: () {
                            if (formstate.currentState!.validate()) {
                              if (controller.image == null) {
                                controller.editcategory(idcate: category.id!);
                              } else {
                                controller.editcateimage(idcate: category.id!);
                              }
                            }
                          }),
                      TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            middleText: 'deletenote'.tr,
                            title: 'alert'.tr,
                            buttonColor: Colors.red,
                            textConfirm: 'delete'.tr,
                            confirmTextColor: Colors.white,
                            textCancel: 'cancel'.tr,
                            onConfirm: () =>
                                controller.deletecategory(idcate: category.id!),
                          );
                        },
                        child: defText(text: 'delete', color: Colors.red),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )),
  );
}

Widget addcategory() {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  return Container(
    color: defgraycolor,
    child: GetX<CategoriesController>(
      builder: (controller) => SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formstate,
          child: Row(
            children: [
              Expanded(
                child: GetBuilder<CategoriesController>(
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
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defText(text: 'name'),
                    defTextForm(
                        controller: controller.namear,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name'.tr;
                          }
                        },
                        hint: "arabic"),
                    SizedBox(
                      height: 5,
                    ),
                    defTextForm(
                        controller: controller.nameen,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name'.tr;
                          }
                        },
                        hint: "english"),
                    SizedBox(
                      height: 15,
                    ),
                    controller.errorimage == 1
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
                                  controller.addcategory();
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
              )
            ],
          ),
        ),
      )),
    ),
  );
}
