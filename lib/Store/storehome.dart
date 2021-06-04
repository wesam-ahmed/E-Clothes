import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';
import 'Section.dart';

double width;

Future<QuerySnapshot> docList;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Section()));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: _backStore,
        child: SafeArea(
          child: Scaffold(
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
                EcommerceApp.appName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: primaryColor,
                ),
              ),
              centerTitle: true,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Route route =
                        MaterialPageRoute(builder: (C) => CartPage());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                  ],
                )
              ],
            ),
            drawer: MyDrawer(),
            body:
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [

                  Expanded(
                      child: CustomScrollView(

                        slivers: [
                          SliverPersistentHeader(
                              floating: true, delegate: SearchBoxDelegate()),
                          SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(top: 1, bottom: 10),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomText(
                                      text: "Categorise",
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      padding: EdgeInsets.only(top: 5, bottom: 10),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          FloatingActionButton.extended(
                                            heroTag: "Shoes",
                                            onPressed: () {
                                              SectionKey.category = "Shoes";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset("images/Jacket.png"),
                                            label: Text(
                                              "Jacket",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Shirts",
                                            onPressed: () {
                                              SectionKey.category = "Shirts";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset("images/tshirt.png"),
                                            label: Text(
                                              "T-shirt",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Pants",
                                            onPressed: () {
                                              SectionKey.category = "Pants";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset("images/jeans.png"),
                                            label: Text(
                                              "trousers",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Jackets",
                                            onPressed: () {
                                              SectionKey.category = "Jackets";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset(
                                                "images/hooded-jacket.png"),
                                            label: Text(
                                              "Hoodies",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Sneakers",
                                            onPressed: () {
                                              SectionKey.category = "Sneakers";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon:
                                            Image.asset("images/sneakers.png"),
                                            label: Text(
                                              "shoes",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Shorts",
                                            onPressed: () {
                                              SectionKey.category = "Shorts";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset("images/shorts.png"),
                                            label: Text(
                                              "shorts",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton.extended(
                                            heroTag: "Bags",
                                            onPressed: () {
                                              SectionKey.category = "Bags";
                                              Route route = MaterialPageRoute(
                                                  builder: (_) => StoreHome());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            },
                                            backgroundColor: Colors.grey.shade100,
                                            icon: Image.asset("images/bags.png"),
                                            label: Text(
                                              "accessories",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("items")
                                .where("section",
                                isEqualTo: SectionKey.section.toString())
                                .where("category",
                                isEqualTo: SectionKey.category.toString()).
                              where("isUsed",isEqualTo: SectionKey.isUsed)
                                .snapshots(),
                            builder: (context, dataSnapshot) {
                              return !dataSnapshot.hasData
                                  ? SliverToBoxAdapter(
                                child: Center(
                                  child: circularProgress(),
                                ),
                              )
                                  : SliverStaggeredGrid.countBuilder(
                                crossAxisCount: 2,
                                staggeredTileBuilder: (c) =>
                                    StaggeredTile.fit(1),
                                itemBuilder: (context, index) {
                                  ItemModel model = ItemModel.fromJson(
                                      dataSnapshot
                                          .data.docs[index].data());
                                  return sourceInfo(model, context);
                                },
                                itemCount: dataSnapshot.data.docs.length,
                              );
                            },
                          ),
                        ],
                      )),

                ],
              ),
            ),
          ),
        ));
  }
}
getSizes(String docid)async{
  List <String> sizes=  [];
  await FirebaseFirestore.instance.collection("items").doc(docid).get().then((value){
    if(value!=null)
    {
      value.data()['size'].forEach((element) {
        sizes.add(element);
      });
    }
  });
  return sizes;
}
getColors(String docid)async{
  List <String> colors=  [];
  await FirebaseFirestore.instance.collection("items").doc(docid).get().then((value){
    if(value!=null)
    {
      value.data()['color'].forEach((element) {
        colors.add(element);
      });
    }
  });
  return colors;
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      getSizes(model.idItem).then((size){
        getColors(model.idItem).then((color){
        //Route route = MaterialPageRoute(builder: (c) => ProductPage(itemModel: model,sizes:size,colors: color,));
        Navigator.push(context,PageTransition(type: PageTransitionType.leftToRightWithFade, child: ProductPage(itemModel: model,sizes:size,colors: color,)));
      });
      });

    },
    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0.0, 5.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],),
        width: MediaQuery.of(context).size.width*.4,
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width*.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: Image.network(
                      model.thumbnailUrl,
                      fit: BoxFit.fill,
                    ),
                  ),


                )),
            SizedBox(height: 10,),
            CustomText(text: model.title,alignment: Alignment.bottomLeft,),
            SizedBox(height: 10,),
            CustomText(text:model.price.toString()+" \E\G\P",alignment: Alignment.bottomLeft ,color: primaryColor,),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: 10,
              child: CustomButton(onPress: (){
                checkItemInCart(model.idItem, context);
              },
                text: "Add to Cart",
              ),
            ),

          ],
        ),

      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
    height: 150,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), blurRadius: 10, color: Colors.grey[200]),
        ]),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Image.network(
        imgPath,
        height: 150,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String idItemAsId, BuildContext context) {
  EcommerceApp.sharedPreferences
      .getStringList(EcommerceApp.userCartList)
      .contains(idItemAsId)
      ? Fluttertoast.showToast(msg: "Item is already in Cart")
      : addItemToCart(idItemAsId, context);
}

addItemToCart(String idItemAsId, BuildContext context) {
  List tempCartList =
  EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(idItemAsId);
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .update({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Item Added to Cart Successfully");
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });

}



Future startSearching(String query) async {
  docList = FirebaseFirestore.instance
      .collection("items")
      .where("shortInfo", isGreaterThanOrEqualTo: query)
      .get();
}