import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../colors/colors.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';

class SuccessDialog extends StatelessWidget {
  String message;
  BuildContext context;
  SuccessDialog(this.message,this.context);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10.0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      height: 220,
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    transform: Matrix4.translationValues(5.0, -5.0, 0.0),
                    width: 24,
                    height: 24,
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
                          'images/cross_white.png',
                          width: 8,
                          height: 8,
                        ))),


              )
          ),
          SizedBox(height: 20,),
          Text('Message',textAlign:TextAlign.center,style: TextStyle(
              fontSize: 20,
              color: MyColor.infoSnackColor,
              decoration: TextDecoration.none,
              fontFamily: 'GilroySemibold')),
          SizedBox(height: 20,),
          Text(message,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign:TextAlign.center,style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              decoration: TextDecoration.none,
              fontFamily: 'GilroySemibold')),
          SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                width: 140,
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: MyColor.themeColor),
                child: Center(child: Text('OK',style: TextStyle(color: Colors.white,fontSize: 17),))
            ),

          )



        ],


      ),

    );
  }






}
