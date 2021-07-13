
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/orderCard.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/orderCardsize.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';



String getOrderId="";
class OrderDetails extends StatelessWidget {
  final String orderID;
  OrderDetails({Key key,this.orderID}):super(key: key);
  List IDs=[];
  int activeStep = 2;

  getData(){
    IDs.clear();
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .doc(orderID).get().then((value) {
      value["productIDs"].forEach((val){
        var map={
          "color":val["color"],
          "size":val["size"],
          "id":val["id"]
        };
        IDs.add(map);

        print(IDs);
      });
    });
    print(IDs);
  }
  @override
  Widget build(BuildContext context) {
    getOrderId=orderID;
    getData();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future:EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                .collection(EcommerceApp.collectionOrders)
                .doc(orderID).get(),

            builder: (c, snapshot){
              Map dataMap;
              if(snapshot.hasData)
              {
                dataMap =snapshot.data.data();

                if(dataMap["shippingstate"].toString()=="Pending"){
                  activeStep = 0;
                }
                else if(dataMap["shippingstate"].toString()=="Shipped"){
                  activeStep = 1;
                }
              else if(dataMap["shippingstate"].toString()=="Received"){
                activeStep = 2;
               };
              }
              return snapshot.hasData
                  ?Container(
                child: Column(
                  children: [
                    StatusBanner(status: dataMap[EcommerceApp.isSuccess],),
                    SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.all(4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "EG"+dataMap[EcommerceApp.totalAmount].toString(),
                          style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4)
                      ,child: Text(
                          "OrderId: "+orderID

                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4)
                      ,child: Text(
                        "Order at: "+ DateFormat("dd MMMM,yyyy - hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4)
                      ,child: Text(
                          "Shipping State: "+dataMap["shippingstate"].toString()
                      ),
                    ),
                    IconStepper(
    icons: [
    Icon(Icons.store_mall_directory_rounded,color: Colors.white,),
    Icon(Icons.motorcycle_rounded,color: Colors.white),
    Icon(Icons.home,color: Colors.white),
    ],
    activeStep: activeStep,
      scrollingDisabled: true,
      enableStepTapping: false,
      activeStepColor: primaryColor,
      lineColor: Colors.grey.shade400,
      activeStepBorderColor:Colors.grey.shade400,
      enableNextPreviousButtons: false,
      stepColor: Colors.grey.shade400,
      stepRadius: 20,


    ),
                    Divider(height: 2,),
                    Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: IDs.length,
                            itemBuilder: (c,index){
                              return  FutureBuilder(
                                future: EcommerceApp.firestore.collection("items").where("idItem",isEqualTo: IDs[index]["id"]).get(),
                                builder: (c,snap){
                                  return snap.hasData ? OrderCardSize(
                                    itemCount: 1,
                                    data: snap.data.docs,
                                    ordercolor: IDs[index]["color"].toString(),
                                    ordersize: IDs[index]["size"].toString(),
                                  )
                                      :Center(child: circularProgress(),);
                                },
                              );
                            }
                        )),

                    Divider(height: 2,),
                    FutureBuilder<DocumentSnapshot>(
                      future:EcommerceApp.firestore
                          .collection(EcommerceApp.collectionUser)
                          .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                          .collection(EcommerceApp.subCollectionAddress)
                          .doc(dataMap[EcommerceApp.addressID]).get(),
                      builder: (c,snap) {
                        return snap.hasData
                            ?ShippingDetails(model: AddressModel.fromJson(snap.data.data()),)
                            :Center(child: circularProgress(),);
                      },
                    )
                  ],
                ),
              )
                  :Center(child: circularProgress(),);
            },
          ),
        ),
      ),
    );
  }
}

class StatusBanner extends StatelessWidget {
  final bool status;
  StatusBanner({Key key,this.status}):super(key: key);
  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;

    status ? iconData =Icons.done :iconData =Icons.cancel;
    status ? msg ="Successful" :msg = "unSuccessful";

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.white,Colors.grey],
            begin:const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          )
      ),
      height:40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              SystemNavigator.pop();
            },
            child: Container(
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,

              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Text(
            "Order Placed" + msg,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5.0,),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.grey,
            child: Icon(
              iconData,
              color:Colors.white ,
              size: 14.0,
            ),


          ),
        ],
      ),
    );
  }
}

class PaymentDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class ShippingDetails extends StatelessWidget {
  final AddressModel model;
  ShippingDetails({Key key,this.model}):super(key: key);

  @override
  Widget build(BuildContext context)
  {
    double screenWidth =MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0,),
          child: Text(
            "Shipment Details:",
            style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 90.0,vertical: 5.0),
          width: screenWidth,
          child: Table(
            children: [
              TableRow(
                  children: [
                    KeyText(msg: "Name",),
                    Text(model.name),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "Phone Number",),
                    Text(model.phoneNumber),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "Flat Number",),
                    Text(model.flatNumber),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "City",),
                    Text(model.city),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "State",),
                    Text(model.state),
                  ]
              ),
              TableRow(
                  children: [
                    KeyText(msg: "Pin Code",),
                    Text(model.pincode),
                  ]
              ),
            ],

          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: (){
                confirmeduserOrderReceived(context,getOrderId);
              }
              ,
              child: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [Colors.white,Colors.grey],
                      begin:const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width -40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    " Confirmed || Items Received ",
                    style: TextStyle(color: Colors.white,fontSize: 15.0,),

                  ),

                ),
              ),

            ),


          ),


        ),
      ],
    );
  }
  confirmeduserOrderReceived(BuildContext context ,String getOrderId) {
    final order =EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences
        .getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders);
    order.doc(getOrderId).update({"shippingstate":"Received"});

    getOrderId ="";
    /*Route route = MaterialPageRoute(builder: (c)=> StoreHome());
    Navigator.pushReplacement(context, route);*/
    Fluttertoast.showToast(msg: "Order has been Received");


  }

}


