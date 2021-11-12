import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/shopHop/models/ShPaymentCard.dart';
import 'package:cotton_natural/shopHop/screens/ShAddCardScreen.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShImages.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';
import 'package:cotton_natural/shopHop/utils/widgets/ShSliderWidget.dart';

class ShPaymentsScreen extends StatefulWidget {
  static String tag = '/ShPaymentsScreen';

  @override
  ShPaymentsScreenState createState() => ShPaymentsScreenState();
}

class ShPaymentsScreenState extends State<ShPaymentsScreen> {
  List<ShPaymentCard> mPaymentCards = [];

  @override
  void initState() {
    super.initState();
    mPaymentCards.add(ShPaymentCard());
    mPaymentCards.add(ShPaymentCard());
    mPaymentCards.add(ShPaymentCard());
    mPaymentCards.add(ShPaymentCard());
    mPaymentCards.add(ShPaymentCard());
    mPaymentCards.add(ShPaymentCard());
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
                    text('?', textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Row(
                  children: <Widget>[
                    text(sh_lbl_total_amount),
                    text("\$70.00", textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
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
                children: <Widget>[
                  divider(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
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
                  divider(),
                  paymentDetail
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

