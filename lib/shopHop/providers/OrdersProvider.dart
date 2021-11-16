import 'package:cotton_natural/shopHop/models/ShOrder.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';
import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier{

  List<ShOrder> _orderList = [];
  double _totalPrice = 0.00 ;
  // String _shippingMethod='express';
  // late ShAddressModel _orderAddress ;

  List<ShOrder> getOrderList(){
    return _orderList;
  }

  bool isProductAlreadyAdded(int? productId){
    bool res = false;
    _orderList.forEach((element) {(element.item!.id == productId) ? res = true : res = false;});
    return res;
  }

  void increaseProductCount(int? productId) {
    _orderList.forEach((element) {
      if(element.item!.id == productId){
        element.item!.count = (element.item!.count!+1) ;
      }
    });

    notifyListeners();
  }

  void decreaseProductCount(int? productId) {
    _orderList.forEach((element) {
      if(element.item!.id == productId){
        element.item!.count = (element.item!.count!-1) ;
      }
    });
    _orderList.removeWhere((element) => (element.item!.count == 0));
    notifyListeners();
  }

  int? getItemQty(int? productId){
    int? itemCount=0;
    _orderList.forEach((element) {
      if(element.item!.id == productId){
        itemCount = element.item!.count ;
      }
    });
    return itemCount;
  }

  void addItemToBasket({required ShProduct? product , int count = 1}){

    if(this.isProductAlreadyAdded(product!.id)){
      increaseProductCount(product.id);
    }else{
      Item item = Item(
          id: product.id,
          image: product.images![0],
          name: product.name,
          price: product.price,
          count: count
      );
      ShOrder order = ShOrder(
          item: item ,
          order_date: 'order_date' ,
          order_number: 'order_number',
          order_status: 'order_status'
      );
      _orderList.add(order);
    }


    notifyListeners();
  }

  void removeItemFromBasket({required int? productId }){
    _orderList.removeWhere((element) => element.item!.id==productId);

    notifyListeners();
  }

  String? getTotalPrice(){
    _totalPrice = 0.00;
    _orderList.forEach((element) {
      _totalPrice = _totalPrice + double.parse(element.item!.price??'0') * element.item!.count!;
    });

    return _totalPrice.toStringAsFixed(2).toCurrencyFormat();
  }

  int getOrderCount(){
    return _orderList.length;
  }




}