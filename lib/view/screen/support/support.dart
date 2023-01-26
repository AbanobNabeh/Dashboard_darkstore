import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/homecontroller.dart';
import 'package:dashboardstore/controller/modelsupport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
        builder: (controller) => controller.isloading.value == true
            ? Center(
                child: defcirculer(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      ModelSupport support = controller.support[index];
                      return InkWell(
                        onTap: () {
                          controller.read(support);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: defgraycolor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                support.seen == true
                                    ? SizedBox(
                                        width: 0,
                                      )
                                    : Icon(
                                        Icons.mail_lock_outlined,
                                        color: Colors.white,
                                      ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                    child: defText(
                                  text: support.message!,
                                  maxlines: 1,
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: controller.support.length),
              ),
      ),
    );
  }
}
