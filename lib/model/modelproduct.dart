class ModelProduct {
  int? id;
  String? titleAr;
  String? titleEn;
  String? descriptionAr;
  String? descriptionEn;
  int? quantity;
  int? rate;
  int? idCategorie;
  int? price;
  int? discount;
  int? active;
  String? image;

  ModelProduct(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.descriptionAr,
      this.descriptionEn,
      this.quantity,
      this.rate,
      this.idCategorie,
      this.price,
      this.discount,
      this.active,
      this.image});

  ModelProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    quantity = json['quantity'];
    rate = json['rate'];
    idCategorie = json['id_categorie'];
    price = json['price'];
    discount = json['discount'];
    active = json['active'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['id_categorie'] = this.idCategorie;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['active'] = this.active;
    data['image'] = this.image;
    return data;
  }
}
