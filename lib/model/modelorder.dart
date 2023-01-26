class ModelOrder {
  int? id;
  int? orderId;
  String? location;
  String? phonenumber;
  String? idUser;
  String? statusOrder;
  String? amountCents;
  String? nameUser;
  String? updatedAt;
  String? createdAt;
  List<Products>? products;
  List<Cart>? cart;

  ModelOrder(
      {this.id,
      this.orderId,
      this.location,
      this.phonenumber,
      this.idUser,
      this.statusOrder,
      this.amountCents,
      this.nameUser,
      this.updatedAt,
      this.createdAt,
      this.products,
      this.cart});

  ModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    location = json['location'];
    phonenumber = json['phonenumber'];
    idUser = json['id_user'];
    statusOrder = json['status_order'];
    amountCents = json['amount_cents'];
    nameUser = json['name_user'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['location'] = this.location;
    data['phonenumber'] = this.phonenumber;
    data['id_user'] = this.idUser;
    data['status_order'] = this.statusOrder;
    data['amount_cents'] = this.amountCents;
    data['name_user'] = this.nameUser;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
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

class Cart {
  int? id;
  int? idProduct;
  String? idUser;
  String? status;
  int? quantityCart;
  int? orderId;

  Cart(
      {this.id,
      this.idProduct,
      this.idUser,
      this.status,
      this.quantityCart,
      this.orderId});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['id_product'];
    idUser = json['id_user'];
    status = json['status'];
    quantityCart = json['quantity_cart'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_product'] = this.idProduct;
    data['id_user'] = this.idUser;
    data['status'] = this.status;
    data['quantity_cart'] = this.quantityCart;
    data['order_id'] = this.orderId;
    return data;
  }
}
