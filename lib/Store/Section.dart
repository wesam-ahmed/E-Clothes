import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/Section_used.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Section extends StatefulWidget {
  @override
  _SectionState createState() => _SectionState();

}
class _SectionState extends State<Section>{
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    double h=200  ;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30,left: 15,right: 15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Image(
                        height: h,
                        width: 400,
                        fit: BoxFit.fill,
                        image:AssetImage("images/MEN.jpg") ,
                      ),
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.isUsed=false;
                        SectionKey.section="Men";
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30,left: 15,right: 15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Image(
                        height: h,
                        width: 400,
                        fit: BoxFit.fill,
                        image:AssetImage("images/WOMAN.jpg") ,
                      ),
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.isUsed=false;
                        SectionKey.section="Woman";
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30,left: 15,right: 15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Image(
                        height: h,
                        width: 400,
                        fit: BoxFit.fill,

                        image:AssetImage("images/KIDS.jpg") ,
                      ),
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.isUsed=false;
                        SectionKey.section="Kids";
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Image(
                        height: h,
                        width: 400,
                        fit: BoxFit.fill,

                        image:AssetImage("images/USED.jpg") ,
                      ),
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (_) => SectionUsed());
                        Navigator.pushReplacement(context, route);
                        SectionKey.isUsed=true;
                        SectionKey.section="Used";
                      },
                    ),
                  )

                  /*Divider(height: 5,),
                  TextButton(style: TextButton.styleFrom(
              primary: primaryColor,
                onSurface: Colors.black87,
              ),
                      child: Text("Men",style: TextStyle(fontSize: 50),),
                      onPressed:() {
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.section="Men";
                      }
                  ),
                  Divider(height: 5,),
                   SizedBox(height: 20,),
                  Divider(height: 5,),
                   TextButton(style: TextButton.styleFrom(
                    primary: primaryColor,
                    onSurface: Colors.grey,
                  ),
                      child: Text("Woman",style: TextStyle(fontSize: 50),),
                      onPressed:() {
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.section="Woman";
                      }
                  ),
                  Divider(height: 5,),
                  SizedBox(height: 20,),
                  Divider(height: 5,),
                  TextButton(style: TextButton.styleFrom(
                    primary:primaryColor,
                    onSurface: Colors.grey,
                  ),
                      child: Text("Kids",style: TextStyle(fontSize: 50),),
                      onPressed:() {
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.section="Kids";
                      }
                  ),
                  Divider(height: 5,),
                  SizedBox(height: 20,),
                  Divider(height: 5,),
                  TextButton(style: TextButton.styleFrom(
                    primary: primaryColor,
                    onSurface: Colors.grey,
                  ),
                      child: Text("Used",style: TextStyle(fontSize: 50),),
                      onPressed:() {
                        Route route = MaterialPageRoute(builder: (_) => StoreHome());
                        Navigator.pushReplacement(context, route);
                        SectionKey.section="Used";
                      }
                  ),
                  Divider(height: 5,),*/
                ],
              ),

            ),
          ) ,
        ) ,
      )

      ,);


  }

}