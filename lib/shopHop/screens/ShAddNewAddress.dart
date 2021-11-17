import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cotton_natural/shopHop/models/ShAddress.dart';
import 'package:cotton_natural/shopHop/utils/ShColors.dart';
import 'package:cotton_natural/shopHop/utils/ShConstant.dart';
import 'package:cotton_natural/shopHop/utils/ShStrings.dart';
import 'package:cotton_natural/shopHop/utils/ShWidget.dart';
import 'package:cotton_natural/main/utils/AppWidget.dart';

// ignore: must_be_immutable
class ShAddNewAddress extends StatefulWidget {
  static String tag = '/AddNewAddress';
  ShAddressModel? addressModel;

  ShAddNewAddress({this.addressModel});

  @override
  ShAddNewAddressState createState() => ShAddNewAddressState();
}

class ShAddNewAddressState extends State<ShAddNewAddress> {
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
    init();
  }

  init() async {
    if (widget.addressModel != null) {
      zipCont.text = widget.addressModel!.zip;
      phoneCont.text = widget.addressModel!.phone;
      cityCont.text = widget.addressModel!.city;
      regionCont.text = widget.addressModel!.region;
      countryCont.text = widget.addressModel!.country;
      companyCont.text = widget.addressModel!.company;
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSaveClicked() async {
      Navigator.pop(context, true);
    }
   // TODO Without NullSafety Geo coder
/*    getLocation() async {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        var coordinates = Coordinates(position.latitude, position.longitude);
        Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses) {
          var first = addresses.first;
          print("${addresses} : ${first.addressLine}");
          setState(() {
            pinCodeCont.text = first.postalCode;
            addressCont.text = first.addressLine;
            cityCont.text = first.locality;
            stateCont.text = first.adminArea;
            countryCont.text = first.countryName;
          });
        }).catchError((error) {
          print(error);
        });
      }).catchError((error) {
        print(error);
      });
    }*/

    final useCurrentLocation = Container(
      alignment: Alignment.center,
      child: MaterialButton(
        color: sh_light_gray,
        elevation: 0,
        padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle),
        onPressed: () => {
          // TODO Without NullSafety Geo coder
          //getLocation()
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.my_location,
              color: primaryColor,
              size: 16,
            ),
            SizedBox(width: 10),
            text('Use Current Location', textColor: sh_textColorPrimary, fontFamily: fontMedium)
          ],
        ),
      ),
    );

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

    final phoneNumber = TextFormField(
      controller: phoneCont,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      maxLength: 10,
      autofocus: false,
      decoration: formFieldDecoration(sh_hint_contact),
    );

    final saveButton = MaterialButton(
      height: 50,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
      onPressed: () {
        if (companyCont.text.isEmpty) {
          toasty(context, "Company name required");
        } else if (phoneCont.text.isEmpty) {
          toasty(context, "Phone Number required");
        } else if (cityCont.text.isEmpty) {
          toasty(context, "City name required");
        } else if (regionCont.text.isEmpty) {
          toasty(context, "Region name required");
        } else if (countryCont.text.isEmpty) {
          toasty(context, "Country name required");
        } else if (zipCont.text.isEmpty) {
          toasty(context, "Zip code required");
        } else {
          onSaveClicked();
        }
      },
      color: sh_colorPrimary,
      child: text(sh_lbl_save_address, fontFamily: fontMedium, fontSize: textSizeLargeMedium, textColor: sh_white),
    );

    final body = Wrap(runSpacing: spacing_standard_new, children: <Widget>[
      useCurrentLocation,
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
      Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: saveButton,
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_white,
        title: text(widget.addressModel == null ? sh_lbl_add_new_address : sh_lbl_edit_address, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: sh_textColorPrimary),
        actionsIconTheme: IconThemeData(color: sh_colorPrimary),
        actions: <Widget>[cartIcon(context, 3)],
      ),
      body: Container(width: double.infinity, child: SingleChildScrollView(child: body), margin: EdgeInsets.all(16)),
    );
  }
}
