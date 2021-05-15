import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/custom_buttom.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/sliverhead.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  List<String>sizes=[];
  List<String>colors=[];

  ProductPage({this.itemModel,this.sizes,this.colors});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoreHome()));
  }
  int quantityOfItems = 1;
  String ValueChoose;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _backStore,
        child: SafeArea(
          child: 
          Scaffold(
            body: Column(
                  children: [
                    Container(
                      height: 230,
                      child: Image.network(
                        widget.itemModel.thumbnailUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40))),
                      child: Column(
                        children: [
                          Container(
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
                                            width: MediaQuery.of(context).size.width*.44,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.grey)

                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                DropdownButton(
                                                  hint: Text("Size"),
                                                  value: ValueChoose,
                                                  onChanged: (newValue) {
                                                    ValueChoose = newValue;
                                                  },
                                                  items: widget.sizes.map((ValueItem) {
                                                    return DropdownMenuItem(
                                                      value: ValueItem,
                                                      child: Text(
                                                          ValueItem.toString()),
                                                    );
                                                  }).toList(),
                                                )

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*.44,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.grey)

                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                DropdownButton(
                                                  hint: Text("Color"),
                                                  value: ValueChoose,
                                                  onChanged: (newValue) {
                                                    ValueChoose = newValue;
                                                  },
                                                  items: widget.colors.map((ValueItem) {
                                                    return DropdownMenuItem(
                                                      value: ValueItem,
                                                      child: Text(
                                                          ValueItem.toString()),
                                                    );
                                                  }).toList(),
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
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Column(
                                          children: [
                                            CustomText(text: "PRICE",
                                              fontSize: 10,
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
                                          height: 40,
                                          child: CustomButton(onPress: (){
                                            checkItemInCart(widget.itemModel.idItem, context);
                                          },
                                            text: "Add to Cart",



                                          ),
                                        ),
                                      ],),
                                  ),
                                ],
                              )),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          slivers: [
                          SliverToBoxAdapter(),
                            StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance.collection("items").where("price", isLessThanOrEqualTo: widget.itemModel.price)
                                  .where("category", isEqualTo: widget.itemModel.category).where("section", isEqualTo: widget.itemModel.section).snapshots(),
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
                                        dataSnapshot.data.documents[index].data);
                                    return sourceInfo(model, context);
                                  },
                                  itemCount: dataSnapshot.data.documents.length,
                                );
                              },
                            )


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

                          ],),
                      ),
                    )

                  ],
                ),
          )

        ));

  }
}
buildRow(String title) {
  return Padding(padding: const EdgeInsets.all(15.0),child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)));
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
        width: 50,
        height: 250,
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Container(
                  height: 150,
                  width: 100,
                  child: Image.network(
                    model.thumbnailUrl,
                    fit: BoxFit.fill,
                  ),
                )),
            SizedBox(height: 5,),
            CustomText(text: model.title,alignment: Alignment.bottomLeft ,),
            SizedBox(height: 5,),
            CustomText(text: model.shortInfo,alignment: Alignment.bottomLeft , color: Colors.grey,),
            SizedBox(height: 5,),
            CustomText(text:"\E\G"+model.price.toString(),alignment: Alignment.bottomLeft ,color: primaryColor,)
          ],
        ),

      ),
    ),
  );
}
const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);