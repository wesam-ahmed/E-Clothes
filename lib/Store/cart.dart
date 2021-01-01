import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _backStore()async{
     return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
  }

  double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _backStore,
        child: Scaffold(
          key: _scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()
              {
                if(EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length ==1)
                {
                  Fluttertoast.showToast(msg: "your Cart is empty.");
                }
                else
                  {
                    Route route = MaterialPageRoute(builder: (C) => Address(totalAmount: totalAmount));
                        Navigator.pushReplacement(context, route);
                  }
              },
        label: Text("Check Out"),
        backgroundColor: Colors.black,
        icon: Icon(Icons.navigate_next),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.black,),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          }
        ),
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
        title: Text("e-Shop",style: TextStyle(fontSize: 55.0,color: Colors.black,fontFamily: "Signatra"),),
        centerTitle: true,

      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                  padding: EdgeInsets.all(8),
                child: Center(
                  child: cartProvider.count ==0
                      ? Container()
                      : Text(
                    "Total Price: € ${amountProvider.totalAmount.toString()}",
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: EcommerceApp.firestore.collection("items")
            .where("shortInfo", whereIn: EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList)).snapshots(),
            builder: (context, snapshot)
              {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(child:  Center(child: circularProgress(),),)
                    : snapshot.data.documents.length == 0
                    ? beginBuildingCart()
                    : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index)
                        {
                          ItemModel model = ItemModel.fromJson(snapshot.data.documents[index].data);
                          if(index == 0)
                            {
                              totalAmount = 0;
                              totalAmount = model.price + totalAmount;
                            }
                          else
                            {
                              totalAmount = model.price + totalAmount;
                            }
                          if(snapshot.data.documents.length - 1 == index)
                          {
                            WidgetsBinding.instance.addPostFrameCallback((t) {
                              Provider.of<TotalAmount>(context, listen: false).display(totalAmount);
                            });
                          }
                          return sourceInfo(model, context, removeCartFunction: () => removeItemFromUserCart(model.shortInfo));
                        },
                      childCount: snapshot.hasData ?  snapshot.data.documents.length : 0,
                    ),
                );
              },
          ),
        ],
      ),
    ));
  }
  beginBuildingCart()
  {
    return SliverToBoxAdapter(
      child: Card(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon, color: Colors.white,),
              Text("Cart is empty."),
              Text("Start adding items to your Cart"),
            ],
          ),
        ),
      ),
    );
  }
  removeItemFromUserCart(String shortInfoAsId)
  {
    List tempCartList = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);
    EcommerceApp.firestore.collection(EcommerceApp.collectionUser).document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList:tempCartList,
    }).then((v){
      Fluttertoast.showToast(msg: "Item Removed Successfully");
      EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,tempCartList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
      totalAmount = 0;
    });
  }
}
