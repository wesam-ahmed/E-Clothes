
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/myReceivedOrders.dart';
import 'package:e_shop/Store/Section.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/orderNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
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
              title: Text("My Orders",style: TextStyle(color: Colors.white),),
              actions: [
                IconButton(
                  icon: Icon(Icons.car_rental_outlined,color: Colors.white,),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (c)=> MyReceivedOrders());
                    Navigator.pushReplacement(context, route);                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (c)=> Section());
                    Navigator.pushReplacement(context, route);                  },
                ),

              ],
            ),
            body: StreamBuilder(
              stream: EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.collectionOrders).where("shippingstate",isNotEqualTo: "Received").snapshots(),

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
