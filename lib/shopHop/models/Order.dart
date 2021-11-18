
class Order {
  Order({
    int? id,
    int? customerId,
    String? status,
    String? shipping,
    String? tax,
    String? discount,
    String? total,
    String? currency,
    dynamic shippingCompany,
    String? shippingPhone,
    String? shippingCountry,
    String? shippingCity,
    String? shippingRegion,
    String? shippingZip,
    String? paymentMethod,
    String? shippingMethod,
    Order_data? orderData,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _customerId = customerId;
    _status = status;
    _shipping = shipping;
    _tax = tax;
    _discount = discount;
    _total = total;
    _currency = currency;
    _shippingCompany = shippingCompany;
    _shippingPhone = shippingPhone;
    _shippingCountry = shippingCountry;
    _shippingCity = shippingCity;
    _shippingRegion = shippingRegion;
    _shippingZip = shippingZip;
    _paymentMethod = paymentMethod;
    _shippingMethod = shippingMethod;
    // _orderData = orderData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Order.fromJson(dynamic json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _status = json['status'];
    _shipping = json['shipping'];
    _tax = json['tax'];
    _discount = json['discount'];
    _total = json['total'];
    _currency = json['currency'];
    _shippingCompany = json['shipping_company'];
    _shippingPhone = json['shipping_phone'];
    _shippingCountry = json['shipping_country'];
    _shippingCity = json['shipping_city'];
    _shippingRegion = json['shipping_region'];
    _shippingZip = json['shipping_zip'];
    _paymentMethod = json['payment_method'];
    _shippingMethod = json['shipping_method'];
    // _orderData = json['order_data'] != null ? Order_data.fromJson(json['orderData']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _customerId;
  String? _status;
  String? _shipping;
  String? _tax;
  String? _discount;
  String? _total;
  String? _currency;
  dynamic _shippingCompany;
  String? _shippingPhone;
  String? _shippingCountry;
  String? _shippingCity;
  String? _shippingRegion;
  String? _shippingZip;
  String? _paymentMethod;
  String? _shippingMethod;
  // Order_data? _orderData;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get customerId => _customerId;
  String? get status => _status;
  String? get shipping => _shipping;
  String? get tax => _tax;
  String? get discount => _discount;
  String? get total => _total;
  String? get currency => _currency;
  dynamic get shippingCompany => _shippingCompany;
  String? get shippingPhone => _shippingPhone;
  String? get shippingCountry => _shippingCountry;
  String? get shippingCity => _shippingCity;
  String? get shippingRegion => _shippingRegion;
  String? get shippingZip => _shippingZip;
  String? get paymentMethod => _paymentMethod;
  String? get shippingMethod => _shippingMethod;
  // Order_data? get orderData => _orderData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_id'] = _customerId;
    map['status'] = _status;
    map['shipping'] = _shipping;
    map['tax'] = _tax;
    map['discount'] = _discount;
    map['total'] = _total;
    map['currency'] = _currency;
    map['shipping_company'] = _shippingCompany;
    map['shipping_phone'] = _shippingPhone;
    map['shipping_country'] = _shippingCountry;
    map['shipping_city'] = _shippingCity;
    map['shipping_region'] = _shippingRegion;
    map['shipping_zip'] = _shippingZip;
    map['payment_method'] = _paymentMethod;
    map['shipping_method'] = _shippingMethod;
    // if (_orderData != null) {
    //   map['order_data'] = _orderData?.toJson();
    // }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

  static List<Order> getListFromJson(List<dynamic> jsonArray) {
    List<Order> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Order.fromJson(jsonArray[i]));
    }
    return list;
  }
}

class Order_data {
  ItemsList1? itemsList;
  String? subTotalPrice;
  String? totalPrice;
  int? totalQty;
  String? originalPrice;
  bool? hasOrder;
  bool? couponApplied;
  int? discountAmount;
  int? frameAmount;

  Order_data({this.itemsList, this.subTotalPrice, this.totalPrice, this.totalQty, this.originalPrice, this.hasOrder, this.couponApplied, this.discountAmount, this.frameAmount});

  Order_data.fromJson(Map<String, dynamic> json) {

    // print( json["order_data"]['items']);
    itemsList = (json["order_data"] != null) ? ItemsList1.fromJson(json["order_data"]['items']) : ItemsList1(items: []);
    subTotalPrice = json['subTotalPrice'];
    totalPrice = json['totalPrice'];
    totalQty = json['totalQty'];
    originalPrice = json['originalPrice'];
    hasOrder = json['hasOrder'];
    couponApplied = json['couponApplied'];
    discountAmount = json['discountAmount'];
    frameAmount = json['frameAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.items != null) {
    //   data['items'] = this.items!.toJson();
    // }
    data['subTotalPrice'] = this.subTotalPrice;
    data['totalPrice'] = this.totalPrice;
    data['totalQty'] = this.totalQty;
    data['originalPrice'] = this.originalPrice;
    data['hasOrder'] = this.hasOrder;
    data['couponApplied'] = this.couponApplied;
    data['discountAmount'] = this.discountAmount;
    data['frameAmount'] = this.frameAmount;
    return data;
  }
}

class ItemsList1 {
  List<Item1>? items;
  ItemsList1({required List<Item1> this.items,});

  //json =  {
  //             "188": {
  //                 "product_id": "188",
  //                 "count": "2",
  //                 "image_url": "https://www.cottonnatural.com/wp-content/uploads/2016/09/DSC_8351-scaled.jpg",
  //                 "name": "St. Lucia Pants",
  //                 "price": "75.00",
  //                 "slug": "st-lucia-pants",
  //                 "size": "X-Large"
  //             },
  //             "189": {
  //                 "product_id": "189",
  //                 "count": "3",
  //                 "image_url": "https://www.cottonnatural.com/wp-content/uploads/2016/09/DSC_8351-scaled.jpg",
  //                 "name": "St. Lucia Pants",
  //                 "price": "75.00",
  //                 "slug": "st-lucia-pants",
  //                 "size": "Large"
  //             }
  //         },
  ItemsList1.fromJson(dynamic mapJson) {
    // print('****************************************');
    // mapJson.forEach((key, value) {
    //   print('key : $key');
    //   print('value  : $value');
    // });

    List<Item1> itemsListX = [];
    mapJson.forEach((key, value) {
      itemsListX.add(Item1.fromJson(value));
      this.items = itemsListX;
    });
  }

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   if (items != null) {
  //     map['Item'] = items?.toJson();
  //   }
  //   return map;
  // }

  static List<ItemsList1> getListFromJson(List<dynamic> jsonArray) {
    List<ItemsList1> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(ItemsList1.fromJson(jsonArray[i]));
    }
    return list;
  }

}

class Item1 {

  String? _productId;
  String? _count;
  String? _imageUrl;
  String? _name;
  String? _price;
  String? _slug;
  String? _size;

  Item1({
    String? productId,
    String? count,
    String? imageUrl,
    String? name,
    String? price,
    String? slug,
    String? size,}){
    _productId = productId;
    _count = count;
    _imageUrl = imageUrl;
    _name = name;
    _price = price;
    _slug = slug;
    _size = size;
  }

  Item1.fromJson(dynamic json) {
    _productId = json['product_id'];
    _count = json['count'];
    _imageUrl = json['image_url'];
    _name = json['name'];
    _price = json['price'];
    _slug = json['slug'];
    _size = json['size'];
  }

  String? get productId => _productId;
  String? get count => _count;
  String? get imageUrl => _imageUrl;
  String? get name => _name;
  String? get price => _price;
  String? get slug => _slug;
  String? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['count'] = _count;
    map['image_url'] = _imageUrl;
    map['name'] = _name;
    map['price'] = _price;
    map['slug'] = _slug;
    map['size'] = _size;
    return map;
  }
}