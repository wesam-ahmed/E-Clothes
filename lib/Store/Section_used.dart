import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Section.dart';


class SectionUsed extends StatefulWidget {
  @override
  _SectionUsedState createState() => _SectionUsedState();

}
class _SectionUsedState extends State<SectionUsed>{
  Future<bool> _onWillPop() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Section()));
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
                        SectionKey.section="Men";
                        SectionKey.isUsed=true;

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
                        SectionKey.section="Woman";
                        SectionKey.isUsed=true;

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
                        SectionKey.section="Kids";
                        SectionKey.isUsed=true;

                      },
                    ),
                  ),

                ],
              ),

            ),
          ) ,
        ) ,
      )

      ,);


  }

}