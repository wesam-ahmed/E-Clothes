import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderDetails.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
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

           /*border: Border.all(color: primaryColor,width: 5)*/
            borderRadius: BorderRadius.circular(15),
        boxShadow: [
        BoxShadow(
        color: Colors.green.shade200,
        offset: const Offset(
          5.0,
          5.0,
        ), //Offset
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ), //BoxShadow
      BoxShadow(
        color: Colors.white,
        offset: const Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ),

           /* gradient: new LinearGradient(
              colors: [Colors.white,Colors.grey],
              begin:const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            )*/
        ],
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
  Widget sourceOrderInfo(ItemModel model, BuildContext context,
      {Color background})
  {
    width =  MediaQuery.of(context).size.width;

    return  InkWell(

      child: Container(
        color: Colors.grey[100],
        child: Padding
          (padding: EdgeInsets.all(6.0),
          child: Container(
            height: 170.0,
            width: width,
            decoration: BoxDecoration( //                    <-- BoxDecoration
              border: Border(bottom: BorderSide(color: Colors.grey.shade400),),
            ),
            child: Row(
              children: [
                Image.network(model.thumbnailUrl,width: 180.0,),
                SizedBox(width: 10.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0,),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(model.title,style: TextStyle(color: Colors.black,fontSize: 14.0),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:5.0,),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(model.shortInfo,style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Total Price:",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " EGP ",
                                      style: TextStyle(color: Colors.black,fontSize: 16.0),
                                    ),
                                    Text(
                                      (model.price ).toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Flexible(
                        child: Container(),
                      ),


                    ],

                  ),

                ),

              ],
            ),


          ),
        ),

      ),

    );
  }
}
