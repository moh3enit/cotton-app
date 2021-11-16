import 'dart:convert';

import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/api/Network.dart';
import 'package:cotton_natural/shopHop/api/api_util.dart';
import 'package:cotton_natural/shopHop/models/Order.dart';
import 'package:cotton_natural/shopHop/models/ShOrder.dart';
import 'package:cotton_natural/shopHop/utils/InternetUtils.dart';

import 'AuthController.dart';

class OrderController {
  //--------------------- get Order List ---------------------------------------------//
  static Future<MyResponse<List<Order>>> getOrderList() async {
    String token = await AuthController.getApiToken() ?? '';
    String url = ApiUtil.MAIN_API_URL + ApiUtil.ORDER;
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse<List<Order>> myResponse = MyResponse(response.statusCode);
      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        print(json.decode(response.body));
        myResponse.data = Order.getListFromJson(json.decode(response.body));
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    } catch (e) {
      return MyResponse.makeServerProblemError<List<Order>>();
    }
  }

  //------------------------ Get single order -----------------------------------------//
  static Future<MyResponse<Order>> getSingleOrder(int? id) async {
    //Getting User Api Token
    String token = await AuthController.getApiToken() ?? '';
    String url = ApiUtil.MAIN_API_URL + ApiUtil.ORDER_DETAIL + id!.toString();
    Map<String, String> headers =
    ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse<Order> myResponse = MyResponse(response.statusCode);
      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        myResponse.data = Order.fromJson(json.decode(response.body));
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError();
    }
  }
}
