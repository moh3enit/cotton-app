import 'package:cotton_natural/main/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';

import 'ShProductDetail.dart';

class ShOffersScreen extends StatefulWidget {
  static String tag = '/ShOffersScreen';

  @override
  ShOffersScreenState createState() => ShOffersScreenState();
}

class ShOffersScreenState extends State<ShOffersScreen> {
  List<ShProduct> mProductModel = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    // var products = await loadProducts();
    List<ShProduct> offers = [];
    // products.forEach((product) {
      // if (product.on_sale!) {
      //   offers.add(product);
      // }
    // });
    setState(() {
      mProductModel.clear();
      mProductModel.addAll(offers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gridView = Container(
      child: GridView.builder(
          itemCount: mProductModel.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(spacing_middle),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 13, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_standard_new),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                ShProductDetail(product: mProductModel[index]).launch(context);
              },
              child: Container(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 9 / 11,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                            child: networkCachedImage(
                              mProductModel[index].images![0],
                              fit: BoxFit.cover,
                              aWidth: double.infinity,
                              aHeight: double.infinity,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spacing_control),
                            margin: EdgeInsets.all(spacing_standard),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: sh_white),
                            child: Icon(
                              Icons.favorite_border,
                              color: sh_textColorPrimary,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        text( mProductModel[index].price.toString().toCurrencyFormat(),
                            textColor: sh_colorPrimary, fontFamily: fontMedium, fontSize: textSizeNormal),
                        SizedBox(
                          width: spacing_control,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_white,
        title: text(sh_lbl_my_offers, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: sh_textColorPrimary),
        actionsIconTheme: IconThemeData(color: sh_colorPrimary),
        actions: <Widget>[cartIcon(context, 3)],
      ),
      body: gridView,
    );
  }
}
