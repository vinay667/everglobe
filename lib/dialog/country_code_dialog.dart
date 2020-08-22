

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CountryCodeDialog extends StatefulWidget
{
  CountryCodeState createState()=>CountryCodeState();
}
class CountryCodeState extends State<CountryCodeDialog>
{
  List<dynamic> countryCodeData = [];
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: Container(
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

                        onTap: (){

                          print('not trigger');
                       /*   Navigator.pop(context);
                          if(callbackType=='phone')
                          {
                            setState(() {
                              phoneNumber=countryCodeData[position]['vchCallCode'];
                            });
                          }
                          else if(callbackType=='whatsapp')
                          {
                            setState(() {
                              whatsAppNumber=countryCodeData[position]['vchCallCode'];
                            });
                          }
                          else if(callbackType=='telephone')
                          {
                            setState(() {
                              telephoneNumber=countryCodeData[position]['vchCallCode'];
                            });
                          }

                          else if(callbackType=='wechat')
                          {
                            setState(() {
                              weNumber=countryCodeData[position]['vchCallCode'];
                            });
                          }
*/








                        },

                        child: Column(
                          children: <Widget>[

                            Container(

                                width: double.infinity,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    countryCodeData[position]['vchCountryName'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black87,
                                        fontFamily: 'GilroySemibold',
                                        fontWeight: FontWeight.bold),

                                  ),


                                )
                            ),

                            Divider(color:MyColor.greyDivider)






                          ],



                        )

                    );
                  }


              ),


            ],


          ),


        ),
        margin: EdgeInsets.only(bottom: 50, left: 15, right: 15, top: 50),
      )

    );

  }


}