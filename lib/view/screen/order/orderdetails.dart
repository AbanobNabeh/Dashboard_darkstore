import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/components/linkapi.dart';
import 'package:dashboardstore/controller/ordercontroller.dart';
import 'package:dashboardstore/model/modelorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  ModelOrder order;
  OrderDetailsScreen(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<OrderController>(
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Products products = order.products![index];
                        return Container(
                          height: 300,
                          width: 250,
                          color: defgraycolor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    '$STORAGE${products.image}',
                                  ),
                                ),
                                defText(
                                  text: trans() == 'ar'
                                      ? products.titleAr!
                                      : products.titleEn!,
                                ),
                                Row(
                                  children: [
                                    defText(
                                      text:
                                          "${order.cart![index].quantityCart}X",
                                    ),
                                    Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: 7,
                          ),
                      itemCount: order.products!.length),
                ),
                SizedBox(
                  height: 25,
                ),
                defText(text: 'orderdetails', color: Colors.grey),
                SizedBox(
                  height: 10,
                ),
                orderdetails('name', order.nameUser!),
                orderdetails('phonenumber', order.phonenumber!),
                orderdetails('totalamount',
                    "${order.amountCents!.substring(0, order.amountCents!.length - 2)}\$"),
                orderdetails('orderdate', order.createdAt!),
                orderdetails('statusorder', controller.statusorder(order)),
                orderdetails('location', order.location!),
                SizedBox(
                  height: 25,
                ),
                order.statusOrder == "delivered"
                    ? SizedBox(
                        width: 0,
                      )
                    : Row(
                        children: [
                          defbutton(
                              text: order.statusOrder == "inreview"
                                  ? "reviewed"
                                  : order.statusOrder == "confirmation"
                                      ? "outfordelivery"
                                      : order.statusOrder == "indelivery"
                                          ? "delivered"
                                          : "",
                              tap: () => controller.updateorder(order),
                              width: 200,
                              colors: Colors.black,
                              boxshade: false),
                          TextButton(
                              onPressed: () => Get.back(),
                              child: defText(text: "back", color: Colors.red))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget orderdetails(String key, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      defText(text: key),
      SizedBox(
        width: 15,
      ),
      Expanded(child: defText(text: value)),
    ],
  );
}
