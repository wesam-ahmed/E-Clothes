
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';

import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/adminorderNumberCard.dart';
import 'package:e_shop/Widgets/orderNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _AdminShiftOrdersState createState() => _AdminShiftOrdersState();
}

class _AdminShiftOrdersState extends State<AdminShiftOrders> {
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPage()));
  }
  String dropdownValue_Section ;
  String dropdownValue_Category ;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backAdmin,
      child: SafeArea(
      child: Scaffold(
        appBar: AppBar(

          iconTheme: IconThemeData(color: primaryColor),
          backgroundColor: Colors.white,
          title: Text(
            "My Orders",
            style: TextStyle(
              fontSize: 20.0,
              color: primaryColor,
            ),
          ),
          centerTitle: true,

        ),
        body: Container(
          child: Column(
            children: [
              /* Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    hint: dropdownValue_Section == null
                        ? Text('Men')
                        : Text(dropdownValue_Section),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue_Section = newValue;
                      });
                    },
                    items: <String>['Men', 'Woman', 'Kids', 'Used']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                  DropdownButton<String>(
                    hint: dropdownValue_Category == null
                        ? Text('Category')
                        : Text(dropdownValue_Category),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue_Category = newValue;
                      });
                    },
                    items: <String>['Shoes', 'Shirts', 'T-Shirt', 'Pants','Jackets']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                ],
              ),*/
              Expanded(
                child:StreamBuilder(
                stream: FirebaseFirestore.instance.collection("orders").snapshots(),

                builder: (c,snapshot){
                  return snapshot.hasData
                      ?ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (c,index){
                      return FutureBuilder<QuerySnapshot>(
                        future:FirebaseFirestore.instance.
                        collection("items").where("idItem",
                            whereIn: snapshot.data.docs[index].data()[ID])
                            .where("sellerid", isEqualTo: EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminId).toString()).get(),

                        builder: (c,snap){
                          return snap.hasData ?
                          AdminOrderCard(
                            itemCount: snap.data.docs.length,
                            data: snap.data.docs,
                            orderId: snapshot.data.docs[index].id,
                            orderBy: snapshot.data.docs[index].data()["orderBy"],
                            addressID: snapshot.data.docs[index].data()["addressID"],
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
        ));
  }
}
