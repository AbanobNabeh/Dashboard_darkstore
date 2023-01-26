import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/controller/userscontroller.dart';
import 'package:dashboardstore/model/modelusers.dart';
import 'package:dashboardstore/view/screen/users/profileuser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<UsersController>(
      init: UsersController(),
      builder: (controller) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: controller.isloading.value == true
              ? Center(
                  child: defcirculer(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 250,
                      child: TextFormField(
                        onChanged: (value) {
                          controller.searchuser(value);
                        },
                        textDirection: trans() == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        controller: controller.searchcont,
                        validator: (value) {},
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: secondcolor,
                              ),
                            ),
                            fillColor: defgraycolor,
                            filled: true,
                            hintText: 'search'.tr),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                            int indexed = index + 1;
                            ModelUsers users =
                                controller.search.value.isNotEmpty
                                    ? controller.search[index]
                                    : controller.users[index];
                            return InkWell(
                              onTap: () =>
                                  Get.to(() => ProfileUserScreen(users)),
                              hoverColor: Colors.grey[500],
                              child: Card(
                                color: defgraycolor,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 32,
                                            backgroundColor: secondcolor,
                                          ),
                                          Hero(
                                            tag: users.image!,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                                  NetworkImage(users.image!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      defText(
                                          text: users.name!,
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: controller.search.value.isNotEmpty
                              ? controller.search.length
                              : controller.users.length,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
