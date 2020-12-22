import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
   return AppBar(
     iconTheme: IconThemeData(
       color: Colors.white,
     ),
     flexibleSpace: Container(
       decoration: new BoxDecoration(
           gradient: new LinearGradient(
             colors: [Colors.white,Colors.grey],
             begin:const FractionalOffset(0.0, 0.0),
             end: const FractionalOffset(1.0, 0.0),
             stops: [0.0,1.0],
             tileMode: TileMode.clamp,
           )
       ),
     ),
     centerTitle: true,
     title: Text("e-Shop",style: TextStyle(fontSize: 55.0,color: Colors.black,fontFamily: "Signatra"),),
     bottom: bottom,
     actions: [
       Stack(
         children: [
           IconButton(
             icon: Icon(Icons.shopping_cart,color: Colors.black,),
             onPressed: (){
               Route route = MaterialPageRoute(builder: (C) => CartPage());
               Navigator.pushReplacement(context, route);
             },),
           Positioned(
               child: Stack(
                 children: [
                   Icon(
                     Icons.brightness_1,size: 20,color: Colors.grey,
                   ),
                   Positioned(
                       top: 3,
                       bottom: 4,
                       left: 4,
                       child:Consumer<CartItemCounter>(
                         builder: (context,counter,_)
                         {
                           return Text(
                             counter.count.toString(),
                             style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500) ,
                           );
                         },
                       )
                   )
                 ],
               )
           )
         ],
       )
     ],
   );
  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
