
import 'package:cotton_natural/main/utils/common.dart';
import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/controllers/OrderController.dart';
import 'package:cotton_natural/shopHop/models/Order.dart';
import 'package:cotton_natural/shopHop/models/ShOrder.dart';
import 'package:cotton_natural/shopHop/providers/OrdersProvider.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cotton_natural/shopHop/models/ShAddress.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/screens/ShAdressManagerScreen.dart';
import 'package:cotton_natural/shopHop/screens/ShPaymentsScreen.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ShOrderSummaryScreen extends StatefulWidget {
  static String tag = '/ShOrderSummaryScreen';

  @override
  ShOrderSummaryScreenState createState() => ShOrderSummaryScreenState();
}

class ShOrderSummaryScreenState extends State<ShOrderSummaryScreen> {
  List<Item?> list = [];
  // List<ShAddressModel> addressList = [];
  var selectedPosition = 0;
  List<String> images = [];
  var currentIndex = 0;
  var isLoaded = false;
  List<ShOrder> orderList=[];
  // late List<Order> previousOrders;

  //address form vars
  var primaryColor;
  var zipCont = TextEditingController();
  var phoneCont = TextEditingController();
  var cityCont = TextEditingController();
  var regionCont = TextEditingController();
  var countryCont = TextEditingController();
  var companyCont = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchData();

    init();
  }

  init() async {
    ShAddressModel providerAddress = Provider.of<OrdersProvider>(context,listen: false).getAddress();
      companyCont.text = providerAddress.company;
      phoneCont.text = providerAddress.phone;
      cityCont.text = providerAddress.city;
      regionCont.text = providerAddress.region;
      countryCont.text = providerAddress.country;
      zipCont.text = providerAddress.zip;
  }

  fetchData() async {
    orderList = Provider.of<OrdersProvider>(context,listen: false).getOrderList();

    list.clear();
    orderList.forEach((element) {list.add(element.item);});
    setState(() { });

    // MyResponse<List<Order>> myResponse = await OrderController.getOrderList();
    // if(myResponse.success){
    //   previousOrders = myResponse.data;
    //   addressList.clear();
    //   addressList = Provider.of<OrdersProvider>(context,listen: false).getAddressListFromPreviousOrders(previousOrders)!;
    // }
    // var addresses = await loadAddresses();
    setState(() {
      // addressList.clear();
      // addressList.addAll(addresses);
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;



    //adding address form

    final company = TextFormField(
      controller: companyCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration('Company'),
    );

    final phoneNumber = TextFormField(
      controller: phoneCont,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      maxLength: 10,
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration(sh_hint_contact),
    );

    final city = TextFormField(
      controller: cityCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration(sh_hint_city),
    );

    final region = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: regionCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration('Region'),
    );

    final country = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: countryCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration("Country"),
    );

    final zip = TextFormField(
      controller: zipCont,
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Zip Code'),
    );

    final body = Wrap(runSpacing: spacing_standard_new, children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: company),
        ],
      ),
      phoneNumber,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: city),
          SizedBox(
            width: spacing_standard_new,
          ),
          Expanded(child: region),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(child: country),
          SizedBox(
            width: spacing_standard_new,
          ),
          Expanded(child: zip),
        ],
      ),
    ]);




    var cartList = isLoaded
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: spacing_standard_new),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                color: sh_itemText_background,
                margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      networkCachedImage(
                        list[index]!.image!,
                        aWidth: width * 0.25,
                        aHeight: width * 0.3,
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: spacing_standard,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: text(list[index]!.name, textColor: sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: spacing_control),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                          padding: EdgeInsets.all(spacing_control_half),
                                          child: Icon(
                                            Icons.done,
                                            color: sh_white,
                                            size: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: spacing_standard,
                                        ),
                                        text(ShProduct.getSizeTypeText(list[index]!.size!), textColor: sh_textColorPrimary, fontSize: textSizeMedium),
                                        SizedBox(
                                          width: spacing_standard,
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(spacing_standard, 1, spacing_standard, 1),
                                          decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              text("Qty: ${Provider.of<OrdersProvider>(context, listen: true).getItemQty(list[index]!.id,list[index]!.size)}", textColor: sh_textColorPrimary, fontSize: textSizeSMedium),
                                              // Icon(
                                              //   Icons.arrow_drop_down,
                                              //   color: sh_textColorPrimary,
                                              //   size: 16,
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        text( list[index]!.price.toString().toCurrencyFormat(),
                                            textColor: sh_colorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              // return Chats(mListings[index], index);
            })
        : Container();
    var paymentDetail = Container(
      margin: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard_new, spacing_standard_new, spacing_standard_new),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: text(sh_lbl_payment_details, textColor: sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
          ),
          Divider(
            height: 1,
            color: sh_view_color,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text(sh_lbl_shipping_charge),
                    text(Provider.of<OrdersProvider>(context, listen: false).getShippingMethod().price.toCurrencyFormat(), textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text(sh_lbl_total_amount),
                    text(Provider.of<OrdersProvider>(context,listen: true).getTotalPrice(), textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    var address = isLoaded
    ?Container(
      width: double.infinity,
      color: sh_item_background,
      padding: EdgeInsets.all(spacing_standard_new),
      margin: EdgeInsets.all(spacing_standard_new),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: SingleChildScrollView(child: body),
            margin: EdgeInsets.all(16),
          ),

          // text(addressList[selectedPosition].company , textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
          // text(addressList[selectedPosition].phone, textColor: sh_textColorPrimary, fontSize: textSizeMedium),
          // text(addressList[selectedPosition].city + "," + addressList[selectedPosition].region, textColor: sh_textColorPrimary, fontSize: textSizeMedium),
          // text(addressList[selectedPosition].country + "," + addressList[selectedPosition].zip, textColor: sh_textColorPrimary, fontSize: textSizeMedium),
          // SizedBox(
          //   height: spacing_standard_new,
          // ),
          // text('', textColor: sh_textColorPrimary, fontSize: textSizeMedium),
          // SizedBox(
          //   height: spacing_standard_new,
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: MaterialButton(
          //     padding: EdgeInsets.all(spacing_standard),
          //     child: text(sh_lbl_change_address, fontSize: textSizeMedium, fontFamily: fontMedium, textColor: sh_white),
          //     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0), side: BorderSide(color: sh_colorPrimary, width: 1)),
          //     color: sh_colorPrimary,
          //     onPressed: () async {
          //       var pos = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShAddressManagerScreen())) ?? selectedPosition;
          //       setState(() {
          //         selectedPosition = pos;
          //       });
          //     },
          //   ),
          // )
        ],
      ),
    )
    :Container();
    var bottomButtons = Container(
      height: 60,
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: sh_shadow_color, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3))], color: sh_white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                text(Provider.of<OrdersProvider>(context,listen: true).getTotalPrice(), textColor: sh_textColorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                text('Order Total'),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                child: text(sh_lbl_continue, textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
                color: sh_colorPrimary,
                alignment: Alignment.center,
                height: double.infinity,
              ),
              onTap: () {
                if(validateAddress()){
                  ShAddressModel newAddress = ShAddressModel(
                      company: companyCont.text,
                      zip: zipCont.text,
                      region: regionCont.text,
                      city: cityCont.text,
                      phone: phoneCont.text,
                      country: countryCont.text,
                  );
                  Provider.of<OrdersProvider>(context,listen: false).setAddress(newAddress);
                  ShPaymentsScreen().launch(context);
                }
              },
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_white,
        title: text(sh_order_summary, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: sh_textColorPrimary),
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Column(
                children: <Widget>[
                  isLoaded ? address : Container(),
                  cartList,
                  paymentDetail,
                  images.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                          margin: const EdgeInsets.all(spacing_standard_new),
                          child: Image.asset(
                            images[currentIndex],
                            width: double.infinity,
                            height: width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Container(
            color: sh_white,
            child: bottomButtons,
          )
        ],
      ),
    );
  }

  bool validateAddress() {
    if(companyCont.text.trim()==''){
      toasty(context, 'Company name is require');
      return false;
    }else if(phoneCont.text.trim()==''){
      toasty(context, 'Phone number is require');
      return false;
    }else if(cityCont.text.trim()==''){
      toasty(context, 'City name is require');
      return false;
    }else if(regionCont.text.trim()==''){
      toasty(context, 'Region name is require');
      return false;
    }else if(countryCont.text.trim()==''){
      toasty(context, 'Country name is require');
      return false;
    }else if(zipCont.text.trim()==''){
      toasty(context, 'Zip Code is require');
      return false;
    }
    return true;
  }



}
