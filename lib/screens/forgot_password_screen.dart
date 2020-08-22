

import 'dart:convert';

import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/dialog/success_dialog.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ForgotPasswordScreen extends StatefulWidget
{
  ForgotPasswordState createState()=>ForgotPasswordState();
}
class ForgotPasswordState extends State<ForgotPasswordScreen>
{
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var textControllerUserName = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
            Column(
              children: <Widget>[
                SizedBox(height: 25),



                Image.asset('images/app_l.png',width: 80,height: 80,),


                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: Center(

                    child: TextWidget('FORGOT PASSWORD', MyColor.greyTextColor, 30),


                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, left: 56),
                  child: Text(
                    'Username',
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
                            controller: textControllerUserName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Username',
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
                                color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),

                        ),
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Image.asset(
                                'images/user_c.png', width: 18, height: 18,color: MyColor.themeColor,),


                          )


                      )


                    ],


                  ),


                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Password',
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
                            border: Border.all(
                                color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),

                        ),
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Image.asset(
                                'images/password_icon.png', width: 18, height: 18,color: MyColor.themeColor,),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: (){
                    if(textControllerUserName.text=='' )
                    {
                      MySnackbar.displaySnackbar(key, Colors.blue, 'Please fill Username/Email');
                    }
                    else
                    {
                      changePassword();
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
                            child: TextWidget('RESET PASSWORD', MyColor.whiteColor, 20),


                          )


                      ),


                    ),


                  ),


                ),




              ],


            )


          ],


        ),


      ),


    );
  }

  Future<Map<String, dynamic>> changePassword() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.post(
        'http://api.123etl.net/API/Master/UpdateForgotPassword?vchUserID='+textControllerUserName.text+'&nvrPassword='+textControllerPassword.text,
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context,true);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog('Password Updated Successfully !!',context),
      );


    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context,true);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog('Password Updated Successfully !!',context),
      );

      //Navigator.pop(context);
    }
  }



}
