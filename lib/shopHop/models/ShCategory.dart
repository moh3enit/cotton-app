class ShCategory {
  int? id;
  String? name;
  String? slug;

  // ignore: non_constant_identifier_names
  ShCategory({ this.id, this.name,this.slug});

  ShCategory.fromJson(Map<String, dynamic> json) {
        id= json['id'];
        name= json['name'];
        slug= json['slug'];
  }

  static List<ShCategory> getCategoryList(List<dynamic> jsonArray){
    List<ShCategory> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(ShCategory.fromJson(jsonArray[i]));
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
