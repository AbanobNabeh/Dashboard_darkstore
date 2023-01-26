import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/controller/bannerscontroller.dart';
import 'package:dashboardstore/model/modelbanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<BannersController>(
        init: BannersController(),
        builder: (controller) => controller.isloading.value == true
            ? Center(
                child: defcirculer(),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GetBuilder<BannersController>(
                      builder: (controller) {
                        return controller.image.isEmpty
                            ? InkWell(
                                onTap: () {
                                  controller.selectImage();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  child: defborder(
                                      child: Center(
                                          child:
                                              defText(text: "addnewbanner"))),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.memory(
                                    controller.webimage,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defbutton(
                                          width: 200,
                                          text: 'add',
                                          tap: () => controller.addbanner()),
                                      TextButton(
                                        onPressed: () =>
                                            controller.removeimage(),
                                        child: defText(
                                            text: 'cancel', color: Colors.red),
                                      )
                                    ],
                                  ),
                                ],
                              );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            ModelBanner banner = controller.banners[index];
                            return Container(
                              height: 250,
                              width: double.infinity,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        "$STORAGE${banner.banner}"),
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: 'alert'.tr,
                                        middleText: 'removebanner'.tr,
                                        textConfirm: 'delete'.tr,
                                        onConfirm: () {
                                          controller.removebanner(banner.id!);
                                        },
                                        confirmTextColor: Colors.white,
                                        buttonColor: Colors.red,
                                        textCancel: 'cancel'.tr,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: controller.banners.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
