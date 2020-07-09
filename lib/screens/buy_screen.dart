

import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyScreen extends StatelessWidget
{

  String titleName;
  BuyScreen(this.titleName);

  var textControllerContact = new TextEditingController();
  String dropdownValue = 'Select User Type';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
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
                            'I WANT TO '+titleName,
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
                                  controller: textControllerContact,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 60.0),
                                    border: InputBorder.none,
                                    hintText: 'Anuj Pal',
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
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 60,top: 7),
                                  child: Image.asset(
                                      'images/profile.png', width: 15, height: 15,color: MyColor.themeColor,),


                                )


                            )


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
                          padding: EdgeInsets.only(left: 20,right: 15),
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
                                icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                iconSize: 30,
                                underline: SizedBox(),
                                onChanged: (String newValue) {
                                  /*  setState(() {
                                  dropdownValue = newValue;
                                });*/
                                },
                                items: <String>[
                                  'Select User Type',
                                  'Agent',
                                  'Trader',
                                  'Manufacturer',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: TextStyle(color: Colors.white),),
                                  );
                                }).toList()),


                          )
                        ),
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
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          height: 120,
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
                            border: Border.all(
                                color: MyColor.boxBorder, width: 1),
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
                        onTap: (){
                        },

                        child:  Padding(
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
                                  child: TextWidget(
                                      'Upload', MyColor.whiteColor, 13),
                                )),
                          ),
                        ),

                      ),

                      SizedBox(height: 7),

                      Container(
                        child: Center(
                          child: TextWidget('Choose a file',Colors.black87,14),


                        ),



                      ),
                      SizedBox(height: 7),
                      GestureDetector(
                        onTap: (){
                        },

                        child:  Padding(
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
                                  child: TextWidget(
                                      'SUBMIT LEAD', MyColor.whiteColor, 20),
                                )),
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


}