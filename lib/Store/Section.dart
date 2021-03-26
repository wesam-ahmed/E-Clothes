import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Section extends StatefulWidget {
  @override
  _SectionState createState() => _SectionState();
}
class _SectionState extends State<Section>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(

      child:
      Center(child: Column(
        children: [
          TextButton(
              child: Text("Men",style: TextStyle(fontSize: 50),),
              onPressed:() {
                Route route = MaterialPageRoute(builder: (_) => StoreHome());
                Navigator.pushReplacement(context, route);
                SectionKey.section="Men";
              }
          ),
          Divider(height: 5,),
          TextButton(
              child: Text("Woman",style: TextStyle(fontSize: 50),),
              onPressed:() {
                Route route = MaterialPageRoute(builder: (_) => StoreHome());
                Navigator.pushReplacement(context, route);
                SectionKey.section="Woman";
              }
          )
        ],
      ),

      ) ,
    );

  }

}