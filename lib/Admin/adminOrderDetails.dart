import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/AdminOrderCardSize.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/orderCard.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/orderCardsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:im_stepper/stepper.dart';


String getOrderId="";
String getOrderBy="";
class AdminOrderDetails extends StatelessWidget {

  final String orderId;
  final String orderBy;
  final String addressID;
  final String section ;
  final String category ;
  final String shippingstate;
  List IDs=[];
  int activeStep = 2;


  getData(){
    IDs.clear();
    EcommerceApp.firestore
        .collection("orders")
        .doc(orderId).get().then((value) {
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

  AdminOrderDetails({Key key,this.orderId,this.orderBy,this.addressID,this.section,this.category,this.shippingstate}):super(key: key);
  @override
  Widget build(BuildContext context) {
    getOrderId = orderId;
    getOrderBy =orderBy;
    getData();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future:EcommerceApp.firestore.collection(EcommerceApp.collectionOrders).doc(orderId).get()
            ,builder: (c,snapshot)
          {
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
              return snapshot.hasData ?
              Container(
                child: Column(
                  children: [
                    AdminStatusBanner(status: dataMap[EcommerceApp.isSuccess],),
                    SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.all(4)
                      ,child: Text(
                          "OrderId: "+getOrderId
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
                          "Shipping State: "+shippingstate.toString()
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
                      height: 450,
                      child: ListView.builder(
                        itemCount: IDs.length,
                        itemBuilder: (c,index) {
                          return FutureBuilder(
                            future: EcommerceApp.firestore
                                .collection("items").where("idItem", isEqualTo: IDs[index]["id"]).where("sellerid",isEqualTo: EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminId).toString()).get(),
                            builder: (c, dataSnapshot) {
                              return dataSnapshot.hasData ?
                              AdminOrderCardSize(
                                itemCount: dataSnapshot.data.docs.length,
                                data: dataSnapshot.data.docs,
                                ordercolor: IDs[index]["color"].toString(),
                                ordersize: IDs[index]["size"].toString(),
                              )
                                  : Center(child: circularProgress(),);
                            },
                          );
                        }
                      ),
                    ),
                    Divider(height: 2,),
                    FutureBuilder<DocumentSnapshot>(
                      future:EcommerceApp.firestore
                          .collection(EcommerceApp.collectionUser)
                          .doc(orderBy)
                          .collection(EcommerceApp.subCollectionAddress)
                          .doc(addressID).get(),
                      builder: (c,snap) {
                        return snap.hasData
                            ?AdminShippingDetails(model: AddressModel.fromJson(snap.data.data()),)
                            :Center(child: circularProgress(),);
                      },
                    )
                  ],
                ),
              )
                  :Center(child: circularProgress(),);
            },
          )
        ),
      ),
    );
  }
}

class AdminStatusBanner extends StatelessWidget {
  final bool status;

  AdminStatusBanner({Key key,this.status}):super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;

    status ? iconData =Icons.done :iconData =Icons.cancel;
    status ? msg ="Successful" :msg = "unSuccessful";

    return Container(
      decoration: new BoxDecoration(
        color: primaryColor,
         /* gradient: new LinearGradient(
            colors: [Colors.white,Colors.grey],
            begin:const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          )*/
      ),
      height:60.0,
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
            "Order Shipped" + msg,
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

class AdminShippingDetails extends StatelessWidget {

  final AddressModel model;

  AdminShippingDetails({Key key,this.model}):super(key: key);

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
            style: TextStyle(color: primaryColor,fontWeight:FontWeight.bold),
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
                    KeyText(msg: "Postal Code",),
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
              onTap: () {
                confirmParcelShifted(context, getOrderId,getOrderBy);
              }
              ,
              child: Container(
                decoration: new BoxDecoration(
                  color: primaryColor,
                ),
                width: MediaQuery.of(context).size.width -40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    " Confirm || Parcel Shifted ",
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
  confirmParcelShifted(BuildContext context ,String getOrderId,String getOrderBy)
  {
    print(getOrderBy);
    print(getOrderId);
    final MyorderRef = EcommerceApp.firestore.collection("orders");
   MyorderRef.doc(getOrderId).update({
     "shippingstate":"Shipped",
   });
   final UserOrderRef = EcommerceApp.firestore.collection("users").doc(getOrderBy).collection("orders");
   UserOrderRef.doc(getOrderId).update({
     "shippingstate":"Shipped",
   });
   /* Route route = MaterialPageRoute(builder: (c)=> UploadPage());
    Navigator.pushReplacement(context, route);*/
    Fluttertoast.showToast(msg: "Product has been Shifted.");


  }

}

