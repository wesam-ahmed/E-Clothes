
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/customAppBar.dart';

class SearchService {
}



class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct>{
  Future<bool> _backStore() async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
  }
  Future<QuerySnapshot> docList;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backStore,
      child: SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          bottom: PreferredSize(child: searchWidget(),preferredSize: Size(56,56)),),
        body: FutureBuilder<QuerySnapshot>(
          future: docList,
          builder: (context,snap)
          {
            return snap.hasData
                ?ListView.builder(
              itemCount: snap.data.documents.length,
              itemBuilder: (context, index)
              {
                ItemModel model =ItemModel.fromJson(snap.data.documents[index].data);
                return sourceInfo(model, context);
              },
            )
                :Text("NO data Available.");
          },
        ),
      ),
    ));
  }
  Widget searchWidget() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 80,

      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.search,color: Colors.black,)
            ),
            Flexible(child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextField(
                onChanged: (value) {
                  startSearching(value);
                },
                decoration: InputDecoration.collapsed(
                    hintText: "Search here..."),
              ),
            ))
          ],
        ),
      ),
    );
  }
    Future startSearching(String query) async
    {
      docList = Firestore.instance.collection("items").where("shortInfo",isGreaterThanOrEqualTo: query).getDocuments();
    }

}

Widget buildResultCard(data) {
  return Card(

  );

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