
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefineSearchScreen extends StatefulWidget
{
  String title;
  RefineSearchScreen(this.title);
  RefineSearchState createState()=>RefineSearchState(title);
  }


class RefineSearchState extends State<RefineSearchScreen>
{
  String title,categoryDropDown='Select Category';
  RefineSearchState(this.title);
  var textControllerKeyword = new TextEditingController();
  var textControllerState = new TextEditingController();
  var textControllerCity = new TextEditingController();
  List<String> productNames=['PPE Kits','Googles','Gloves','Face Shields','PPE Kits','Googles'];
  List<String> productImages=['images/dummy1.jpg','images/dummy2.jpg','images/dummy3.jpg','images/dummy4.jpg','images/dummy1.jpg','images/dummy2.jpg'];
  bool checkValue1=false,checkValue2=false,checkValue3=false;
  String dropdownValueKeyword = 'Keyword';
  int indexOfProduct=-1;
  String phoneNumber='+91';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Stack(
         children: <Widget>[
           Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
           ListView(
             children: <Widget>[
               SizedBox(height: 55),
               Container(
                 width: double.infinity,
                 child: Center(
                   child: Text(
                     title,
                     style: TextStyle(
                         fontSize: 30,
                         color: MyColor.greyTextColor,
                         fontFamily: 'GilroySemibold'),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
               SizedBox(height: 25),

               Container(
                 width: double.infinity,
                 child: Center(
                   child: Text(
                     'Refine Search',
                     style: TextStyle(
                         fontSize: 17,
                         color: MyColor.greyTextColor,
                         fontFamily: 'GilroySemibold'),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
               SizedBox(height: 20),
               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 12, left: 56),
                 child: Text(
                   'Keyword:*',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),
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
                     controller: textControllerKeyword,
                     decoration: InputDecoration(
                       contentPadding: const EdgeInsets.only(left: 10.0),
                       border: InputBorder.none,


                       hintText: 'Enter keyword',
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
                       child:DropdownButton<String>(
                           value: categoryDropDown,
                           isExpanded: true,
                           icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                           iconSize: 30,
                           underline: SizedBox(),
                           onChanged: (String newValue) {
                             setState(() {
                               //_selectedColor = Colors.white;
                               categoryDropDown = newValue;
                             });
                           },
                           items: <String>[
                             'Select Category',
                             'Mask',
                             'Coveralls/PPE KIts',
                             'Covid 19 Testing kits',
                             'Gloves',
                             'Goggles/Face Shields',
                             'Shoe Cover',
                             'Ventilators'
                           ].map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style: TextStyle(color: Colors.white),),
                             );
                           }).toList())



                   ),
                 ),
               ),
               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 12, left: 56),
                 child: Text(
                   'Country:*',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),

               SizedBox(height: 5),
               Container(
                 height: 50,
                 width: double.infinity,
                 child: Stack(

                   children: <Widget>[

                     Padding(
                       padding: EdgeInsets.only(left: 40, right: 40),
                       child: Container(
                         child: TextFormField(
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
                                 fontSize: 12,
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

                     Padding(
                       padding: EdgeInsets.only(left: 40),
                       child:  Align(
                           alignment: Alignment.centerLeft,
                           child: Container(
                             width: 60,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:Radius.circular(30) ),
                               color: MyColor.themeColor,
                             ),
                             child: Center(
                               child: Padding(
                                 padding: EdgeInsets.only(left: 5),
                                 child: Theme(
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
                                         items: <String>[
                                           '+91',
                                           '+67',
                                           '+45',
                                           '+56',
                                         ].map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(value,style: TextStyle(color: Colors.white,fontSize: 12),),
                                           );
                                         }).toList())



                                 ),


                               )


                             ),


                           )


                       ),


                     )


                   ],


                 ),


               ),




               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 12, left: 56),
                 child: Text(
                   'State:*',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),



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
                     controller: textControllerState,
                     decoration: InputDecoration(
                       contentPadding: const EdgeInsets.only(left: 10.0),
                       border: InputBorder.none,


                       hintText: 'State',
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



               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 12, left: 56),
                 child: Text(
                   'City:*',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),
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
                     controller: textControllerCity,
                     decoration: InputDecoration(
                       contentPadding: const EdgeInsets.only(left: 10.0),
                       border: InputBorder.none,


                       hintText: 'City',
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

               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 12, left: 56),
                 child: Text(
                   'User Type',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),

SizedBox(height: 5,),

             Padding(
               padding: EdgeInsets.only(left: 30,right: 30),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[

                   SizedBox(
                     height: 24,
                     width: 24,
                     child: Checkbox(
                         value: checkValue1,
                         checkColor: Colors.white,  // color of tick Mark
                         activeColor: MyColor.themeColor,
                         onChanged: (bool value) {
                           setState(() {
                             checkValue1 = value;
                           });
                         }),


                   ),

                   TextWidget('Agent',Colors.black87,14),




                  SizedBox(height: 24,width:24,child:  Checkbox(
                      value: checkValue2,
                      checkColor: Colors.white,  // color of tick Mark
                      activeColor: MyColor.themeColor,
                      onChanged: (bool value) {
                        setState(() {
                          checkValue2 = value;
                        });
                      })),


                   TextWidget('Trader',Colors.black87,14),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child:  Checkbox(
                        value: checkValue3,
                        checkColor: Colors.white,  // color of tick Mark
                        activeColor: MyColor.themeColor,
                        onChanged: (bool value) {
                          setState(() {
                            checkValue3 = value;
                          });
                        }),


                  ),


                   TextWidget('Manufacturer',Colors.black87,14),






                 ],


               ),


             ),


               SizedBox(height: 25),
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
                         height: 50,
                         child: Center(
                           child: TextWidget(
                               'REFINE SEARCH', MyColor.whiteColor, 18),
                         )),
                   ),
                 ),

               ),

               SizedBox(height: 20),
               Padding(
                 padding: EdgeInsets.only(right: 20),
                 child: GridView.count(
                   crossAxisCount: 3,
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                   children: productImages.map((String value) {
                     indexOfProduct=indexOfProduct+1;
                     return new  Container(
                       height: 150,
                       margin: EdgeInsets.only(left: 20),
                       child:
                       Column(
                         children: <Widget>[

                           Stack(
                             children: <Widget>[
                               Container(
                                   height:90,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20),
                                     color: MyColor.themeColor,
                                   ),
                                 child: Center(
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(20.0),
                                     child: Image.asset(value
                                       ,
                                       height: 70.0,
                                       width: 120.0,
                                     ),
                                   ),


                                 ),



                               ),



                             ],


                           )



                         ],


                       ),
                     );
                   }).toList(),
                 ),
               ),


             ],



           )



         ],


       ),



     ),



   );
  }

}

