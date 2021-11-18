import 'dart:convert';

import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/api/Network.dart';
import 'package:cotton_natural/shopHop/api/api_util.dart';
import 'package:cotton_natural/shopHop/models/ShAddress.dart';
import 'package:cotton_natural/shopHop/models/ShOrder.dart';
import 'package:cotton_natural/shopHop/models/ShPaymentCard.dart';
import 'package:cotton_natural/shopHop/utils/InternetUtils.dart';

import 'AuthController.dart';

class PaymentController {
  //--------------------- send Order Info To Make a Payment ---------------------------------------------//
  static Future<MyResponse> sendOrderInfo({
    required List<Item> items,
    required ShippingMethod shipping_method,
    required ShPaymentCard card,
    required ShAddressModel address,
    required double totalAmount,
  }) async {

    String token = await AuthController.getApiToken() ?? '';
    String url = ApiUtil.MAIN_API_URL + ApiUtil.SEND_ORDER_INFO;
    Map<String, String> headers = ApiUtil.getHeader(requestType: RequestType.PostWithAuth, token: token);

    List<Object> itemsJson = [];
    items.forEach((element) { itemsJson.add(element.toJson());});
    Map data = {
      'items':itemsJson,
      'shipping_method':shipping_method.toJson(),
      'address':address.toJson(),
      'card':card.toJson(),
      'totalAmount':totalAmount.toStringAsFixed(2),
    };
    print(data);
    Object body = jsonEncode(data);
    print(body);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {
      NetworkResponse response = await Network.post(url, headers: headers,body: body);
      MyResponse myResponse = MyResponse(response.statusCode);
      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body);
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    } catch (e) {
      print('error : ${e.toString()}');
      return MyResponse.makeServerProblemError();
    }
  }

}
