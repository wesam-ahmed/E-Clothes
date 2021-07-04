import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Admin/adminProducts.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import 'adminShiftOrders.dart';


class AdminOrders extends StatefulWidget{
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}
class _AdminOrdersState extends State<AdminOrders>{
  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UploadPage()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: _backStore,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon:Icon(Icons.border_color,color:primaryColor,) ,
            onPressed: (){
              Route route = MaterialPageRoute(builder: (C) => AdminShiftOrders());
              Navigator.pushReplacement(context, route);
            },

          ),
          backgroundColor: Colors.white,
          title: Text(
            EcommerceApp.appName,
            style: TextStyle(
              fontSize: 20.0,
              color: primaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                TextButton(
                    child: Text("Logout",style: TextStyle(color: primaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Route route = MaterialPageRoute(builder: (C) => SplashScreen());
                      Navigator.pushReplacement(context, route);
                    }
                ),
              ],
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // SliverPersistentHeader(floating: true, delegate: SearchBoxDelegate()),
           /* SliverToBoxAdapter(
              child:Column(children:
              [
                SizedBox(height: 20,),
                Text("My Products",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),),
                Divider(height: 10,)
              ],),
            ),*/
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .where("sellerid",
                  isEqualTo: EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminId).toString())
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(
                    child: circularProgress(),
                  ),
                )
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) =>
                      StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    ItemModel model = ItemModel.fromJson(
                        dataSnapshot
                            .data.docs[index].data());
                    return sourceInfoProducts(model, context);
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              },
            ),
          ],
        ),

      ),

    );
  }

}
Widget sourceInfoProducts(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return  InkWell(

    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0.0, 5.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],),
        width: MediaQuery.of(context).size.width*.4,
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width*.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: Image.network(
                      model.thumbnailUrl,
                      fit: BoxFit.fill,
                    ),
                  ),


                )),
            SizedBox(height: 10,),
            CustomText(text: model.title,alignment: Alignment.bottomLeft,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text:model.price.toString()+" \E\G\P",alignment: Alignment.bottomLeft ,color: primaryColor,),



              ],
            ),
            SizedBox(height: 10,),
           Container(
              height: 40,
              width: 10,
              child: CustomButton(onPress: (){
                Route route =
                MaterialPageRoute(builder: (c) => AdminProducts(itemModel: model));
                Navigator.pushReplacement(context, route);
              },
                text: "Edit Item",
              ),
            ),

          ],
        ),

      ),
    ),
  );/*InkWell(
    onTap: () {
      Route route =
      MaterialPageRoute(builder: (c) => AdminProducts(itemModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(

        height: 250,
        width: width,
        child: Column(
          children: [
            Image.network(model.thumbnailUrl, width: 140.0, height: 140.0,),
            SizedBox(width: 4.0,),
            Expanded(child: Column(children: [
              Text(model.title, style: TextStyle(color: Colors.black, fontSize: 14.0),),
              Text(model.shortInfo, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
              Text(model.price.toString(), style: TextStyle(color: Colors.black54, fontSize: 12.0),),
              Align(
                alignment: Alignment.centerRight,

              ),
            ],),),


          ],
        ),
      ),
    ),
  );*/
}

