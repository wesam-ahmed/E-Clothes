import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
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
  List<String>sizes=[];
  ProductPage({this.itemModel,this.sizes});

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _backStore,
        child: SafeArea(
          child: Scaffold(
            //appBar: MyAppBar(),
              drawer: MyDrawer(),
              body: SingleChildScrollView(
                child: Container(
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


                                            /*StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance.collection("items").document(widget.itemModel.idItem).collection("size").snapshots(),
                                          // ignore: missing_return
                                          builder: (context,snapshot){
                                            if(!snapshot.hasData){
                                              Text("Loading");
                                            }
                                            else{
                                              List<DropdownMenuItem> currencyitems=[];
                                              for(int i=0;i<snapshot.data.documents.length;i++){
                                                DocumentSnapshot snap=snapshot.data.documents[i];
                                                currencyitems.add(
                                                    DropdownMenuItem(child: Text(
                                                      snap.documentID,
                                                    ),
                                                      value: "${snap.documentID}",
                                                    )
                                                );
                                              }
                                              return DropdownButton(
                                                items: currencyitems,
                                                onChanged: (currencyValue){
                                                  final snackbar =SnackBar(
                                                      content: Text('the selected value $currencyValue')
                                                  );
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                  setState(() {
                                                    selectedCurrency=currencyValue;
                                                  });
                                                },
                                                value:selectedCurrency ,
                                                isExpanded: false,
                                                hint: new Text("Size "),
                                              );
                                            }
                                          },
                                        ),*/
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
                                            /*                                        StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance.collection("items").document(widget.itemModel.idItem).collection("color").snapshots(),
                                          // ignore: missing_return
                                          builder: (context,snapshot){
                                            if(!snapshot.hasData){
                                              Text("Loading");
                                            }
                                            else{
                                              List<DropdownMenuItem> currencyitems=[];
                                              for(int i=0;i<snapshot.data.documents.length;i++){
                                                DocumentSnapshot snap=snapshot.data.documents[i];
                                                currencyitems.add(
                                                    DropdownMenuItem(child: Text(
                                                      snap.documentID,
                                                    ),
                                                      value: "${snap.documentID}",
                                                    )
                                                );
                                              }
                                              return DropdownButton(
                                                items: currencyitems,
                                                onChanged: (currencyValue){
                                                  final snackbar =SnackBar(
                                                      content: Text('the selected value $currencyValue')
                                                  );
                                                  Scaffold.of(context).showSnackBar(snackbar);
                                                  setState(() {
                                                    selectedCurrency=currencyValue;
                                                  });
                                                },
                                                value:selectedCurrency ,
                                                isExpanded: false,
                                                hint: new Text("Color "),
                                              );
                                            }
                                          },
                                        ),
*/
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
                    ],
                  ),
                ),
              )),
        ));
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