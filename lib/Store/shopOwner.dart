import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Models/sellerdata.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class shopOwner extends StatefulWidget {
 final ItemModel itemModel;

  const shopOwner({Key key,this.itemModel }) : super(key: key);

  @override
  _shopOwnerState createState() => _shopOwnerState();
}

class _shopOwnerState extends State<shopOwner> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backStore,
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

          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        elevation: 8,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: CircleAvatar
                            (radius: 50,
                              child: ClipOval(
                              child: Image.network(
                                widget.itemModel.sellerthumbnailUrl,
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),)

                          ),


                        ),
                      ),

                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(
                          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                          style: TextStyle(color: Colors.black,fontSize: 22 ,fontWeight: FontWeight.normal),
                        ),
                        Text(
                          EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
                          style: TextStyle(color: Colors.black,fontSize: 10 ,fontWeight: FontWeight.normal),
                        ),
                      ],

                    )

                  ],
                ),
              ),
            ),
            Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Our Collection",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.6,
                    ),
                  ),
                ],
              ),

            ),
            Expanded(
                child: CustomScrollView(

                  slivers: [
                    
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                                            builder: (_) => shopOwner(itemModel: widget.itemModel,));
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
                          isEqualTo: SectionKey.category.toString())
                          .where("sellerid",
                          isEqualTo: widget.itemModel.sellerid)
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

    );
  }
}
Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      getSizes(model.idItem).then((size){
        getColors(model.idItem).then((color){
          Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model,sizes:size,colors: color,));
          Navigator.pushReplacement(context, route);
        });
      });

    },
    splashColor: Colors.grey,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
        width: MediaQuery.of(context).size.width*.4,
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width*.4,
                  child: Image.network(
                    model.thumbnailUrl,
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),


                )),
            SizedBox(height: 10,),
            CustomText(text: model.title,alignment: Alignment.bottomLeft ,),
            SizedBox(height: 10,),
            CustomText(text: model.shortInfo,alignment: Alignment.bottomLeft , color: Colors.grey,),
            SizedBox(height: 10,),
            CustomText(text:"\E\G"+model.price.toString(),alignment: Alignment.bottomLeft ,color: primaryColor,)
          ],
        ),

      ),
    ),
  );
}
