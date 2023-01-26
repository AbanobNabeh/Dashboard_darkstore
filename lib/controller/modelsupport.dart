import 'package:cloud_firestore/cloud_firestore.dart';

class ModelSupport {
  String? idsender;
  String? id;
  String? image;
  Timestamp? date;
  String? message;
  bool? seen;

  ModelSupport({this.idsender, this.image, this.date, this.message, this.seen});

  ModelSupport.fromJson(Map<String, dynamic> json) {
    idsender = json['idsender'];
    image = json['image'];
    date = json['date'];
    message = json['message'];
    seen = json['seen'];
    id = json['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idsender'] = this.idsender;
    data['image'] = this.image;
    data['date'] = this.date;
    data['message'] = this.message;
    data['seen'] = this.seen;
    data['id'] = this.id;
    return data;
  }
}
