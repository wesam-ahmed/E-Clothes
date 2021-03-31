
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
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
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),

        ),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.search, color: Colors.blueGrey,),
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