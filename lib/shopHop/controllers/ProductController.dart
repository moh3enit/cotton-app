import 'dart:convert';

import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/api/Network.dart';
import 'package:cotton_natural/shopHop/api/api_util.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/utils/InternetUtils.dart';

class ProductController{

  //--------------------- Get Sub Cats ---------------------------------------------//
  static Future<MyResponse<Map<String,List<ShProduct>>>> getSubCatProduct(String? categorySlug,String subCatSlug,int limit) async {

    String url = ApiUtil.MAIN_API_URL + ApiUtil.SUB_CATEGORY_PRODUCTS + categorySlug! + '/' + subCatSlug + '/' + limit.toString();
    Map<String, String> headers = ApiUtil.getHeader(requestType: RequestType.Get);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {

      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse<Map<String,List<ShProduct>>> myResponse = MyResponse(response.statusCode);

      if (ApiUtil.isResponseSuccess(response.statusCode)) {
        myResponse.success = true;
        myResponse.data = ShProduct.getSubCatProductsMap(json.decode(response.body));
        myResponse.data.forEach((key, value) {
          print('key : $key');
        });
      } else {
        myResponse.success = false;
        myResponse.setError(json.decode(response.body));
      }
      return myResponse;
    }catch(e){
      //If any server error...
      print('errrrrrr: ${e.toString()}');
      return MyResponse.makeServerProblemError<Map<String,List<ShProduct>>>();
    }
  }

}