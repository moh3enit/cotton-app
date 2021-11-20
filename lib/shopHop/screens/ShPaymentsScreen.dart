import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/controllers/PaymentController.dart';
import 'package:cotton_natural/shopHop/models/ShAddress.dart';
import 'package:cotton_natural/shopHop/models/ShOrder.dart';
import 'package:cotton_natural/shopHop/models/ShPaymentCard.dart';
import 'package:cotton_natural/shopHop/providers/OrdersProvider.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/shopHop/screens/ShAddCardScreen.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';
import 'package:provider/provider.dart';

class ShPaymentsScreen extends StatefulWidget {
  static String tag = '/ShPaymentsScreen';

  @override
  ShPaymentsScreenState createState() => ShPaymentsScreenState();
}

class ShPaymentsScreenState extends State<ShPaymentsScreen> {
  // List<ShPaymentCard> mPaymentCards = [];
  late ShAddressModel address ;

  @override
  void initState() {
    super.initState();
    address =Provider.of<OrdersProvider>(context,listen: false).getAddress();
  }

  @override
  Widget build(BuildContext context) {
    var paymentDetail = Container(
      margin: EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
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
                    text(Provider.of<OrdersProvider>(context, listen: false).getShippingMethod().price!.toCurrencyFormat(), textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text(sh_lbl_total_amount),
                    text(Provider.of<OrdersProvider>(context, listen: false).getTotalPrice(), textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    var addressDetail = Container(
      margin: EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: text('Address Detail', textColor: sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
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
                    text('Country: '),
                    text('${address.country} ', textColor:sh_colorPrimary, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text('Region: '),
                    text(' ${address.region} ', textColor:sh_colorPrimary, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text('City: '),
                    text('${address.city} ', textColor:sh_colorPrimary, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text('Company Name: '),
                    text('${address.company}  ', textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text(' Zip Code: '),
                    text('${address.zip}  ', textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text('Phone Number: '),
                    text('${address.phone}  ', textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_white,
        title: text(sh_title_payment, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontBold),
        iconTheme: IconThemeData(color: sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text(sh_lbl_quick_pay, textColor: sh_textColorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  divider(),
                  showCardInfo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        textColor: sh_colorPrimary,
                        padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: 0, bottom: 0),
                        child: text((Provider.of<OrdersProvider>(context,listen: true).getCard().cardNo == '')?sh_lbl_add_card:'Edit Card', fontSize: textSizeSMedium, textColor: sh_colorPrimary),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(spacing_large),
                          side: BorderSide(color: sh_colorPrimary),
                        ),
                        onPressed: () {
                          ShAddCardScreen().launch(context);
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async{
                      if(Provider.of<OrdersProvider>(context,listen: false).getCard().cardNo != ''){
                        await sendOrderInfo();
                      }else{
                        toasty(context, 'Please add a card');
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: spacing_standard_new,),
                      padding: const EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new,left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.credit_card,
                            color: sh_textColorPrimary,
                          ),
                          SizedBox(
                            width: spacing_standard_new,
                          ),
                          text(sh_lbl_pay_with_debit_credit_card, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
                        ],
                      ),
                    ),
                  ),
                  divider(),
                  paymentDetail,
                  addressDetail,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showCardInfo() {
    if(Provider.of<OrdersProvider>(context,listen: true).getCard().cardNo != ''){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('Holder Name : ' + Provider.of<OrdersProvider>(context,listen: true).getCard().holderName, fontSize: textSizeMedium, textColor: sh_textColorPrimary),
            text('Card Number : ' + Provider.of<OrdersProvider>(context,listen: true).getCard().cardNo, fontSize: textSizeMedium, textColor: sh_textColorPrimary),
            text('CVV : ' + Provider.of<OrdersProvider>(context,listen: true).getCard().cvv, fontSize: textSizeMedium, textColor: sh_textColorPrimary),
            text('Exp Date : ' + Provider.of<OrdersProvider>(context,listen: true).getCard().year + ' / ' + Provider.of<OrdersProvider>(context,listen: true).getCard().month, fontSize: textSizeMedium, textColor: sh_textColorPrimary),
          ],
        ),
      );
    }else{
      return Container(
        child: text('Please Add A Card', fontSize: textSizeMedium, textColor: sh_textColorPrimary),
      );
    }
  }

  sendOrderInfo() async{
    setState(() { });
    List<Item> items = [];
    ShippingMethod shipping_method = Provider.of<OrdersProvider>(context,listen: false).getShippingMethod();
    double totalAmount = Provider.of<OrdersProvider>(context,listen: false).getTotalPriceSimple();
    List<ShOrder> orderList =  Provider.of<OrdersProvider>(context,listen: false).getOrderList();
    ShPaymentCard card = Provider.of<OrdersProvider>(context,listen: false).getCard();
    orderList.forEach((element) {
      items.add(element.item??Item(price: '0',name: '',id: 0,size: '',count: 0,slug: '',image: ''));
    });

    MyResponse myResponse = await PaymentController.sendOrderInfo(items: items, shipping_method: shipping_method, card: card, address: address, totalAmount: totalAmount);

    if (myResponse.success) {
      toasty(context, myResponse.data[0].toString());
    } else {
      toasty(context, myResponse.errorText);
    }

    setState(() {

    });
  }
}

