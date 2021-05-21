import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}
 List IDs=[];
getData(){
  IDs.clear();
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection(EcommerceApp.collectionOrders).getDocuments().then((value) {
        value.documents.forEach((element) {
          element["productIDs"].forEach((val){
            var map={"doc":element.documentID,"itemID":val["id"]};
            IDs.add(map);
            print(val["id"]);
          });
        });
  });
print(IDs);
}
class _MyOrdersState extends State<MyOrders> {
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return WillPopScope(
      onWillPop: _backStore,
      child: SafeArea(
      child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
        centerTitle: true,
        title: Text("My Orders",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,),
            onPressed: (){
              SystemNavigator.pop();
            },
          ),
        ],
      ),
        body: StreamBuilder(
          stream: EcommerceApp.firestore
              .collection(EcommerceApp.collectionUser)
              .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
              .collection(EcommerceApp.collectionOrders).snapshots(),

          builder: (c,snapshot){
            return snapshot.hasData
                ?ListView.builder(
              itemCount: IDs.length,
              itemBuilder: (c,index){
                return FutureBuilder(
                  future:Firestore.instance.collection("items")
                      .where("idItem",isEqualTo:IDs[index]["itemID"]).getDocuments(),
                  builder: (c,snap){
                    print("*************${IDs[index]["itemID"]}****${IDs[index]["doc"]}");
                    return snap.hasData ? OrderCard(
                      itemCount: snap.data.documents.length,
                      data: snap.data.documents,
                      orderId: IDs[index]["doc"],
                    )
                        :Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    ));
  }
}
