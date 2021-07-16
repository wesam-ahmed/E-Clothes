
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/adminorderNumberCard.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/orderNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';
import 'adminOrderCard.dart';

class AdminShippedOrders extends StatefulWidget {
  @override
  _AdminShiftshippedOrdersState createState() => _AdminShiftshippedOrdersState();
}

class _AdminShiftshippedOrdersState extends State<AdminShippedOrders> {
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => AdminShiftOrders()));
  }
  String dropdownValue_Section ;
  String dropdownValue_Category ;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _backStore,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text("My Shipped Orders",style: TextStyle(color: Colors.white),),
              actions: [
                IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>AdminShiftOrders()));
                  },
                ),
              ],
            ),
            body: StreamBuilder(
              stream: EcommerceApp.firestore
                  .collection("orders").where("shippingstate",isNotEqualTo: "Pending").snapshots(),

              builder: (c,snapshot){
                return snapshot.hasData
                    ?ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (c,index){
                    return AdminOrderNumberCard(
                      orderId: snapshot.data.docs[index].id,
                      orderBy: snapshot.data.docs[index].data()["orderBy"],
                      addressID: snapshot.data.docs[index].data()["addressID"],
                      category: dropdownValue_Category,
                      section:dropdownValue_Section ,
                      shippingstate: snapshot.data.docs[index].data()["shippingstate"],
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