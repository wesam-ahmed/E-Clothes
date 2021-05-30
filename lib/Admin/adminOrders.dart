import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Admin/adminProducts.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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
        body: CustomScrollView(
          slivers: [
            // SliverPersistentHeader(floating: true, delegate: SearchBoxDelegate()),
            SliverToBoxAdapter(
              child:Column(children:
              [
                SizedBox(height: 20,),
                Text("My Products",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),),
                Divider(height: 10,)
              ],),
            ),
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
  return InkWell(
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
  );
}


