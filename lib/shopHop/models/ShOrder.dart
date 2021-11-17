class ShOrder {
  Item? item;
  // ignore: non_constant_identifier_names
  String? order_date;
  // ignore: non_constant_identifier_names
  String? order_status;
  // ignore: non_constant_identifier_names
  String? order_number;
  ShippingMethod? shipping_method;


  // ignore: non_constant_identifier_names
  ShOrder({this.item, this.order_date, this.order_status, this.order_number, this.shipping_method});

  factory ShOrder.fromJson(Map<String, dynamic> json) {
    return ShOrder(
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      order_date: json['order_date'],
      order_status: json['order_status'],
      order_number: json['order_number'],
      shipping_method: ShippingMethod.fromJson(json['shipping_method']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_date'] = this.order_date;
    data['order_status'] = this.order_status;
    data['order_number'] = this.order_number;
    data['shipping_method'] = this.shipping_method!.toJson();
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? price;
  String? image;
  int? count;
  String? size;

  Item({this.id, this.name, this.price, this.image,this.count,this.size});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      count: json['count'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['count'] = this.count;
    data['size'] = this.size;
    return data;
  }
}

class ShippingMethod {
  String? id;
  String? name;
  String? price;
  String? description;

  ShippingMethod({ this.id,this.name, this.price, this.description});

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
