import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/ordercontroller.dart';
import 'package:dashboardstore/model/modelorder.dart';
import 'package:dashboardstore/view/screen/order/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<OrderController>(
        init: OrderController(),
        builder: (controller) => controller.isloading.value == true
            ? Center(
                child: defcirculer(),
              )
            : Padding(
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
                          Expanded(child: defText(text: 'orderid')),
                          Expanded(
                            child: defText(text: "name"),
                          ),
                          Expanded(
                            child: defText(text: 'phonenumber'),
                          ),
                          Expanded(
                            child: defText(text: "location"),
                          ),
                          Expanded(
                            child: defText(text: "totalamount"),
                          ),
                          Expanded(
                            child: defText(text: 'statusorder'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            ModelOrder order = controller.orders[index];
                            return InkWell(
                              onTap: () =>
                                  Get.to(() => OrderDetailsScreen(order)),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: defgraycolor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: defText(
                                              text: order.orderId.toString())),
                                      Expanded(
                                        child: defText(text: order.nameUser!),
                                      ),
                                      Expanded(
                                        child:
                                            defText(text: order.phonenumber!),
                                      ),
                                      Expanded(
                                        child: defText(text: order.location!),
                                      ),
                                      Expanded(
                                        child: defText(
                                            text:
                                                "${order.amountCents!.substring(0, order.amountCents!.length - 2)}\$"),
                                      ),
                                      Expanded(
                                        child: defText(
                                            text: order.statusOrder!,
                                            color:
                                                order.statusOrder == "delivered"
                                                    ? Colors.green
                                                    : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 7,
                            );
                          },
                          itemCount: controller.orders.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
