import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderDetails.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';

int counter=0;
class AdminOrderNumberCard extends StatelessWidget {
final String orderId;
final String orderBy;
final String addressID;
final String section ;
final String category ;

AdminOrderNumberCard({Key key,this.orderId,this.orderBy,this.category,this.section,this.addressID}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (c)=>AdminOrderDetails(orderId: orderId,section: section,addressID: addressID,orderBy: orderBy,category: category,)));
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



