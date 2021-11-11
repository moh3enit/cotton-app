import 'dart:convert';
import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/api/Network.dart';
import 'package:cotton_natural/shopHop/api/api_util.dart';
import 'package:cotton_natural/shopHop/models/Account.dart';
import 'package:cotton_natural/shopHop/models/User.dart';
import 'package:cotton_natural/shopHop/utils/InternetUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddressController {

  //--------------------- Log In ---------------------------------------------//
  static Future<MyResponse> loginUser() async {

    String loginUrl = ApiUtil.MAIN_API_URL + ApiUtil.AUTH_LOGIN;
    Map<String, String> header = ApiUtil.getHeader(requestType: RequestType.Post);
    Map data = {};
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();

    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      NetworkResponse response = await Network.post(loginUrl, headers: header, body: body );
      MyResponse myResponse = MyResponse(response.statusCode);
      print('rrrrrrrr : ${response.statusCode}');
      print('bbbbbbbbbbbbbb : ${response.body}');
      if (response.statusCode == 200) {

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        myResponse.success = false;
        myResponse.setError(data);
      }
      return myResponse;
    }catch(e){
      print(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }


}
