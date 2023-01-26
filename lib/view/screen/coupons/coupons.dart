import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/couponscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CouponsController>(
      init: CouponsController(),
      builder: (controller) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: defgraycolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(child: defText(text: 'id')),
                    Expanded(
                      child: defText(text: 'code'),
                    ),
                    Expanded(
                      child: defText(text: 'discount'),
                    ),
                    Expanded(
                      child: defText(text: "active"),
                    ),
                  ],
                ),
              ),
              controller.isloading.value == true
                  ? Center(
                      child: defcirculer(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              int indexed = index + 1;
                              return Container(
                                color: defgraycolor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child:
                                            defText(text: indexed.toString())),
                                    Expanded(
                                      child: defText(
                                          text: controller
                                              .coupons.value[index].code),
                                    ),
                                    Expanded(
                                      child: defText(
                                          text:
                                              "${controller.coupons.value[index].discount}%"),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          controller.coupons.value[index]
                                                      .active ==
                                                  1
                                              ? controller.disablecoupon(
                                                  controller
                                                      .coupons.value[index].id)
                                              : controller.enablecoupon(
                                                  controller
                                                      .coupons.value[index].id);
                                        },
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: defText(
                                              text: controller
                                                          .coupons
                                                          .value[index]
                                                          .active ==
                                                      1
                                                  ? "disable"
                                                  : "enable",
                                              color: controller
                                                          .coupons
                                                          .value[index]
                                                          .active ==
                                                      1
                                                  ? Colors.red
                                                  : secondcolor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: controller.coupons.length),
                      ),
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>
                Get.bottomSheet(addcoupon(), backgroundColor: defgraycolor),
            label: defText(text: 'addcoupon'),
            backgroundColor: defgraycolor,
            icon: Icon(Icons.add)),
      ),
    );
  }
}

Widget addcoupon() {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  return GetX<CouponsController>(
    builder: (controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formstate,
          child: Center(
            child: Column(
              children: [
                defTextForm(
                    controller: controller.code,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'code'.tr;
                      }
                    },
                    hint: "code"),
                SizedBox(
                  height: 10,
                ),
                defTextForm(
                    textInputType: TextInputType.number,
                    controller: controller.discount,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'discount'.tr;
                      }
                    },
                    hint: "discount"),
                SizedBox(
                  height: 10,
                ),
                controller.error == ""
                    ? SizedBox()
                    : defText(text: controller.error.value, color: Colors.red),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defbutton(
                        width: 200,
                        text: 'add',
                        tap: () {
                          if (formstate.currentState!.validate()) {
                            controller.addcoupon();
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
      ),
    ),
  );
}
