import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_buttom.dart';
import 'package:e_shop/Widgets/custom_text.dart';
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
import 'package:flutter_slidable/flutter_slidable.dart';


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
  ItemModel itemModel;

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
        child: Scaffold(backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: AppBar(
            leading: new IconButton(
              //Customs menu icon color (osama)
              icon: new Icon(
                Icons.menu,
                color: primaryColor,
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            backgroundColor: Colors.white,
            title: Text(
              "LAPSNY",
              style: TextStyle(
                fontSize: 20.0,
                color: primaryColor,
              ),
            ),
            centerTitle: true,

          ),
          drawer: MyDrawer(),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 10,),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: EcommerceApp.firestore
                          .collection("items").where("idItem", whereIn: EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList)).snapshots(),
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
                              return sourceInfo(model, context, removeCartFunction: () => removeItemFromUserCart(model.idItem));
                            },
                            childCount: snapshot.hasData ?  snapshot.data.documents.length : 0,
                          ),
                        );
                      },
                    ),
                    

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: CustomText(text: "PRICE",
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
                          {
                            return Container(
                              margin: EdgeInsets.only(top: 5,left: 5),
                              child: Center(
                                child: cartProvider.count ==0
                                    ? Container()
                                    : Text(
                                  "${amountProvider.totalAmount.toString()}",
                                  style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },),                      ],
                      ),
                      Container(
                        width: 180,
                        height: 50,
                        child: CustomButton(onPress: (){
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
                          text: "Add to Cart",



                        ),
                      ),
                    ],),
                ),
              ),


            ],
          ),

        ));
  }
  beginBuildingCart()
  {
    return SliverToBoxAdapter(
      child: Column(children: [
        Image.asset('images/emptyCart.png',),
        SizedBox(height: 20,),
        Text("Cart Is Empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.grey),)
      ],)
    );
  }
  removeItemFromUserCart(String idItemAsId)
  {
    List tempCartList = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(idItemAsId);
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
Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return  Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child:Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(

        width: 400,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width*.4,
                  child: Image.network(
                    model.thumbnailUrl,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.fill,
                  ),


                )),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  CustomText(text: model.title,alignment: Alignment.topCenter ,),
                  SizedBox(height: 10,),
                  CustomText(text: model.shortInfo,alignment: Alignment.center , color: Colors.grey,),
                  SizedBox(height: 10,),
                  CustomText(text:"\E\G"+model.price.toString(),alignment: Alignment.center ,color: primaryColor,)
                ],),
            )
          ],
        ),

      ),
    ) ,
    secondaryActions: <Widget> [
      new IconSlideAction(
        caption: 'Remove',
        color: Colors.red,
        icon: Icons.delete,
        onTap:() {
          removeCartFunction();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                width: 30,
                height: 80,
                child: AlertDialog(
                  content: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                      )
                  )
                ),
              );
            },
          );
          new Future.delayed(new Duration(seconds: 2), () {
            Route route = MaterialPageRoute(builder: (C) => CartPage());
            Navigator.pushReplacement(context, route);
          });

        },
      ),
    ],
  );
}



