
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_button.dart';
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
  int OrderNumber =rn.nextInt(100)+10;
  @override
  Widget build(BuildContext context) {
    print(OrderNumber);
    /*return Material(
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
    );*/
    return Material(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('images/truck.png',color: primaryColor,width: 300,height: 300,),
          SizedBox(height: 20,),
             Container(
               width: 250,
               height: 50,
               child: CustomButton(
                text:"place Order" ,
                color: Colors.grey.shade200,
                textColor: primaryColor,
                onPress: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirmation',style: TextStyle(color: primaryColor),),
                      content: const Text('Are you sure you can confirm the Process?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel',style: TextStyle(color: Colors.black54),),
                        ),
                        TextButton(
                          onPressed: () =>  addOrderDetails(),

                  child: const Text('OK',style: TextStyle(color: primaryColor),),
                        ),
                      ],
                    ),
                  );
                },

            ),
             ),
        ],)
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
      EcommerceApp.orderTime:DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess:true,
    });
    writeOrderDetalisForAdmin({
      EcommerceApp.addressID:widget.addressId,
      EcommerceApp.totalAmount:widget.totalAmount,
      "orderBy":EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID:FieldValue.arrayUnion(ListOfOrder.idlist),
      // EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      EcommerceApp.paymentDetails:"Cash on Delivery",
      EcommerceApp.orderTime:DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess:true,
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
        .doc(OrderNumber.toString()+data['orderTime']).
    set(data);
  }
  Future writeOrderDetalisForAdmin(Map<String,dynamic>data)async{
    await EcommerceApp.firestore.collection(EcommerceApp.collectionOrders)
        .doc(OrderNumber.toString()+data['orderTime']).
    set(data);
  }
}
