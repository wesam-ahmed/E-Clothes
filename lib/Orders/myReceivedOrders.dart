
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/orderNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyReceivedOrders extends StatefulWidget {
  @override
  _MyReceivedOrdersState createState() => _MyReceivedOrdersState();
}

class _MyReceivedOrdersState extends State<MyReceivedOrders> {
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
  }
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
              title: Text("My Received Orders",style: TextStyle(color: Colors.white),),
              actions: [
                IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (c)=> MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ],
            ),
            body: StreamBuilder(
              stream: EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.collectionOrders).where("shippingstate",isEqualTo: "Received").snapshots(),

              builder: (c,snapshot){
                return snapshot.hasData
                    ?ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (c,index){
                    return OrderNumberCard(orderId: snapshot.data.docs[index].id,);

                  },
                )
                    : Center(child: circularProgress(),);
              },
            ),
          ),
        ));
  }
}
