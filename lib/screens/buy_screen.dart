import 'dart:convert';
import 'dart:io';

import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/dialog/error_dialog.dart';
import 'package:everglobe/dialog/success_dialog.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class BuyScreen extends StatefulWidget {
  String titleName,
      productid,
      productTitle,
      productCategory,
      productDes,
      userType;

  BuyScreen(this.titleName, this.productid, this.productTitle,
      this.productCategory, this.productDes, this.userType);

  BuyScreenState createState() => BuyScreenState(titleName, productid,
      productTitle, productCategory, productDes, userType);
}

class BuyScreenState extends State<BuyScreen> {
  File _image;
  String insertUserId;
  List<String> categoryList = [];
  List<dynamic> categoryData = [];
  List<String> subCategoryList = [];
  List<dynamic> subCategoryData = [];
  final picker = ImagePicker();
  String titleName,
      productid,
      productTitle,
      productCategory,
      productDes,
      userType,
      imageAsBase64='';

  BuyScreenState(this.titleName, this.productid, this.productTitle,
      this.productCategory, this.productDes, this.userType);

  var textControllerPName = new TextEditingController();
  var textControllerDescriptions = new TextEditingController();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String dropdownValue = 'Select Category';
  String dropdownValue2 = 'Select Sub Category';

  @override
  Widget build(BuildContext context) {
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
                      'I WANT TO ' + titleName,
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
                    'Title',
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
                            controller: textControllerPName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 60.0),
                              border: InputBorder.none,
                              hintText: 'Eg. PPE Kits',
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 60, top: 7),
                            child: Image.asset(
                              'images/profile.png',
                              width: 15,
                              height: 15,
                              color: MyColor.themeColor,
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Category:*',
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
                      padding: EdgeInsets.only(left: 20, right: 15),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: MyColor.themeColor,
                      ),

                      // dropdown below..
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.blue.shade200,
                        ),
                        child: DropdownButton<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                getSubCategoryList();
                              });
                            },
                            items: categoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList()),
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Sub Category:*',
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
                      padding: EdgeInsets.only(left: 20, right: 15),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: MyColor.themeColor,
                      ),

                      // dropdown below..
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.blue.shade200,
                        ),
                        child: DropdownButton<String>(
                            value: dropdownValue2,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue2 = newValue;
                              });
                            },
                            items: subCategoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList()),
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 56),
                  child: Text(
                    'Details:*',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                  child: Container(
                    height: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          fontFamily: 'GilroySemibold'),
                      controller: textControllerDescriptions,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        border: InputBorder.none,
                        hintText: 'About Products',
                        hintStyle: TextStyle(
                            color: MyColor.lightGreyTextColor,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: MyColor.boxBorder, width: 1),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                        width: 47.3,
                        height: 47,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColor.themeColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 0.0)
                          ],
                        ),
                        child: Center(
                            child: Image.asset(
                          'images/upload.png',
                          height: 20.3,
                          width: 20.3,
                        ))),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 130, right: 130),
                    child: Card(
                      color: Colors.grey,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                          width: double.infinity,
                          height: 32,
                          child: Center(
                            child: TextWidget('Upload', MyColor.whiteColor, 13),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                GestureDetector(
                  onTap: () {
                    if (textControllerPName.text == '' ||
                        textControllerDescriptions.text == '') {
                      MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                          'Please fill all fields');
                    } else if (dropdownValue == 'Select Category') {
                      MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                          'Please select a category');
                    } else {
                      if (productid != '') {
                        updateProduct();
                      } else {
                          if (titleName == 'BUY') {
                            addProduct('buyer');
                            //_asyncFileUpload();
                          } else {
                            addProduct('seller');
                          }

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
                              child: productid == ''
                                  ? TextWidget(
                                      'SUBMIT LEAD', MyColor.whiteColor, 20)
                                  : TextWidget('UPDATE DETAILS',
                                      MyColor.whiteColor, 20))),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> addProduct(String userType) async {
    String message = '';
    String fileName = '';
    if (_image != null) {
      fileName = _image.path.split("/").last;
    }
    print(fileName);
    final Map<String, dynamic> collectedAuthData = {
      'vchFileName': fileName,
      'vchTitle': textControllerPName.text,
      'vchDescriptions': textControllerDescriptions.text,
      'vchCategory': dropdownValue,
      'vchSubCategory': dropdownValue2,
      'vchUserType': userType,
      'IsActive': 'true',
      'intCreatedBy': insertUserId,
      'vchIPAddress': '',
      'Mode': '',
      'intProductId': '0',
      'intUserId': insertUserId,
      'nvrFile': fileName==''?'':imageAsBase64,
    };
    print(collectedAuthData);
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.post(
          'http://api.123etl.net/API/Master/InsertProductDetails',
          body: json.encode(collectedAuthData),
          headers: {
            'Content-Type': 'application/json',
          });
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.pop(context);
      if (fetchResponse['Status'].toString() == 'true') {
        Navigator.pop(context, 'Product Inserted');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog(fetchResponse['Message'],context),
        );

      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ErrorDialog(fetchResponse['Message'],context),
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message + 'op');
      Navigator.pop(context);
    }
  }

  Future<Map<String, dynamic>> updateProduct() async {
    String message = '';
    String fileName='';
    if (_image != null) {
      fileName = _image.path.split("/").last;
    }
    final Map<String, dynamic> collectedAuthData = {
      'vchTitle': textControllerPName.text.toString(),
      'vchDescriptions': textControllerDescriptions.text.toString(),
      'vchCategory': dropdownValue,
      'intProductId': productid,
      'vchUserType': userType,
      'intCreatedBy': insertUserId,
      'nvrFile': _image == null ? null : imageAsBase64,
      'IsActive': 'true',
      'vchIPAddress': '',
      'Mode': '',
      'vchFileName': fileName,
      'nvrFile': fileName==''?'':imageAsBase64,
    };
    print(collectedAuthData);
    APIDialog.showAlertDialog(context, 'Updating Details...');
    try {
      http.Response response;
      response = await http.post(
          'http://api.123etl.net/API/Master/InsertProductDetails',
          body: json.encode(collectedAuthData),
          headers: {
            'Content-Type': 'application/json',
          });
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.pop(context);
      if (fetchResponse['Status'].toString() == 'true') {
        Navigator.pop(context, 'Product Updated');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog('Product Updated successfully !!',context),
        );

      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ErrorDialog(fetchResponse['Message'],context),
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      Navigator.pop(context);
      print(message);
    }
  }

  _updateData() {
    print(productCategory);
    setState(() {
      textControllerPName.text = productTitle;
      textControllerDescriptions.text = productDes;
      //dropdownValue=productCategory;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
    if (productid != '') {
      _updateData();
    } else {
      _getUserId();
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      List<int> imageBytes = _image.readAsBytesSync();
      imageAsBase64 = base64Encode(imageBytes).toString();
    });
    Toast.show(
      'File Uploaded !!',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.green,
    );

    print(imageAsBase64);
  }

  Future<Map<String, dynamic>> getCategoryList() async {
    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/getMstProduct',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        categoryData = fetchResponse['Response']['Products'];
        if (categoryData.length != 0) {
          categoryList.add('Select Category');
          for (int i = 0; i < categoryData.length; i++) {
            categoryList.add(categoryData[i]['vchProductName']);
          }
          if (productid != '') {
            dropdownValue = productCategory;
          }
        }
      });

      print(fetchResponse);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
    }
  }

  Future<Map<String, dynamic>> getSubCategoryList() async {
    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/GetMstSubProduct?vchProductName=' +
            dropdownValue,
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        if (subCategoryList.length != 0) {
          subCategoryList.clear();
          subCategoryData.clear();
        }
        subCategoryData = fetchResponse['Response']['SubProducts'];
        if (subCategoryData.length != 0) {
          subCategoryList.add('Select Sub Category');
          for (int i = 0; i < subCategoryData.length; i++) {
            subCategoryList.add(subCategoryData[i]['vchSubProductName']);
          }
        } else {
          subCategoryList.add('Select Sub Category');
        }
      });

      print(fetchResponse);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
    }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getCategoryList();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    insertUserId = await prefs.getString('userid');
  }
}
