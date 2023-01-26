import 'package:clipboard/clipboard.dart';
import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/model/modelusers.dart';
import 'package:flutter/material.dart';

class ProfileUserScreen extends StatelessWidget {
  ModelUsers users;
  ProfileUserScreen(this.users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defText(text: users.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: users.image!,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(users.image!),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      defText(text: users.email == null ? " " : users.email!),
                      SizedBox(
                        height: 10,
                      ),
                      users.phonenumber == null
                          ? SizedBox(
                              width: 0,
                            )
                          : defText(text: users.phonenumber!),
                      SizedBox(
                        height: users.phonenumber == null ? 0 : 10,
                      ),
                      TextButton(
                          child: defText(text: users.uid!),
                          onPressed: () {
                            FlutterClipboard.copy(users.uid!)
                                .then((value) => print('copied'));
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 200,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black)),
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: defText(
                                                text:
                                                    "${users.location![index]}",
                                                size: 14,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 8,
                              );
                            },
                            itemCount: users.location!.length),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
