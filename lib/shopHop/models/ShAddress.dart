class ShAddressModel {
  String company;
  String zip;
  String country;
  String city;
  String region;
  String phone;

  ShAddressModel({ required this.company, required this.zip, required this.region, required this.city, required this.phone, required this.country});

  factory ShAddressModel.fromJson(Map<String, dynamic> json) {
    return ShAddressModel(
      company: json['company']??'',
      zip: json['zip']??'',
      city: json['city']??'',
      region: json['region']??'',
      phone: json['phone']??'',
      country: json['country']??'',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['city'] = this.city;
    data['region'] = this.region;
    data['phone'] = this.phone;
    return data;
  }
}
