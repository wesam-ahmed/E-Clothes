import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              /*flexibleSpace: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [Colors.white, Colors.grey],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
              ),*/
              backgroundColor: Colors.white,
              title: Text(
                "LAPSNY",
                style: TextStyle(
                  fontSize: 20.0,
                  color:primaryColor,
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
                    /* Positioned(
                        child: Stack(
                          children: [
                            Icon(
                              Icons.brightness_1,
                              size: 20,
                              color: Colors.white,
                            ),
                            Positioned(
                                top: 3,
                                bottom: 4,
                                left: 4,
                                child: Consumer<CartItemCounter>(
                                  builder: (context, counter, _) {
                                    return Text(
                                      (EcommerceApp.sharedPreferences
                                          .getStringList(
                                          EcommerceApp.userCartList)
                                          .length -
                                          1)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    );
                                  },
                                ))
                          ],
                        ))*/
                  ],
                )
              ],
            ),
            drawer: MyDrawer(),
            body: /*Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () {
                                  SectionKey.category = "Pants";
                                  Route route = MaterialPageRoute(
                                      builder: (_) => StoreHome());
                                  Navigator.pushReplacement(context, route);
                                },
                                child: Text(
                                  "Pants",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.red,
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () {
                                  SectionKey.category = "Shirts";
                                  Route route = MaterialPageRoute(
                                      builder: (_) => StoreHome());
                                  Navigator.pushReplacement(context, route);
                                },
                                child: Text(
                                  "Shirts",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.greenAccent,
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () {
                                  SectionKey.category = "T-Shirt";
                                  Route route = MaterialPageRoute(
                                      builder: (_) => StoreHome());
                                  Navigator.pushReplacement(context, route);
                                },
                                child: Text(
                                  "T-Shirt",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.lightGreen,
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () {
                                  SectionKey.category = "Jackets";
                                  Route route = MaterialPageRoute(
                                      builder: (_) => StoreHome());
                                  Navigator.pushReplacement(context, route);
                                },
                                child: Text(
                                  "Jackets",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverPersistentHeader(
                                  pinned: true, delegate: SearchBoxDelegate()),
                              StreamBuilder<QuerySnapshot>(
                                /*stream: Firestore.instance.collection(SectionKey.section).document(SectionKey.category).
                      collection("items").limit(15).orderBy("publishedDate",descending: true).snapshots(),*/
                                stream: Firestore.instance
                                    .collection("items")
                                    .where("section",
                                    isEqualTo: SectionKey.section.toString())
                                    .where("category",
                                    isEqualTo: SectionKey.category.toString())
                                    .snapshots(),
                                builder: (context, dataSnapshot) {
                                  return !dataSnapshot.hasData
                                      ? SliverToBoxAdapter(
                                    child: Center(
                                      child: circularProgress(),
                                    ),
                                  )
                                      : SliverStaggeredGrid.countBuilder(
                                    crossAxisCount: 1,
                                    staggeredTileBuilder: (c) =>
                                        StaggeredTile.fit(1),
                                    itemBuilder: (context, index) {
                                      ItemModel model = ItemModel.fromJson(
                                          dataSnapshot
                                              .data.documents[index].data);
                                      return sourceInfo(model, context);
                                    },
                                    itemCount: dataSnapshot.data.documents
                                        .length,
                                  );
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                )),*/
            Container(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: Column(
                children: [
                  /* Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        startSearching(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,color: Colors.black,),
                      ),
                    ),
                  ),*/
                  Expanded(child: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(floating: true, delegate: SearchBoxDelegate()),
                      SliverToBoxAdapter(child:Container(
                        margin: EdgeInsets.only(top: 1,bottom: 10),
                        child:Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomText(text: "Categorise",),
                              SizedBox(height: 10),
                              SingleChildScrollView(padding: EdgeInsets.only( top: 5,bottom: 10),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FloatingActionButton.extended(
                                      heroTag: "Shoes",
                                      onPressed: () {
                                        SectionKey.category = "Shoes";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/Jacket.png"),
                                      label: Text("Jacket",style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Shirts",
                                      onPressed: () {
                                        SectionKey.category = "Shirts";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/tshirt.png"),
                                      label: Text("T-shirt",style: TextStyle(color: Colors.black),),

                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Pants",
                                      onPressed: () {
                                        SectionKey.category = "Pants";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },

                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/jeans.png"),
                                      label: Text("trousers",style: TextStyle(color: Colors.black),),

                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Jackets",
                                      onPressed: () {
                                        SectionKey.category = "Jackets";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },

                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/hooded-jacket.png"),
                                      label: Text("Hoodies",style: TextStyle(color: Colors.black),),

                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Sneakers",
                                      onPressed: () {
                                        SectionKey.category = "Sneakers";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },

                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/sneakers.png"),
                                      label: Text("shoes",style: TextStyle(color: Colors.black),),

                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Shorts",
                                      onPressed: () {
                                        SectionKey.category = "Shorts";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },

                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/shorts.png"),
                                      label: Text("shorts",style: TextStyle(color: Colors.black),),

                                    ),
                                    SizedBox(width: 10,),
                                    FloatingActionButton.extended(
                                      heroTag: "Bags",
                                      onPressed: () {
                                        SectionKey.category = "Bags";
                                        Route route = MaterialPageRoute(
                                            builder: (_) => StoreHome());
                                        Navigator.pushReplacement(context, route);
                                      },

                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/bags.png"),
                                      label: Text("accessories",style: TextStyle(color: Colors.black),),

                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        ) ,

                      ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("items")
                            .where("section",
                            isEqualTo: SectionKey.section.toString())
                            .where("category",
                            isEqualTo: SectionKey.category.toString())
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
                                      .data.documents[index].data);
                              return sourceInfo(model, context);
                            },
                            itemCount: dataSnapshot.data.documents
                                .length,
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

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
      MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(

        height: 250,
        width: width,
        child: Column(
          children: [
            Image.network(model.thumbnailUrl, width: 140.0, height: 140.0,),
            SizedBox(width: 4.0,),
            Expanded(child: Column(children: [
              Text(model.title, style: TextStyle(color: Colors.black, fontSize: 14.0),),
              Text(model.shortInfo, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
              Align(
                alignment: Alignment.centerRight,
                child: removeCartFunction == null
                    ? IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    checkItemInCart(model.idItem, context);
                  },
                )
                    : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    removeCartFunction();
                    Route route = MaterialPageRoute(
                        builder: (C) => StoreHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
            ],),),


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
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Item Added to Cart Successfully");
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
Future startSearching(String query) async
{
  docList = Firestore.instance.collection("items").where("shortInfo",isGreaterThanOrEqualTo: query).getDocuments();
}