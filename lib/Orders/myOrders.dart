
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/storehome.dart';
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
              iconTheme: IconThemeData(color: Colors.green),
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
                  .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.collectionOrders).snapshots(),

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
