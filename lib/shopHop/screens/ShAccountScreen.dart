import 'package:cotton_natural/shopHop/controllers/AuthController.dart';
import 'package:cotton_natural/shopHop/models/Account.dart';
import 'package:cotton_natural/shopHop/screens/ShSignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';
import 'package:cotton_natural/shopHop/screens/ShAdressManagerScreen.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';

import 'ShOrderListScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class ShAccountScreen extends StatefulWidget {
  static String tag = '/ShAccountScreen';

  @override
  ShAccountScreenState createState() => ShAccountScreenState();
}

class ShAccountScreenState extends State<ShAccountScreen> {

  late Account userAccount ;
  late bool isInProgress;

  @override
  void initState() {
    super.initState();
    isInProgress = false;
    _getUserAccount();
  }

  _getUserAccount()async{

      if(mounted) {
        setState(() {
          isInProgress = true;
        });
      }

      userAccount =  await AuthController.getAccount();

      if(mounted) {
        setState(() {
          isInProgress = false;
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_white,
        title: text(sh_lbl_account, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            text("${userAccount.name??''}", textColor: sh_textColorPrimary, fontFamily: fontBold, fontSize: textSizeLarge),
            SizedBox(
              height: 30,
            ),
            text("${userAccount.email??''}", textColor: sh_textColorPrimary, fontFamily: fontBold, fontSize: textSizeLarge),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: spacing_standard_new, bottom: spacing_standard_new, right: spacing_standard_new),
              child: Column(
                children: <Widget>[
                  getRowItem(sh_lbl_address_manager, callback: () {
                    ShAddressManagerScreen().launch(context);
                  }),
                  SizedBox(height: spacing_standard_new),
                  getRowItem(sh_lbl_my_order, callback: () {
                    ShOrderListScreen().launch(context);
                  }),
                  SizedBox(height: spacing_standard_new),
                  getRowItem(sh_lbl_wish_list, callback: () {
                    Navigator.of(context).pop(true);
                  }),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    // height: double.infinity,
                    child: MaterialButton(
                      padding: EdgeInsets.all(spacing_standard),
                      child: text("Sign Out", fontSize: textSizeNormal, fontFamily: fontMedium, textColor: sh_colorPrimary),
                      textColor: sh_white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0), side: BorderSide(color: sh_colorPrimary, width: 1)),
                      color: sh_white,
                      onPressed: () async {
                        await AuthController.logoutUser();
                        ShSignIn().launch(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRowItem(String title, {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
        padding: EdgeInsets.fromLTRB(spacing_standard, 0, spacing_control_half, 0),
        child: Row(
          children: <Widget>[
            Expanded(child: text(title, textColor: sh_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontMedium)),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: sh_textColorPrimary,
                size: 24,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
