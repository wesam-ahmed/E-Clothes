import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/custom_buttom.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;

  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoreHome()));
  }

  int quantityOfItems = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _backStore,
        child: SafeArea(
          child: Scaffold(
              //appBar: MyAppBar(),
              drawer: MyDrawer(),
              body:
                  /*Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [Center(child: Container(child: Image.network(widget.itemModel.thumbnailUrl),height: 300,)),],),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child:Center(
                      child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.itemModel.title, style: boldTextStyle,),
                          SizedBox(height: 5.0,),
                          Text(widget.itemModel.longDescription,),
                          SizedBox(height: 5.0,),
                          Text("EGP"+ widget.itemModel.price.toString(), style: boldTextStyle,),
                        ],
                      ) ,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Center(
                      child: InkWell(
                        onTap: ()=>checkItemInCart(widget.itemModel.idItem, context),
                        child: Container(
                          decoration: new BoxDecoration(borderRadius: BorderRadius.circular(35),
                              gradient: new LinearGradient(
                                colors: [Colors.greenAccent,Colors.green],
                                begin:const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0,1.0],
                                tileMode: TileMode.clamp,
                              )
                          ),
                          width: screenSize.width-40.0,
                          height: 50.0,
                          child: Center(
                            child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
            Expanded(child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(child: Text("Related"),),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("items")
                      .where("price",
                      isLessThanOrEqualTo: widget.itemModel.price)
                      .where("category",
                      isEqualTo: widget.itemModel.category)
                      .where("section",
                      isEqualTo: widget.itemModel.section)
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
                        return sourceInfoCompare(model, context);
                      },
                      itemCount: dataSnapshot.data.documents
                          .length,
                    );
                  },
                ),

              ],

              ),)


          ],
        )*/
                  Container(
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 270,
                          child: Image.network(
                            widget.itemModel.thumbnailUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(18),
                                child: Column(
                              children: [
                                CustomText(
                                  text: widget.itemModel.title,
                                  fontSize: 26,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          width: MediaQuery.of(context).size.width*.44,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.grey)

                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomText(text: "Size",),
                                              CustomText(text: "M",),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          width: MediaQuery.of(context).size.width*.44,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.grey)

                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomText(text: "Color",),
                                              Container(
                                                height: 10,
                                                width: 20,
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(color: Colors.white,
                                                border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],),
                                SizedBox(height: 15,),
                                CustomText(text: 'Details',fontSize: 26,),
                                SizedBox(height: 15,),
                                CustomText(text: widget.itemModel.longDescription,fontSize: 16,height: 1,),


                              ],
                            )),
                          ),
                        ),
                       /* Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width*.4,
                            height: 350,
                            color: Colors.grey.shade200,
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
                        ),*/
             /* Flexible(child: CustomScrollView(slivers: [
                SliverToBoxAdapter(),
                StreamBuilder<QuerySnapshot>(

                  stream: Firestore.instance
                      .collection("items")
                      .where("price",
                      isLessThanOrEqualTo: widget.itemModel.price)
                      .where("category",
                      isEqualTo: widget.itemModel.category)
                      .where("section",
                      isEqualTo: widget.itemModel.section)
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


                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                            Column(
                              children: [
                                CustomText(text: "PRICE",
                                fontSize: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5,),
                                CustomText(text: '\E\G'+widget.itemModel.price.toString() ,
                                  color: primaryColor,
                                )
                              ],
                            ),
                            Container(
                              width: 180,
                              height: 100,
                              padding: EdgeInsets.all(20),
                              child: CustomButton(onPress: (){
                                checkItemInCart(widget.itemModel.idItem, context);
                              },
                                text: "Add to Cart",



                              ),
                            ),
                          ],),
                        ),
                      ],
                    ),
                  )*/
    ]
    ),
        )
    ),
    )
    );
  }
}
/*Widget sourceInfoCompare(ItemModel model, BuildContext context,
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

        height: 240,
        width: width,
        child: Column(
          children: [
            Image.network(model.thumbnailUrl, width: 140.0, height: 140.0,),
            SizedBox(width: 4.0,),
            Expanded(child: Column(children: [
              Text(model.title, style: TextStyle(color: Colors.black, fontSize: 14.0),),
              Text(model.shortInfo, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
              Text(model.price.toString(), style: TextStyle(color: Colors.black54, fontSize: 12.0),),
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
}*/

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
