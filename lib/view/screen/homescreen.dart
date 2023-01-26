import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/homecontroller.dart';
import 'package:dashboardstore/locale/LocaleController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defText(text: 'appname'),
        leading: InkWell(
          onTap: () {
            controller.menubar.value = !controller.menubar.value;
            print(controller.menubar.value);
          },
          child: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.put(LocaleController())
                    .changelang(trans() == 'ar' ? "en" : "ar");
              },
              icon: Icon(Icons.language)),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'logout'.tr,
                    middleText: 'logoutmessage'.tr,
                    textConfirm: 'logout'.tr,
                    textCancel: 'cancel'.tr,
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    onConfirm: () => controller.logout());
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: GetX<HomeController>(builder: (controller) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: controller.menubar.value == true ? 200 : 80,
              height: double.infinity,
              color: defgraycolor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    List<Widget> itemlist = [
                      item(Icons.home, 'home', index, 0),
                      item(Icons.category, 'categories', index, 0),
                      item(Icons.person, 'users', index, 0),
                      item(Icons.shopping_cart_rounded, 'orders', index, 0),
                      item(Icons.closed_caption, 'coupons', index, 0),
                      item(Icons.signpost_rounded, 'banners', index, 0),
                      GetX<HomeController>(
                        builder: (controller) => item(Icons.support_agent,
                            'support', index, controller.seen.value),
                      ),
                    ];
                    return itemlist[index];
                  },
                  itemCount: 7,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 7,
                  ),
                ),
              ),
            ),
            Expanded(
              child: controller.screen[controller.curentindex.value],
            )
          ],
        );
      }),
    );
  }
}

Widget item(IconData iconData, String text, int index, int seen) {
  return GetX<HomeController>(
    builder: (controller) => InkWell(
      onTap: () {
        controller.curentindex.value = index;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: defcolor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              defborder(
                  child: seen == 0
                      ? Icon(
                          iconData,
                          color: controller.curentindex.value == index
                              ? secondcolor
                              : Colors.grey,
                        )
                      : Center(
                          child: defText(
                              text: seen.toString(),
                              color: controller.curentindex.value == index
                                  ? secondcolor
                                  : Colors.red,
                              size: 16,
                              overflow: TextOverflow.ellipsis)),
                  width: 40,
                  height: 40),
              SizedBox(
                width: 7,
              ),
              Visibility(
                  visible: controller.menubar.value,
                  child: defText(
                      text: text,
                      size: 16,
                      color: controller.curentindex.value == index
                          ? secondcolor
                          : Colors.grey)),
            ],
          ),
        ),
      ),
    ),
  );
}
