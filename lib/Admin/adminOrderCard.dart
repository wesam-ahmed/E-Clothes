import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderDetails.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/orderCard.dart';
import 'package:flutter/material.dart';


int counter=0;
class AdminOrderCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot>data;
  final String orderId;
  final String addressID;
  final String orderBy;
  final String section ;
  final String category ;

  AdminOrderCard({Key key,this.itemCount,this.data,this.orderId,this.addressID,this.orderBy, this.section, this.category}) :super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>AdminOrderDetails(orderId: orderId,addressID: addressID,orderBy: orderBy,section:section,category:category)));
      },
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
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount*190.0,
        child: ListView.builder(itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c,index){
            ItemModel model=ItemModel.fromJson(data[index].data());
            return sourceOrderInfo(model, context);
          },
        ),
      ),
    );
  }
}
