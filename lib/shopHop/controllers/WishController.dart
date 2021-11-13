import 'dart:convert';

import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/api/Network.dart';
import 'package:cotton_natural/shopHop/api/api_util.dart';
import 'package:cotton_natural/shopHop/controllers/AuthController.dart';
import 'package:cotton_natural/shopHop/utils/InternetUtils.dart';

class WishController{

  //--------------------- toggle wish ---------------------------------------------//
  static Future<MyResponse> toggleWish(int? productId) async {

    String url = ApiUtil.MAIN_API_URL + ApiUtil.TOGGLE_WISH + productId.toString();
    Map<String, String> headers = ApiUtil.getHeader(requestType: RequestType.PostWithAuth);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {

      NetworkResponse response = await Network.post(url, headers: headers);
      MyResponse myResponse = MyResponse(response.statusCode);

      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body);
          print('data : ${myResponse.data}');
      } else {
        myResponse.success = false;
        myResponse.setError(json.decode(response.body));
      }
      return myResponse;
    }catch(e){
      //If any server error...
      print('errrrrrr: ${e.toString()}');
      return MyResponse.makeServerProblemError();
    }
  }

  //--------------------- init Is Wished  ---------------------------------------------//
  static Future<MyResponse> initIsWished(int? productId) async {

    String url = ApiUtil.MAIN_API_URL + ApiUtil.INIT_IS_WISHED + productId.toString();
    String token = await AuthController.getApiToken() ?? '';
    Map<String, String> headers = ApiUtil.getHeader(requestType: RequestType.GetWithAuth,token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {

      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse myResponse = MyResponse(response.statusCode);

      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body);
          print('data : ${myResponse.data}');
      } else {
        myResponse.success = false;
        myResponse.setError(json.decode(response.body));
      }
      return myResponse;
    }catch(e){
      //If any server error...
      print('errrrrrr: ${e.toString()}');
      return MyResponse.makeServerProblemError();
    }
  }

}