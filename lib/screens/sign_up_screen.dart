import 'dart:convert';
import 'dart:io';
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/dialog/error_dialog.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/dialog/success_dialog.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignUpSreen extends StatefulWidget {
  String callbackType;

  SignUpSreen(this.callbackType);

  SignUpState createState() => SignUpState(callbackType);
}

class SignUpState extends State<SignUpSreen> {
  File _image;
  final picker = ImagePicker();
  String callbackType;

  SignUpState(this.callbackType);

  String userId = '', imageAsBase64 = '';
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String dropdownValue = 'Select User Type';
  List<String> countryList = [];
  List<dynamic> countryData = [];
  List<dynamic> list = [];
  String imageDocument = 'Image';

  List<dynamic> countryCodeData = [];
  List<dynamic> searchCountryCodeData = [];
  List<String> countryCodeList = [];
  String phoneNumber = '+91';
  String whatsAppNumber = '+91';
  String telephoneNumber = '+91';
  String weNumber = '+91';
  String dropdownValueCountry = 'Select Country';
  var textControllerUserName = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  var textControllerConfirmPassword = new TextEditingController();
  var textControllerCompanyName = new TextEditingController();
  var textControllerProducts = new TextEditingController();
  var textControllerAddress = new TextEditingController();
  var textControllerZipCode = new TextEditingController();
  var textControllerState = new TextEditingController();
  var textControllerCity = new TextEditingController();
  var textControllerContact = new TextEditingController();
  var textControllerphone = new TextEditingController();
  var textControllerWhatsapp = new TextEditingController();
  var textControllerTelephone = new TextEditingController();
  var textControllerWeChat = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool notificationSwitch = false;
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 55,
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'USER \n REGISTRATION',
                      style: TextStyle(
                          fontSize: 30,
                          color: MyColor.greyTextColor,
                          fontFamily: 'GilroySemibold'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, left: 56),
                  child: Text(
                    'User Name (Email) *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            //  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerUserName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: ' Enter Email',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Password *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerPassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Confirm Password *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerConfirmPassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //spinner data
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'User Type *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: MyColor.boxBorder, width: 1),
                      color: Colors.white,
                    ),

                    // dropdown below..
                    child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'Select User Type',
                          'Agent',
                          'Trader',
                          'Manufacturer',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
//spinner

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Company Name *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerCompanyName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Company Name',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Address',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            maxLines: 1,
                            controller: textControllerAddress,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, bottom: 5),
                              border: InputBorder.none,
                              hintText: 'Enter address',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'PO. Box/Zip Code',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerZipCode,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'PO. Box/Zip Code',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'City *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerCity,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Enter City name',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'State',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerState,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Enter State name',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Country *',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: MyColor.boxBorder, width: 1),
                      color: Colors.white,
                    ),

                    // dropdown below..
                    child: DropdownButton<String>(
                        value: dropdownValueCountry,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValueCountry = newValue;
                          });
                        },
                        items: countryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerProducts,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Products',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Contact Person',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerContact,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Contact Person',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 56),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Mobile Number *',
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.greyTextColor,
                              decoration: TextDecoration.none,
                              fontFamily: 'GilroySemibold'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Switch(
                          value: notificationSwitch,
                          onChanged: (value) {
                            setState(() {
                              notificationSwitch = value;
                              print(notificationSwitch);
                            });
                          },
                          activeTrackColor: MyColor.infoSnackColor,
                          activeColor: MyColor.themeColor,
                          inactiveThumbColor: MyColor.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Container(
                          child: TextFormField(
                            controller: textControllerphone,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 90.0),
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 0.5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog22('phone');
                          //llllll
                          //showDialog();
                          /*showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => DriverRatingDialog(
                                countryCodeData,searchCountryCodeData),
                          );*/
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, bottom: 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30)),
                                  color: MyColor.themeColor,
                                ),
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left: 3),
                                              child: Text(phoneNumber,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12)),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                        /*Theme(
                                     data: Theme.of(context).copyWith(
                                       canvasColor: Colors.blue.shade200,
                                     ),
                                     child:DropdownButton<String>(
                                         value: phoneNumber,
                                         icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                         iconSize: 30,
                                         underline: SizedBox(),
                                         onChanged: (String newValue) {
                                           setState(() {
                                             phoneNumber = newValue;
                                           });
                                         },
                                         items: countryCodeList.map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Container(
                                               child: Text(value,style: TextStyle(color: Colors.white,fontSize: 12)),


                                             )
                                           );
                                         }).toList())



                                 ),*/

                                        )),
                              )),
                        ),
                      )
                    ],
                  ),
                ),

                /*Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'WhatsApp Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),*/

                Padding(
                  padding: EdgeInsets.only(left: 56),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'WhatsApp Number',
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.greyTextColor,
                              decoration: TextDecoration.none,
                              fontFamily: 'GilroySemibold'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Switch(
                          value: notificationSwitch,
                          onChanged: (value) {
                            setState(() {
                              notificationSwitch = value;
                              print(notificationSwitch);
                            });
                          },
                          activeTrackColor: MyColor.infoSnackColor,
                          activeColor: MyColor.themeColor,
                          inactiveThumbColor: MyColor.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Container(
                          child: TextFormField(
                            controller: textControllerWhatsapp,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 90.0),
                              border: InputBorder.none,
                              hintText: 'WhatsApp Number',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 0.5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog22('whatsapp');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, bottom: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    color: MyColor.themeColor,
                                  ),
                                  child: Center(
                                      child:
                                          /*Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                          canvasColor: Colors.blue.shade200,
                                        ),
                                        child: DropdownButton<String>(
                                            value: whatsAppNumber,

                                            icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.white,),
                                            iconSize: 30,
                                            underline: SizedBox(),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                whatsAppNumber = newValue;
                                              });
                                            },
                                            items: countryCodeList.map<
                                                DropdownMenuItem<String>>((
                                                String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Container(
                                                    width: 25,
                                                    child: Text(value,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                      maxLines: 1,),
                                                  )
                                              );
                                            }).toList())


                                    ),


                                  )*/
                                          Padding(
                                              padding: EdgeInsets.only(left: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3),
                                                    child: Text(whatsAppNumber,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 3),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              /*Theme(
                                     data: Theme.of(context).copyWith(
                                       canvasColor: Colors.blue.shade200,
                                     ),
                                     child:DropdownButton<String>(
                                         value: phoneNumber,
                                         icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                         iconSize: 30,
                                         underline: SizedBox(),
                                         onChanged: (String newValue) {
                                           setState(() {
                                             phoneNumber = newValue;
                                           });
                                         },
                                         items: countryCodeList.map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Container(
                                               child: Text(value,style: TextStyle(color: Colors.white,fontSize: 12)),


                                             )
                                           );
                                         }).toList())



                                 ),*/

                                              )),
                                )),
                          ))
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Telephone Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            controller: textControllerTelephone,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 90.0),
                              border: InputBorder.none,
                              hintText: 'Telephone Number',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 0.5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog22('telephone');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, top: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    color: MyColor.themeColor,
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3),
                                                child: Text(telephoneNumber,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 3),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                          /*Theme(
                                     data: Theme.of(context).copyWith(
                                       canvasColor: Colors.blue.shade200,
                                     ),
                                     child:DropdownButton<String>(
                                         value: phoneNumber,
                                         icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                         iconSize: 30,
                                         underline: SizedBox(),
                                         onChanged: (String newValue) {
                                           setState(() {
                                             phoneNumber = newValue;
                                           });
                                         },
                                         items: countryCodeList.map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Container(
                                               child: Text(value,style: TextStyle(color: Colors.white,fontSize: 12)),


                                             )
                                           );
                                         }).toList())



                                 ),*/

                                          )),
                                )),
                          ))
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'We chat Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            controller: textControllerWeChat,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 90.0),
                              border: InputBorder.none,
                              hintText: 'We Chat Number',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 0.5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog22('wechat');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, top: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    color: MyColor.themeColor,
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3),
                                                child: Text(weNumber,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 3),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                          /*Theme(
                                     data: Theme.of(context).copyWith(
                                       canvasColor: Colors.blue.shade200,
                                     ),
                                     child:DropdownButton<String>(
                                         value: phoneNumber,
                                         icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                         iconSize: 30,
                                         underline: SizedBox(),
                                         onChanged: (String newValue) {
                                           setState(() {
                                             phoneNumber = newValue;
                                           });
                                         },
                                         items: countryCodeList.map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Container(
                                               child: Text(value,style: TextStyle(color: Colors.white,fontSize: 12)),


                                             )
                                           );
                                         }).toList())



                                 ),*/

                                          )),
                                )),
                          ))
                    ],
                  ),
                ),

                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 56),
                      child: Text(
                        'Document Upload',
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColor.greyTextColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    ),
                    SizedBox(width: 25),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.lightGreyTextColor,
                          ),
                          child: Center(
                            child: TextWidget('Upload', Colors.black, 12),
                          )),
                    )
                  ],
                ),

                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    /*  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => SuccessDialog('Logged in successfully !!',context),
                    );*/

                    if (textControllerUserName.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            'User Name/Email cannot be empty !!', context),
                      );
                    } else if (textControllerPassword.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            ErrorDialog('Password cannot be blank !!', context),
                      );
                    } else if (textControllerCompanyName.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            ' Company name cannot be blank !!', context),
                      );
                    } else if (textControllerCity.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            ' City name cannot be blank !!', context),
                      );
                    } else if (textControllerConfirmPassword.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            'Confirm Password cannot be blank !!', context),
                      );
                    } else if (textControllerphone.text == '') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            'Mobile Number cannot be left empty !! !!',
                            context),
                      );
                    } else if (dropdownValue == 'Select User Type') {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            'Please select a user type !!', context),
                      );
                    } else if (dropdownValueCountry == 'Select Country') {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            ErrorDialog('Please select a country !!', context),
                      );
                    }
                    /*  if (textControllerUserName.text == '' ||
                        textControllerPassword.text == '' ||
                        textControllerCompanyName.text == ''
                        || textControllerCity.text == '' ||
                        textControllerConfirmPassword.text == '' ||
                        textControllerphone.text == '' ||
                        dropdownValue == 'Select User Type' ||
                        dropdownValueCountry == 'Select Country') {
                      MySnackbar.displaySnackbar(key, Colors.lightBlue,
                          'Please fill all the fields !!');
                    }*/
                    else if (textControllerPassword.text !=
                        textControllerConfirmPassword.text) {
                      showDialog(
                        context: context,
                        builder: (_) => ErrorDialog(
                            'Password/Confirm Password do not match !!',
                            context),
                      );
                    } else {
                      if (callbackType == 'update') {
                        if (textControllerPassword.text == '') {
                          showDialog(
                            context: context,
                            builder: (_) => ErrorDialog(
                                'Password cannot be blank !!', context),
                          );
                        } else if (textControllerConfirmPassword.text == '') {
                          showDialog(
                            context: context,
                            builder: (_) => ErrorDialog(
                                'Confirm Password cannot be blank !!', context),
                          );
                        } else if (textControllerConfirmPassword.text !=
                            textControllerPassword.text) {
                          showDialog(
                            context: context,
                            builder: (_) => ErrorDialog(
                                'Password/Confirm Password do not match !!',
                                context),
                          );
                        } else {
                          UpdateUserDetails();
                        }
                      } else {
                        registerUser();
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Card(
                      color: MyColor.themeColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                              child: callbackType == 'update'
                                  ? TextWidget(
                                      'UPDATE DETAILS', MyColor.whiteColor, 20)
                                  : TextWidget(
                                      'REGISTRATION', MyColor.whiteColor, 20))),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> registerUser() async {
    String message = '';
    String fileName = '';
    if (_image != null) {
      fileName = _image.path.split("/").last;
    }
    APIDialog.showAlertDialog(context, 'Registering Account...');
    final Map<String, dynamic> collectedAuthData = {
      'vchUserType': dropdownValue,
      'vchUserName': '',
      'vchUserID': textControllerUserName.text,
      'nvrPassword': textControllerPassword.text,
      'vchCompanyName': textControllerCompanyName.text,
      'vchAddress': textControllerAddress.text,
      'vchZipCode': textControllerZipCode.text,
      'vchCity': textControllerCity.text,
      'vchCountry': dropdownValueCountry,
      'vchContactPerson': textControllerContact.text,
      'vchMobileNo': textControllerphone.text,
      'vchWhatsAppNo': textControllerWhatsapp.text,
      'vchTelePhoneNo': textControllerTelephone.text,
      'vchWeChatNo': textControllerWeChat.text,
      'IsActive': 'true',
      'intCreatedBy': '0',
      'vchIPAddress': textControllerAddress.text,
      'Mode': 'private',
      'vchCountryCallCode': phoneNumber,
      'vchWhatsAppCountryCode': whatsAppNumber,
      'vchTelePhoneCountryCode': telephoneNumber,
      'vchWeChatCountryCode': weNumber,
      'vchProduct': textControllerProducts.text,
      'vchState': textControllerState.text,
      'vchFileName': fileName,
      'nvrFile': fileName == '' ? '' : imageAsBase64,
    };
    print(collectedAuthData);

    try {
      http.Response response;
      response = await http.post(
          'http://api.123etl.net/API/Master/InsertUserDetails',
          body: json.encode(collectedAuthData),
          headers: {
            'Content-Type': 'application/json',
          });
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();

      if (fetchResponse['Status'].toString() == 'true') {
        Navigator.pop(context, true);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog(fetchResponse['Message'], context),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ErrorDialog(fetchResponse['Message'], context),
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<Map<String, dynamic>> UpdateUserDetails() async {
    String message = '';
    String fileName = '';
    if (_image != null) {
      fileName = _image.path.split("/").last;
    }
    APIDialog.showAlertDialog(context, 'Updating Details...');
    final Map<String, dynamic> collectedAuthData = {
      'vchUserType': dropdownValue,
      'vchUserName': '',
      'intUserID': userId,
      'vchUserID': textControllerUserName.text,
      'nvrPassword': textControllerPassword.text,
      'vchCompanyName': textControllerCompanyName.text,
      'vchAddress': textControllerAddress.text,
      'vchZipCode': textControllerZipCode.text,
      'vchCity': textControllerCity.text,
      'vchCountry': dropdownValueCountry,
      'vchContactPerson': textControllerContact.text,
      'vchMobileNo': textControllerphone.text,
      'vchWhatsAppNo': textControllerWhatsapp.text,
      'vchTelePhoneNo': textControllerTelephone.text,
      'vchWeChatNo': textControllerWeChat.text,
      'IsActive': 'true',
      'intCreatedBy': '0',
      'vchIPAddress': textControllerAddress.text,
      'Mode': 'private',
      'vchCountryCallCode': phoneNumber,
      'vchWhatsAppCountryCode': whatsAppNumber,
      'vchTelePhoneCountryCode': telephoneNumber,
      'vchWeChatCountryCode': weNumber,
      'vchProduct': textControllerProducts.text,
      'vchState': textControllerState.text,
      'vchFileName': fileName,
      'nvrFile': fileName == '' ? '' : imageAsBase64,
      //'nvrFile': 'textControllerState',
    };

    try {
      http.Response response;
      response = await http.post(
          'http://api.123etl.net/API/Master/InsertUserDetails',
          body: json.encode(collectedAuthData),
          headers: {'Content-Type': 'application/json'});
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();

      if (fetchResponse['Status'].toString() == 'true') {
        Navigator.pop(context, true);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) =>
              SuccessDialog('Profile Updated Successfully !!', context),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ErrorDialog(fetchResponse['Message'], context),
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<Map<String, dynamic>> getCountryList() async {
    APIDialog.showAlertDialog(context, 'Fetching Countries.....');

    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/Country',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        countryData = fetchResponse['Response']['Country'];
        if (countryData.length != 0) {
          countryList.add('Select Country');
          for (int i = 0; i < countryData.length; i++) {
            countryList.add(countryData[i]['vchCountryName']);
          }
        }
      });

      print(fetchResponse);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<Map<String, dynamic>> getCountryCodeList() async {
    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/Countrycode',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);

      setState(() {
        countryCodeData = fetchResponse['Response']['CountryCode'];
        searchCountryCodeData = fetchResponse['Response']['CountryCode'];
        if (countryCodeData.length != 0) {
          countryCodeList.add('Select Country Code');
          for (int i = 0; i < countryCodeData.length; i++) {
            countryCodeList.add(countryCodeData[i]['vchCountryName']);
          }
        }
      });

      print(fetchResponse);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
    checkInternetAPIcall2();
    if (callbackType == 'update') {
      getUserData();
    }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getCountryList();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  void userDataFetch() async {
    if (await InternetCheck.check() == true) {
      getCountryList();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  void checkInternetAPIcall2() async {
    if (await InternetCheck.check() == true) {
      getCountryCodeList();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  Future<Map<String, dynamic>> apiCall() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Fetching User Details...');
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/GetEdit_UserDetails?intUserID=' +
            userId,
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      list = fetchResponse['Response']['Edit_UserDetails'];
      setState(() {
        textControllerUserName.text = list[0]['vchUserID'];
        // textControllerPassword.text = list[0]['nvrPassword'];
        //textControllerConfirmPassword.text = list[0]['nvrPassword'];
        // dropdownValue=list[0]['vchUserType'];
        textControllerCompanyName.text = list[0]['vchCompanyName'];
        textControllerAddress.text = list[0]['vchAddress'];
        textControllerZipCode.text = list[0]['vchZipCode'].toString();
        textControllerCity.text = list[0]['vchCity'];
        dropdownValueCountry = list[0]['vchCountry'];
        textControllerContact.text = list[0]['vchContactPerson'];
        textControllerphone.text = list[0]['vchMobileNo'].toString();
        textControllerWhatsapp.text = list[0]['vchWhatsAppNo'];
        textControllerTelephone.text = list[0]['vchTelePhoneNo'];
        textControllerWeChat.text = list[0]['vchWeChatNo'];
        textControllerProducts.text = list[0]['vchProduct'];
        textControllerState.text = list[0]['vchState'];
      });
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      //Navigator.pop(context);
    }
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid');
    });

    apiCall();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      List<int> imageBytes = _image.readAsBytesSync();
      imageAsBase64 = base64Encode(imageBytes);
    });
    Toast.show(
      'File Uploaded !!',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  void showDialog22(String callbackType) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return Container(
          height: 200,
          child: Scaffold(
            body: ListView(
              children: <Widget>[
                /*Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Container(
                          child: TextField(
                            onChanged: (query) {
                              performSearch(query);
                            },
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerUserName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 10.0, bottom: 10),
                              border: InputBorder.none,
                              hintText: 'Search by Country Name',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),

                        ),
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20, top: 15),
                            child: Image.asset(
                              'images/icon_search.png', width: 18,
                              height: 18,
                              color: MyColor.themeColor,),
                          )
                      )


                    ],


                  ),


                ),*/
                ListView.builder(
                    itemCount: countryCodeData.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int position) {
                      return GestureDetector(
                          onTap: () {
                            print('not trigger');
                            Navigator.pop(context);
                            if (callbackType == 'phone') {
                              setState(() {
                                phoneNumber =
                                    countryCodeData[position]['vchCallCode'];
                              });
                            } else if (callbackType == 'whatsapp') {
                              setState(() {
                                whatsAppNumber =
                                    countryCodeData[position]['vchCallCode'];
                              });
                            } else if (callbackType == 'telephone') {
                              setState(() {
                                telephoneNumber =
                                    countryCodeData[position]['vchCallCode'];
                              });
                            } else if (callbackType == 'wechat') {
                              setState(() {
                                weNumber =
                                    countryCodeData[position]['vchCallCode'];
                              });
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      countryCodeData[position]
                                          ['vchCountryName'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontFamily: 'GilroySemibold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Divider(color: MyColor.greyDivider)
                            ],
                          ));
                    }),
              ],
            ),
          ),
          margin: EdgeInsets.only(bottom: 50, left: 15, right: 15, top: 50),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  performSearch(String searchedText) {
    print('trigger generated' + searchedText);
    if (searchCountryCodeData.length != 0) {
      setState(() {
        searchCountryCodeData.clear();
      });
    }

    for (int i = 0; i < countryCodeData.length; i++) {
      print(countryCodeData[i]['vchCountryName'] + 'scr');
      if (countryCodeData[i]['vchCountryName']
          .toString()
          .toLowerCase()
          .contains(searchedText)) {
        searchCountryCodeData.add(countryCodeData[i]);
        print(countryCodeData[i] + 'wdwft');
      }
    }

    print(searchCountryCodeData.toString());
  }
}
