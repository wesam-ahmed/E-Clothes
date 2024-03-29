import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShopOwner extends StatefulWidget {
 final ItemModel itemModel;

  const ShopOwner({Key key,this.itemModel }) : super(key: key);

  @override
  _ShopOwnerState createState() => _ShopOwnerState();
}

class _ShopOwnerState extends State<ShopOwner> {
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
            EcommerceApp.appName,
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
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:<Widget> [
                        Row(
                          children: [
                            Icon(Icons.perm_identity_rounded,color: primaryColor,),
                            Text(
                              widget.itemModel.sellername,
                              style: TextStyle(color: Colors.black,fontSize: 20 ,fontWeight: FontWeight.normal),
                            ),

                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.email,color: primaryColor,),
                            SizedBox(width: 3,),
                            Text(
                              widget.itemModel.sellerid,
                              style: TextStyle(color: Colors.black,fontSize: 13 ,fontWeight: FontWeight.normal),
                            ),

                          ],
                        ),
                        Row(children: [
                          Icon(Icons.location_on,color: primaryColor,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                widget.itemModel.selleraddress,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black,fontSize: 10 ,height: 1.4,fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,

                              ),
                            ),
                          ),

                        ],)
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
                                      heroTag: "Jackets",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "Jackets";
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/Jacket.png"),
                                      label: Text(
                                        "Jackets",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "Shirts",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "Shirts";
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/shirt.png"),
                                      label: Text(
                                        "Shirt",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "T-Shirt",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "T-Shirt";
                                        });
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
                                        setState(() {
                                          SectionKey.category = "Pants";
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/jeans.png"),
                                      label: Text(
                                        "Pants",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "Hoodies",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "Hoodies";
                                        });
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
                                      heroTag: "Shoes",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "Shoes";
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon:
                                      Image.asset("images/sneakers.png"),
                                      label: Text(
                                        "Shoes",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "Shorts",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "Shorts";
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade100,
                                      icon: Image.asset("images/shorts.png"),
                                      label: Text(
                                        "Shorts",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "accessories",
                                      onPressed: () {
                                        setState(() {
                                          SectionKey.category = "accessories";
                                        });
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
                            ItemModel model = ItemModel.fromJson(dataSnapshot.data.docs[index].data());
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
