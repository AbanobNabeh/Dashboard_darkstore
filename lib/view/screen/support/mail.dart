import 'package:dashboardstore/components/components.dart';
import 'package:dashboardstore/controller/modelsupport.dart';
import 'package:dashboardstore/model/modelusers.dart';
import 'package:flutter/material.dart';

class MailScreen extends StatelessWidget {
  ModelSupport support;
  ModelUsers user;
  MailScreen(this.support, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defText(text: user.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.image!),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defText(
                          text: user.email == null
                              ? user.phonenumber!
                              : user.email!),
                      SelectableText(user.uid!,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              defText(text: support.message!),
              support.image != null ? Image.network(support.image!) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
