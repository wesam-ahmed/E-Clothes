import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Orders/placeOrderPayment.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Counters/changeAddresss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addAddress.dart';

class Address extends StatefulWidget
{
  final double totalAmount;
  const Address({Key key, this.totalAmount}) : super(key: key);
  @override
  _AddressState createState() => _AddressState();
}


class _AddressState extends State<Address>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor: Colors.white,
          title: Text(
            EcommerceApp.appName,
            style: TextStyle(
              fontSize: 20.0,
              color: primaryColor,
            ),
          ),
          centerTitle: true,

        ),

        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //klma
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Address",
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20,),
                      ),
                    ),
                  ),
                  //add
                  Consumer<AddressChanger>(builder: (context, address, c){
                    return Flexible(

                      child: StreamBuilder<QuerySnapshot>(
                        stream: EcommerceApp.firestore
                            .collection(EcommerceApp.collectionUser)
                            .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                            .collection(EcommerceApp.subCollectionAddress).snapshots(),
                        builder: (context, snapshot)
                          {
                            return !snapshot.hasData
                                ? Center(child: circularProgress(),)
                                : snapshot.data.docs.length ==0
                                ? noAddressCard()
                                : ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index)
                          {
                            return AddressCard(
                              currentIndex: address.count,
                                value: index,
                              addressId: snapshot.data.docs[index].id,
                              totalAmount: widget.totalAmount,
                              model: AddressModel.fromJson(snapshot.data.docs[index].data()),
                            );
                          },
                            );
                          }
                      ),
                    );
                  }
                  ),
                  //SizedBox(height: 340,),
                  //pta3 al zorar

                  ]
              ),
            ),
            Padding(

              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container( decoration: BoxDecoration(border: Border.all(color:Colors.green)),
                      width: 180,
                      height: 50,
                      child: CustomButton(

                        onPress: (){
                          Route route = MaterialPageRoute(builder: (C) => CartPage());
                          Navigator.pushReplacement(context, route);

                        },
                        text: "Back",
                        color: Colors.white,
                        textColor: primaryColor,



                      ),
                    ),
                    Container(
                      width: 180,
                      height: 50,
                      child: CustomButton(onPress: (){
                        Route route = MaterialPageRoute(builder: (C) => AddAddress());
                        Navigator.pushReplacement(context, route);
                      },
                        text: "Add New Address",



                      ),
                    ),
                  ],),
              ),
            ),
          ],
        ),
        /*floatingActionButton: FloatingActionButton.extended(
          label: Text("Add New Address"),
          backgroundColor: Colors.black ,
          icon: Icon(Icons.add_location),
          onPressed: (){
            Route route = MaterialPageRoute(builder: (C) => AddAddress());
            Navigator.pushReplacement(context, route);
          },
        ),*/
      ),
    );
  }

  noAddressCard() {
    return Card(
        child: Column(children: [
          Container(width: 300,
              height: 300,
              child: Image.asset('images/address.png',)),
          SizedBox(height: 20,),
          Text("No Shipment address has been saved.",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold ,color: Colors.grey),),
          Text("Please add your shipment Address so that we can deliver product.",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold ,color: Colors.grey),)

        ],)
      /*child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location,color: Colors.white,),
            Text("No Shipment address has been saved."),
            Text("Please add your shipment Address so that we can deliver product.")
          ],
        ),
      ),*/
    );
  }
}

class AddressCard extends StatefulWidget {
  final AddressModel model;
  final String addressId;
  final double totalAmount;
  final int currentIndex;
  final int value;
  AddressCard({Key key, this.model, this.currentIndex, this.totalAmount, this.value, this.addressId}) : super(key: key);
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return InkWell(

        onTap: (){
          Provider.of<AddressChanger>(context, listen:  false).displayResult(widget.value);
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color:Colors.grey.shade300)),
          child: Card(
            color: Colors.white,

            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      groupValue: widget.currentIndex,
                      value: widget.value,
                      activeColor: primaryColor,
                      onChanged: (val){
                        Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: screenWidth * 0.8,
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  KeyText(msg: "Name",),
                                  Text(widget.model.name),
                                ]
                              ),
                              TableRow(
                                  children: [
                                    KeyText(msg: "Phone Number",),
                                    Text(widget.model.phoneNumber),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    KeyText(msg: "Flat Number",),
                                    Text(widget.model.flatNumber),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    KeyText(msg: "City",),
                                    Text(widget.model.city),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    KeyText(msg: "State",),
                                    Text(widget.model.state),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    KeyText(msg: "Postal Code",),
                                    Text(widget.model.pincode),
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                widget.value == Provider.of<AddressChanger>(context).count
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 10
                  ),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(color:Colors.green)),
                    child: CustomButton(
                      text:"Proceed" ,
                      color: Colors.white,
                      textColor: primaryColor,
                      onPress: (){
                        Route route = MaterialPageRoute(builder: (C) => PaymentPage(
                          addressId: widget.addressId,
                          totalAmount: widget.totalAmount,
                        ));
                        Navigator.push(context, route);
                      },

                    ),
                  ),
                )/*WideButton(
                  message: "Proceed",
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (C) => PaymentPage(
                      addressId: widget.addressId,
                      totalAmount: widget.totalAmount,
                    ));
                    Navigator.push(context, route);
                  },
                )*/
                    : Container(),
              ],
            ),
          ),
        ),
      );
  }
}





class KeyText extends StatelessWidget {
  final String msg;
  KeyText({Key key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
    );
  }
}
