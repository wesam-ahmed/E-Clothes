import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Widgets/constance.dart';
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
       color: Colors.white,
     ),
     centerTitle: true,
     title: Text("e-Shop",style: TextStyle(fontSize: 20.0,color: primaryColor,),),
     bottom: bottom,
     actions: [
       Stack(
         children: [
           IconButton(
             icon: Icon(Icons.shopping_cart,color: primaryColor,),
             onPressed: (){
               Route route = MaterialPageRoute(builder: (C) => CartPage());
               Navigator.pushReplacement(context, route);
             },),
           Positioned(
               child: Stack(
                 children: [
                   Icon(
                     Icons.brightness_1,size: 20,color: Colors.red,
                   ),
                   Positioned(
                       top: 3,
                       bottom: 4,
                       left: 4,
                       child:Consumer<CartItemCounter>(
                         builder: (context,counter,_)
                         {
                           return Text(
                             (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1).toString(),
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
