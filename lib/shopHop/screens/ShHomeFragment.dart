import 'package:cotton_natural/shopHop/api/MyResponse.dart';
import 'package:cotton_natural/shopHop/controllers/CategoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/main/utils/dots_indicator/dots_indicator.dart';
import 'package:cotton_natural/shopHop/models/ShCategory.dart';
import 'package:cotton_natural/shopHop/models/ShProduct.dart';
import 'package:cotton_natural/shopHop/screens/ShSubCategory.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShExtension.dart';

class ShHomeFragment extends StatefulWidget {
  static String tag = '/ShHomeFragment';

  @override
  ShHomeFragmentState createState() => ShHomeFragmentState();
}

class ShHomeFragmentState extends State<ShHomeFragment> {
  List<ShCategory> list = [];
  List<String> banners = [];
  List<ShProduct> newestProducts = [];
  List<ShProduct> featuredProducts = [];
  var position = 0;
  var colors = [sh_cat_1, sh_cat_2, sh_cat_3, sh_cat_4, sh_cat_5];

  //todo
  ShCategory menCategory = ShCategory(
    id: 45,
    name: 'Men',
    slug: 'men',
  );
  ShCategory womenCategory = ShCategory(
    id: 18,
    name: 'Women',
    slug: 'women',
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {


    MyResponse<List<ShCategory>> myResponse = await CategoryController.getMainCategories();

    if (myResponse.success) {
      list.clear();
      list = myResponse.data;
    } else {
      toasty(context, myResponse.errorText);
    }

    // loadCategory().then((categories) {
    //   setState(() {
    //     list.clear();
    //     list.addAll(categories);
    //   });
    // }).catchError((error) {
    //   toasty(context, error);
    // });
    List<ShProduct> products = await loadProducts();
    List<ShProduct> featured = [];
    products.forEach((product) {
      if (product.featured!) {
        featured.add(product);
      }
    });
    List<String> banner = [];
    for (var i = 1; i < 7; i++) {
      banner.add("images/shophop/img/products/banners/b" + i.toString() + ".jpg");
    }
    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      banners.clear();
      banners.addAll(banner);
      newestProducts.addAll(products);
      featuredProducts.addAll(featured);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Scaffold(
      body: newestProducts.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height * 0.55,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          PageView.builder(
                            itemCount: banners.length,
                            itemBuilder: (context, index) {
                              return Image.asset(banners[index], width: width, height: height * 0.55, fit: BoxFit.cover);
                            },
                            onPageChanged: (index) {
                              setState(() {
                                position = index;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DotsIndicator(
                              dotsCount: banners.length,
                              position: position,
                              decorator: DotsDecorator(
                                color: sh_view_color,
                                activeColor: sh_colorPrimary,
                                size: const Size.square(7.0),
                                activeSize: const Size.square(10.0),
                                spacing: EdgeInsets.all(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(top: spacing_standard_new),
                      alignment: Alignment.topLeft,
                      child: ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: spacing_standard, right: spacing_standard),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShSubCategory(category: list[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: spacing_standard, right: spacing_standard),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(spacing_middle),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
                                    child: Image.asset('images/shophop/cat/${list[index].slug}.png', width: 25, color: sh_white),
                                  ),
                                  SizedBox(height: spacing_control),
                                  text(list[index].name, textColor: Colors.black87, fontFamily: fontMedium)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 250,
                      margin: EdgeInsets.only(top: spacing_standard_new),
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: InkWell(
                        onTap: (){
                          ShSubCategory(category: womenCategory).launch(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.asset('images/shophop/for-her.jpg',fit: BoxFit.fitWidth,),
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      margin: EdgeInsets.only(top: spacing_standard_new),
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: InkWell(
                        onTap: (){
                          ShSubCategory(category: menCategory).launch(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.asset('images/shophop/for-him.jpg',fit: BoxFit.fitWidth,),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
