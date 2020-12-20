import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
        leading: new IconButton(
          //Customs menu icon color (osama)
          icon: new Icon(Icons.menu,color: Colors.black,),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
          title: Text("e-Shop",style: TextStyle(fontSize: 55.0,color: Colors.black,fontFamily: "Signatra"),),
          centerTitle: true,
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
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}



Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}



Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}



void checkItemInCart(String productID, BuildContext context)
{
}
