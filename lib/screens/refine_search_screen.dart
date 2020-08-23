
import 'dart:convert';
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/constants/AppConstants.dart';
import 'package:everglobe/dialog/error_dialog.dart';
import 'package:everglobe/screens/view_item_screen.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/screens/login_screen.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/product_model.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/utils/validations.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';

class RefineSearchScreen extends StatefulWidget
{
  String title,type,searchText,loginToken;
  RefineSearchScreen(this.title,this.type,this.searchText,this.loginToken);
  RefineSearchState createState()=>RefineSearchState(title,type,searchText,loginToken);
  }


class RefineSearchState extends State<RefineSearchScreen>
{

  String title,categoryDropDown='Select Category',type,searchText,loginToken;
  List<String> categoryList=[];
  List<dynamic> categoryData=[];
  RefineSearchState(this.title,this.type,this.searchText,this.loginToken);
  List<Product> searchList=[];
  List<dynamic> searchList2=[];
  List<dynamic> countryData=[];
  List<String> countryList=[];
  var textControllerKeyword = new TextEditingController();
  var textControllerState = new TextEditingController();
  var textControllerCity = new TextEditingController();
    GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<String> productNames=['PPE Kits','Googles','Gloves','Face Shields','PPE Kits','Googles'];
  List<String> productImages=['images/dummy1.jpg','images/dummy2.jpg','images/dummy3.jpg','images/dummy4.jpg','images/dummy1.jpg','images/dummy2.jpg'];
  bool checkValue1=false,checkValue2=false,checkValue3=false;
  String dropdownValueCountry = 'Select Country';
  int indexOfProduct=-1;
  final _scrollController=ScrollController();
  String phoneNumber='+91';
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     key: key,
     body: SafeArea(
       child: Stack(
         children: <Widget>[
           Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
           ListView(
             controller: _scrollController,
             children: <Widget>[
               SizedBox(height: 5),
               searchList2.length>0?Padding(
                 padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                 child: Text('Search Results for '+searchText,style: TextStyle(fontSize: 17,color: Colors.brown),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
               ):Text(''),
               SizedBox(height: 5),
               Container(
                 width: double.infinity,
                 child: Center(
                   child: Text(
                     'REFINE SEARCH',
                     style: TextStyle(
                         fontSize:23,
                         color: MyColor.greyTextColor,
                         fontFamily: 'GilroySemibold'),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
               SizedBox(height: 10),
               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 4, left: 56),
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
                 padding: EdgeInsets.only(top: 4, left: 56),
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
                           items: categoryList.map<DropdownMenuItem<String>>((String value) {
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
                 padding: EdgeInsets.only(top: 4, left: 56),
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
                           value: dropdownValueCountry,
                           isExpanded: true,
                           icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                           iconSize: 30,
                           underline: SizedBox(),
                           onChanged: (String newValue) {
                             setState(() {
                               //_selectedColor = Colors.white;
                               dropdownValueCountry = newValue;
                             });
                           },
                           items: countryList.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style: TextStyle(color: Colors.white),),
                             );
                           }).toList())



                   ),
                 ),
               ),





                   /*  Padding(
                       padding: EdgeInsets.only(left: 40, right: 40),
                       child: Container(
                         child: TextFormField(
                           controller: textControllerPhoneNo,
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


                     )*/


                   ],


                 ),


               ),




               Container(
                 width: double.infinity,
                 padding: EdgeInsets.only(top: 4, left: 56),
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
                 padding: EdgeInsets.only(top: 4, left: 56),
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
                 padding: EdgeInsets.only(top: 4, left: 56),
                 child: Text(
                   'User Type',
                   style: TextStyle(
                       fontSize: 16,
                       color: MyColor.greyTextColor,
                       decoration: TextDecoration.none,
                       fontFamily: 'GilroySemibold'),
                 ),
               ),

             SizedBox(height: 5),
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


               SizedBox(height: 7),
               GestureDetector(
                 onTap: (){


                   refineSearch('');



                    









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




               SizedBox(height: 10,),
               SizedBox(height: 8),
               Container(
                   margin: EdgeInsets.only(right: 15),
                   child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                       childAspectRatio: 2/2.5/*MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/4)*/
                   ),
                       itemCount: searchList2.length,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context,int position)
                       {
                         return GestureDetector(
                           onTap: (){
                         if(loginToken=='notLogin')
                           {
                             showLogInDialog(context);
                           }
                         else
                           {
                             Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewItemScreen(searchList2[position]['intProductId'].toString())));
                           }
                           },

                           child: Container(
                             margin: EdgeInsets.only(left: 20),
                             child: Column(
                               children: <Widget>[
                                 Container(
                                   height:60,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white,
                                     border: Border.all(color: MyColor.themeColor,width: 2)
                                   ),

                                   child: Center(

                                       child:  Padding(
                                         padding: EdgeInsets.all(5),
                                         child: ClipRRect(
                                           borderRadius: BorderRadius.circular(8.0),
                                           child: FadeInImage.assetNetwork(
                                             height: 45.0,
                                             width: 55.0,
                                             placeholder: 'images/launcher_icon.png',
                                             image: AppConstants.imageBaseUrl+searchList2[position]['ImgPath'],
                                           ),
                                         ),
                                       )

                                   ),
                                 ),


                                 SizedBox(height:5),
                                 searchList2[position]['vchTitle']!=null?
                                 Text(
                                   searchList2[position]['vchTitle'],
                                   style: TextStyle(fontSize: 12,color: searchList2[position]['vchUserType']=='buyer'?MyColor.noInternetColor:Colors.teal,fontFamily: 'GilroySemibold'),
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                 ):
                                 Text('NA')


                               ],



                             ),
                           ),
                         );

                       })


               ),


             ],



           )



         ],


       ),



     ),



   );
  }


  Future<Map<String, dynamic>> refineSearch(String searchText) async {
    APIDialog.showAlertDialog(context, 'Searching...');

    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/RefineSearchedPosts?Type=da&Searchtext='+searchText+'&Keyword='+textControllerKeyword.text+'&Category='+categoryDropDown+'&Country='+'india'+'&State='+textControllerState.text+'&City='+textControllerCity.text+'&UserType=''&PostingType=',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();

      setState(() {
        if(searchList2.length!=0)
          {
            searchList2.clear();
          }
        searchList2=fetchResponse['Response']['SearchPosts'];
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });


      if(searchList2.length==0)
        {


          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ErrorDialog('No Results found !!',context),
          );
        }






      print(fetchResponse);

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
  Future<Map<String, dynamic>> getCountryList() async {


    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/Country',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);

     setState(() {
       countryData=fetchResponse['Response']['Country'];
       if(countryData.length!=0)
       {
         countryList.add('Select Country');
         for(int i=0;i<countryData.length;i++)
         {
           countryList.add(countryData[i]['vchCountryName']);
         }
       }
       else
       {
       }
     });
      
      
      
      
      
      print(fetchResponse);

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
    }
  }

  Future<Map<String, dynamic>> keySearch() async {
    APIDialog.showAlertDialog(context, 'Searching...');

    print(searchText+'efef');
    String message = '';
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/GetSearchPost?Searchtext='+searchText+'&Type='+type
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();

      if(searchList2.length!=0)
      {
        searchList2.clear();

      }
      setState(() {
        searchList2=fetchResponse['Response']['SearchPosts'];
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      if(searchList2.length==0)
      {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ErrorDialog('No Results found !!!',context),
        );      }
      print(fetchResponse);

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }







  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   checkInternetAPIcall();
    textControllerCity.text='';
    textControllerState.text='';
    textControllerKeyword.text='';
    Future.delayed(Duration.zero,(){
      if(key!='')
        {
          this.keySearch();
        }
    });


  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {

      getCountryList();
      getCategoryList();

    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
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
        categoryData=fetchResponse['Response']['Products'];
        if(categoryData.length!=0)
        {
          categoryList.add('Select Category');
          for(int i=0;i<categoryData.length;i++)
          {
            categoryList.add(categoryData[i]['vchProductName']);
          }
        }
      });

      print(fetchResponse);

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
    }
  }
  showLogInDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes,Login"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, CupertinoPageRoute(builder:(context)=>LoginScreen()));


      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log in"),
      content: Text("To view items you need to login !"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}





