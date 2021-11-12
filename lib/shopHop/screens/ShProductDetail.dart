import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/models/ShReview.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';

// ignore: must_be_immutable
class ShProductDetail extends StatefulWidget {
  static String tag = '/ShProductDetail';
  ShProduct? product;

  ShProductDetail({this.product});

  @override
  ShProductDetailState createState() => ShProductDetailState();
}

class ShProductDetailState extends State<ShProductDetail> {
  var position = 0;
  bool isExpanded = false;
  var selectedColor = -1;
  var selectedSize = -1;
  List<ShReview> list = [];
  bool autoValidate = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();
    setState(() {
      list.clear();
      list.addAll(products);
    });
  }

  Future<List<ShReview>> loadProducts() async {
    String jsonString = await loadContentAsset('assets/shophop_data/reviews.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => ShReview.fromJson(i)).toList();
  }

  @override
  void dispose() {
    changeStatusColor(Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);

    var width = MediaQuery.of(context).size.width;

    var sliderImages = Container(
      // height: 380,
      constraints: BoxConstraints(
        minHeight: 380,
        maxHeight: 560,
      ),
      child: PageView.builder(
        itemCount: widget.product!.images!.length,
        itemBuilder: (context, index) {
          return Image.asset("images/shophop/img/products" + widget.product!.images![index].src!, width: width, height: width * 1.05, fit: BoxFit.cover);
        },
        onPageChanged: (index) {
          position = index;
          setState(() {});
        },
      ),
    );

    var productInfo = Padding(
      padding: EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text(widget.product!.name, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeXNormal),
              text(
                widget.product!.on_sale! ? widget.product!.sale_price.toCurrencyFormat() : widget.product!.price.toCurrencyFormat(),
                textColor: sh_colorPrimary,
                fontSize: textSizeXNormal,
                fontFamily: fontMedium,
              )
            ],
          ),
          SizedBox(height: spacing_standard),
        ],
      ),
    );

    var colorList = [];
    widget.product!.attributes!.forEach((element) {
      if (element.name == 'Color') colorList.addAll(element.options!);
    });

    var colors = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colorList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            selectedColor = index;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.only(right: spacing_xlarge),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: sh_textColorPrimary, width: 0.5), color: getColorFromHex(colorList[index])),
            child: selectedColor == index ? Icon(Icons.done, color: sh_white, size: 12) : Container(),
          ),
        );
      },
    );

    var sizeList = [];
    widget.product!.attributes!.forEach((element) {
      if (element.name == 'Size') sizeList.addAll(element.options!);
    });

    var brandList = [];
    widget.product!.attributes!.forEach((element) {
      if (element.name == 'Brand') brandList.addAll(element.options!);
    });

    var bands = "";
    brandList.forEach((brand) {
      bands = bands + brand.toString() + ", ";
    });

    var sizes = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: sizeList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            selectedSize = index;
            setState(() {});
          },
          child: Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(right: spacing_xlarge),
            decoration: selectedSize == index ? BoxDecoration(shape: BoxShape.circle, border: Border.all(color: sh_textColorPrimary, width: 0.5), color: sh_colorPrimary) : BoxDecoration(),
            child: Center(child: text(sizeList[index], textColor: selectedSize == index ? sh_white : sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium)),
          ),
        );
      },
    );


    var descriptionTab = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(spacing_standard_new),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                text(widget.product!.description, maxLine: 3, isLongText: isExpanded, fontSize: 16.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(spacing_control_half),
                    color: sh_white,
                    child: text(isExpanded ? "Read Less" : "Read More", textColor: sh_textColorPrimary, fontSize: textSizeMedium),
                  ),
                  onTap: () {
                    isExpanded = !isExpanded;
                    setState(() {});
                  },
                )
              ],
            ),
            SizedBox(height: spacing_standard_new),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(border: Border.all(color: sh_view_color)),
                    padding: EdgeInsets.only(left: spacing_middle, right: spacing_middle),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: textSizeMedium, color: sh_textColorPrimary),
                            decoration: InputDecoration(border: InputBorder.none, hintText: "Pincode"),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 25,
                          color: sh_view_color,
                          margin: EdgeInsets.only(left: spacing_middle, right: spacing_middle),
                        ),
                        text("Check Availability", textColor: sh_textColorPrimary, fontSize: textSizeSmall)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: spacing_standard_new,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[text(sh_lbl_delivered_by, fontSize: textSizeSMedium), text("25 June, Monday", textColor: sh_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontMedium)],
                )
              ],
            ),
            SizedBox(height: spacing_standard_new),
            text(sh_lbl_colors, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
            Container(height: 50, child: colors),
            sizeList.isNotEmpty ? text(sh_lbl_size, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium) : SizedBox(),
            Container(height: 50, child: sizes)
          ],
        ),
      ),
    );
    var bottomButtons = Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7), blurRadius: 16, spreadRadius: 2, offset: Offset(3, 1))], color: sh_white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: text(sh_lbl_add_to_cart, textColor: sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
              color: sh_white,
              alignment: Alignment.center,
              height: double.infinity,
            ),
          ),
          Expanded(
            child: Container(
              child: text(sh_lbl_buy_now, textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
              color: sh_colorPrimary,
              alignment: Alignment.center,
              height: double.infinity,
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          DefaultTabController(
            length: 1,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                changeStatusColor(innerBoxIsScrolled ? Colors.white : Colors.transparent);
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 630,
                    floating: false,
                    pinned: true,
                    titleSpacing: 0,
                    backgroundColor: sh_white,
                    iconTheme: IconThemeData(color: sh_textColorPrimary),
                    actionsIconTheme: IconThemeData(color: sh_textColorPrimary),
                    actions: <Widget>[
                      Container(
                        padding: EdgeInsets.all(spacing_standard),
                        margin: EdgeInsets.only(right: spacing_standard_new),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
                        child: Icon(Icons.favorite_border, color: sh_textColorPrimary, size: 18),
                      ),
                      cartIcon(context, 1)
                    ],
                    title: text(innerBoxIsScrolled ? widget.product!.name : "", textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: <Widget>[
                          sliderImages,
                          productInfo,
                        ],
                      ),
                      collapseMode: CollapseMode.pin,
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: sh_colorPrimary,
                        indicatorColor: sh_colorPrimary,
                        unselectedLabelColor: sh_textColorPrimary,
                        tabs: [
                          Tab(text: sh_lbl_description)
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  descriptionTab,
                ],
              ),
            ),
          ),
          bottomButtons
        ],
      ),
    );
  }

}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      color: sh_white,
      child: Container(child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}