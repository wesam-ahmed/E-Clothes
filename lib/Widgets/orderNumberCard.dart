import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'constance.dart';

int counter=0;
class OrderNumberCard extends StatelessWidget {
final String orderId;
OrderNumberCard({Key key,this.orderId}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetails(orderID: orderId,)));
      },
      child: Container(
        decoration: new BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        child: Text("Order Number: $orderId",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}



