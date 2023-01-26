class ModelCoupons {
  int? id;
  String? code;
  int? discount;
  int? active;

  ModelCoupons({this.id, this.code, this.discount, this.active});

  ModelCoupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['active'] = this.active;
    return data;
  }
}
