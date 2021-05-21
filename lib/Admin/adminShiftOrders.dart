import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderCard.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import '../Widgets/loadingWidget.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _AdminShiftOrdersState createState() => _AdminShiftOrdersState();
}
List IDs=[];
getData(){
  IDs.clear();
  EcommerceApp.firestore
      .collection("orders").getDocuments().then((value) {
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

class _AdminShiftOrdersState extends State<AdminShiftOrders> {
  Future<bool> _backAdmin()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPage()));
  }

  String dropdownValue_Section ;
  String dropdownValue_Category ;
  @override
  Widget build(BuildContext context) {
    getData();
    return WillPopScope(
      onWillPop: _backAdmin,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPage()));
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child:StreamBuilder(
                stream: EcommerceApp.firestore.collection("orders").snapshots(),

                builder: (c,snapshot){

                  return snapshot.hasData
                      ?ListView.builder(
                    itemCount: IDs.length,
                    itemBuilder: (c,index){
                      return FutureBuilder(
                        future:Firestore.instance.
                        collection("items").where("idItem",
                            isEqualTo: IDs[index]["itemID"]).where("seller",isEqualTo: EcommerceApp.collectionAdminId.toString()).getDocuments(),


                        builder: (c,snap){
                          print("*************${IDs[index]["itemID"]}****${IDs[index]["doc"]}");

                          return snap.hasData ?
                          AdminOrderCard(
                            itemCount: snap.data.documents.length,
                            data: snap.data.documents,
                            orderId: IDs[index]["doc"],
                            orderBy: snapshot.data.documents[index].data["orderBy"],
                            addressID: snapshot.data.documents[index].data["addressID"],
                            category: dropdownValue_Category,
                            section:dropdownValue_Section ,
                          )
                              :Center(child: circularProgress(),);


                        },
                      );
                    },
                  )
                      : Center(child: circularProgress(),);
                },
              ),
              )
            ],
          ),
        )
      ),
    ),
    );
  }
}
