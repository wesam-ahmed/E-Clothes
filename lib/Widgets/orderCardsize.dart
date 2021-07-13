import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/product_page_Rate.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';

int counter=0;
class OrderCardSize extends StatelessWidget {
final int itemCount;
final List<DocumentSnapshot>data;
final String orderId;
final String ordercolor;
final String ordersize;
bool FirstClick=false;
OrderCardSize({Key key,this.itemCount,this.data,this.orderId,this.ordercolor,this.ordersize}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){

       //Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetails(orderID: orderId,)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
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
            ), //BoxShadow
          ],
        ),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(2.0),
        height: itemCount*190.0,
        child: ListView.builder(itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c,index){
              ItemModel model=ItemModel.fromJson(data[index].data());
              return sourceOrderInfo(model,ordercolor,ordersize, context);
            },
        ),
      ),
    );
  }
}



Widget sourceOrderInfo(ItemModel model,String ordercolor,String ordersize, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

   return  InkWell(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (c)=>ProductPageRate(itemModel:model,)));
     },
     child: Container(
       color: Colors.grey[100],
         child: Padding
         (padding: EdgeInsets.all(6.0),
            child: Container(
             height: 170.0,
             width: width,

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
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    " EGP ",
                                    style: TextStyle(color: Colors.blueGrey,fontSize: 16.0),
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
                            Row(
                              children: [Text(
                                "Color:",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),),
                                Text(ordercolor),
                              ],
                            ),
                            SizedBox(width: 3,),
                            Row(
                              children: [
                                Text(
                                  "Size:",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),),
                                Text(ordersize),
                              ],
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

  ),),),
   );
}
