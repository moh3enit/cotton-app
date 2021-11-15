
class ShProduct {
  int? id;
  String? sku;
  String? name;
  int? active;
  bool? featured;
  String? short_description;
  String? description;
  String? sale_start_date;
  String? sale_end_date;
  int? in_stock;
  List<dynamic>? weight;
  Dimensions? dimensions;
  String? sale_price;
  String? price;
  List<dynamic>? categories;
  List<dynamic>? tags;
  List<dynamic>? images;
  int? parent;
  String? up_sell;
  String? attribute_1_name;
  String? attribute_1_value;
  String? slug;

  ShProduct({
        this.id,
        this.sku,
        this.name,
        this.active,
        this.featured,
        this.short_description,
        this.description,
        this.sale_start_date,
        this.sale_end_date,
        this.in_stock,
        this.weight,
        this.dimensions,
        this.sale_price,
        this.price,
        this.categories,
        this.tags,
        this.images,
        this.parent,
        this.up_sell,
        this.attribute_1_name,
        this.attribute_1_value,
        this.slug,
  });

  ShProduct.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    sku = json['sku']??'';
    name = json['name']??'';
    active = json['active']??1;
    featured = json['featured']??false;
    short_description = json['short_description']??'';
    description = json['description']??'';
    sale_start_date = json['sale_start_date']??'';
    sale_end_date = json['sale_end_date']??'';
    in_stock = json['in_stock']??0;
    weight = json['weight']??[''];
    dimensions =  Dimensions(length: json['length']??'',width: json['width']??'',height: json['height']??'')  ;
    sale_price = json['sale_price']??0;
    price = json['price'];
    categories = json['category']??[''];
    tags = json['tag']??[''] ;
    images = json['image']??[''];
    parent = json['parent']??0;
    up_sell = json['up_sell']??'';
    attribute_1_name = json['attribute_1_name']??'';
    attribute_1_value = json['attribute_1_value']??'';
    slug = json['slug']??'';
  }


  static Map<String,List<ShProduct>> getSubCatProductsMap(Map<String,dynamic> jsonArray){

    Map<String,List<ShProduct>> map = {};
    jsonArray.forEach((key, value) {
      map[key]=ShProduct.getListFromJson(value);
    });

    return map;
  }

  static List<ShProduct> getListFromJson(List<dynamic> jsonArray) {
    List<ShProduct> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(ShProduct.fromJson(jsonArray[i]));
    }
    return list;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});
}

