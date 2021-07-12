
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class PaymentPage extends StatefulWidget {
  final String addressId;
  final double totalAmount;
  final ListOfOrder listOfOrder;



  PaymentPage({Key key, this.addressId, this.totalAmount,this.listOfOrder}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}
 Random rn = new Random();
class _PaymentPageState extends State<PaymentPage> {
  int OrderNumber =rn.nextInt(100)+10+DateTime.now().millisecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    print(OrderNumber);
    return Material(
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.white,Colors.grey],
              begin:const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Padding(
                padding:EdgeInsets.all(8.0),
                child: Image.asset("images/cash.png"),

              ),
              SizedBox(height: 10.0,),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.black87,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.deepOrange,
                onPressed: ()
                 {
                   addOrderDetails();
                  },
                child: Text("place Order",style: TextStyle(fontSize: 30.0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  addOrderDetails(){
    writeOrderDetalisForUser({
      EcommerceApp.addressID:widget.addressId,
      EcommerceApp.totalAmount:widget.totalAmount,
      "orderBy":EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID:FieldValue.arrayUnion(ListOfOrder.idlist),
      //EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      EcommerceApp.paymentDetails:"Cash on Delivery",
      EcommerceApp.orderTime:DateTime.now().minute.toString(),
      EcommerceApp.isSuccess:true,
    });
    writeOrderDetalisForAdmin({
      EcommerceApp.addressID:widget.addressId,
      EcommerceApp.totalAmount:widget.totalAmount,
      "orderBy":EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID:FieldValue.arrayUnion(ListOfOrder.idlist),
      // EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      EcommerceApp.paymentDetails:"Cash on Delivery",
      EcommerceApp.orderTime:DateTime.now().minute.toString(),
      EcommerceApp.isSuccess:true,
      "shippingstate":"Pending",
    }).whenComplete(() => {
      emptyCartNow()
    });

  }
  emptyCartNow(){
    ListOfOrder.idlist.clear();
    EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,["garbageValue"]);
    List tempList=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);

    FirebaseFirestore.instance.collection("users")
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .update({
      EcommerceApp.userCartList: tempList,
    }).then((value)
    {
      EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,tempList );
      Provider.of<CartItemCounter>(context,listen:false).displayResult() ;
      Fluttertoast.showToast(msg: "congratulations,Your order has been placed successfuly");
      Route route=MaterialPageRoute(builder: (c)=>SplashScreen());
      Navigator.pushReplacement(context, route);
    });

  }
  Future writeOrderDetalisForUser(Map<String,dynamic>data)async{
    await EcommerceApp.firestore.collection(EcommerceApp.collectionUser).
    doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)).
    collection(EcommerceApp.collectionOrders)
        .doc(OrderNumber.toString()).
    set(data);
  }
  Future writeOrderDetalisForAdmin(Map<String,dynamic>data)async{
    await EcommerceApp.firestore.collection(EcommerceApp.collectionOrders)
        .doc(OrderNumber.toString()).
    set(data);
  }
}
