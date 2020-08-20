import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
import '../colors/colors.dart';
import 'package:http/http.dart' as http;

class DriverRatingDialog extends StatefulWidget {
  List<dynamic> countryCodeData = [];
  List<dynamic> searchCountryCodeData = [];
  DriverRatingDialog(this.countryCodeData,this.searchCountryCodeData);
  @override
  State<StatefulWidget> createState() => StartTripDialogState(countryCodeData,searchCountryCodeData);
}

class StartTripDialogState extends State<DriverRatingDialog>
    with SingleTickerProviderStateMixin {
  List<dynamic> countryCodeData = [];
  List<dynamic> searchCountryCodeData = [];
  StartTripDialogState(this.countryCodeData,this.searchCountryCodeData);
  AnimationController controller;
  Animation<double> scaleAnimation;
  int ratingCount=3;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 400,
            child: Scaffold(
              body: ListView(
                children: <Widget>[

                  Container(
                    height: 55,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Container(
                            child: TextField(
                              onChanged: (query) {
                                if(query.length>2)
                                {
                                  performSearch(query);
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
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


                  ),
                  ListView.builder(
                      itemCount: searchCountryCodeData.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int position) {
                        return Container(

                            width: double.infinity,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                searchCountryCodeData[position]['vchCountryName'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.black87,
                                    fontFamily: 'GilroySemibold',
                                    fontWeight: FontWeight.bold),

                              ),


                            )
                        );
                      }


                  ),


                ],


              ),


            ),
            margin: EdgeInsets.only(bottom: 50, left: 15, right: 15, top: 50),
          )),
    );
  }





  performSearch(String searchedText) {
    print('trigger generated'+searchedText);
/*    if(searchCountryCodeData.length!=0)
    {
      setState(() {
        searchCountryCodeData.clear();
      });
    }*/
List<dynamic> searchList;
    for(int i=0;i<countryCodeData.length;i++)
    {

      print(countryCodeData[i]['vchCountryName']+'scr');
      if(countryCodeData[i]['vchCountryName'].toString().toLowerCase()==searchedText)
      {
        searchList.add(countryCodeData[i]);
        print(countryCodeData[i]+'wdwft');
      }
    }
   /* setState(() {
    *//*  if(searchCountryCodeData.length!=0)
        {
          searchCountryCodeData.clear();
        }*//*
      searchCountryCodeData=searchList;
    });*/
    print(searchCountryCodeData.toString());
  }
}
