import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storeS.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
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


    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 200),
          child: Center(
            child: Column(
              children: [
                Divider(height: 5,),
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
                Divider(height: 5,),
              ],
            ),

          ) ,
        ) ,
      )

      ,);


  }

}