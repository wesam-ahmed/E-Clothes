import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'adminOrders.dart';

class AdminProducts extends StatefulWidget {
  final ItemModel itemModel;
  AdminProducts({this.itemModel});
  @override
  _AdminProductsState createState() => _AdminProductsState();
}
class _AdminProductsState extends State<AdminProducts> {

  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => AdminOrders()));
  }
  String DropdownValue_Section ;
  String DropdownValue_Category ;
  TextEditingController _priceTextEditingController=TextEditingController();
  TextEditingController _shortInfoTextEditingController=TextEditingController();
  TextEditingController _descriptionTextEditingController=TextEditingController();
  TextEditingController _titleTextEditingController=TextEditingController();
  int quantityOfItems=1;


  @override
  Widget build(BuildContext context)
  {Size screenSize =MediaQuery.of(context).size;
  return WillPopScope(
      onWillPop: _backStore,
      child:SafeArea(
        child: Scaffold(
            appBar: MyAppBar(),
            drawer: MyDrawer(),
            body:Column(
              children: [
                SizedBox(height: 5,),
                Row(mainAxisAlignment: MainAxisAlignment.center
                  ,children: [
                  TextButton(
                      onPressed: (){
                        _shortInfoTextEditingController..text=widget.itemModel.title.toString();
                        _descriptionTextEditingController..text=widget.itemModel.longDescription.toString();
                        _priceTextEditingController..text=widget.itemModel.price.toString();
                        _shortInfoTextEditingController..text=widget.itemModel.shortInfo.toString();
                        _titleTextEditingController..text=widget.itemModel.title.toString();
                        DropdownValue_Section=widget.itemModel.section.toString();
                        DropdownValue_Category=widget.itemModel.category.toString();
                      }, child: Text("Show to Edit",style: TextStyle(color: Colors.green,),)),
                  TextButton(child: Text("Update"),onPressed: (){
                    saveIteminfo();
                    Route route = MaterialPageRoute(builder: (_) => AdminOrders());
                    Navigator.pushReplacement(context, route);
                  },),
                  TextButton(child: Text("Delete",style: TextStyle(color: Colors.red),),onPressed: (){
                    DeleteItem();
                    Route route = MaterialPageRoute(builder: (_) => AdminOrders());
                    Navigator.pushReplacement(context, route);
                  },),
                ],),
                Expanded(
                  child: ListView(
                    children: [

                      Container(
                        height:230.0 ,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 16/9,
                            child: Container(child: Image.network(widget.itemModel.thumbnailUrl),height: 300,),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12.0)),
                      ListTile(
                        leading:Icon(Icons.perm_device_info,color: Colors.grey,),
                        title: Container(
                          width: 250.0,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _shortInfoTextEditingController,
                            decoration:  InputDecoration(
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      ),
                      Divider(color: Colors.grey,),

                      ListTile(
                        leading:Icon(Icons.title,color: Colors.grey,),
                        title: Container(
                          width: 250.0,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _titleTextEditingController,
                            decoration:  InputDecoration(
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      ),
                      Divider(color: Colors.grey,),

                      ListTile(
                        leading:Icon(Icons.info,color: Colors.grey,),
                        title: Container(
                          width: 250.0,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _descriptionTextEditingController,
                            decoration:  InputDecoration(
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      ),
                      Divider(color: Colors.grey,),
                      ListTile(
                        leading:Icon(Icons.monetization_on,color: Colors.grey,),
                        title: Container(
                          width: 250.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            controller: _priceTextEditingController,
                            decoration:  InputDecoration(
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      ),
                      Divider(color: Colors.grey,),
                      ListTile(
                        leading:Icon(Icons.arrow_drop_down_circle,color: Colors.grey,),
                        title: Container(
                            width: 250.0,
                            child: DropdownButton<String>(
                              hint: Text(widget.itemModel.section),
                              onChanged: (String newValue) {
                                setState(() {
                                  DropdownValue_Section = newValue;
                                });
                              },
                              items: <String>['Men', 'Woman', 'Kids', 'Used']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                                  .toList(),
                            )

                        ),

                      ),
                      Divider(color: Colors.grey,),
                      ListTile(
                        leading:Icon(Icons.arrow_drop_down_circle,color: Colors.grey,),
                        title: Container(
                            width: 250.0,
                            child: DropdownButton<String>(
                              hint:  Text(widget.itemModel.category),
                              onChanged: (String newValue) {
                                setState(() {
                                  DropdownValue_Category = newValue;
                                });
                              },
                              items: <String>['Shoes', 'Shirts', 'T-Shirt', 'Pants','Jackets']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                                  .toList(),
                            )

                        ),

                      ),
                      /*Divider(color: Colors.grey,),
                      ListTile(
                          leading:Icon(Icons.add_road_rounded,color: Colors.grey,),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CheckboxGroup(

                                orientation: GroupedButtonsOrientation.HORIZONTAL,
                                labels: <String>[
                                  "XS", "S", "M", "L", "XL", "XXL", "XXXL",
                                ],
                                onSelected: (List<String> sizeChecked) => print(sizeChecked.toString())
                            ),
                          )



                      ),
                      Divider(color: Colors.grey,),
                      ListTile(
                          leading:Icon(Icons.color_lens_outlined,color: Colors.grey,),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CheckboxGroup(
                                orientation: GroupedButtonsOrientation.HORIZONTAL,
                                labels: <String> [
                                  "Red", "Blue", "Green", "Orange", "White", "Black", "Yellow", "Grey", "Violet", "Brown",
                                ],
                                onSelected: (List<String> colorChecked) => print(colorChecked.toString())
                            ),
                          )



                      ),*/


                    ],
                  ),
                ),

              ],
            )


        ),
      )
  );

  }
  saveIteminfo(){
    final itemsRef=FirebaseFirestore.instance.collection("items");
    itemsRef.doc(widget.itemModel.idItem) .update({
      "shortInfo":_shortInfoTextEditingController.text.trim(),
      "longDescription":_descriptionTextEditingController.text.trim(),
      "price":int.parse(_priceTextEditingController.text),
      "title":_titleTextEditingController.text.trim(),
      "section":DropdownValue_Section.toString(),
      "category":DropdownValue_Category.toString(),
    });
    setState(() {
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      DropdownValue_Section=null;
      DropdownValue_Category=null;

    });
  }
  DeleteItem(){
    final itemsRef=FirebaseFirestore.instance.collection("items");
    itemsRef.doc(widget.itemModel.idItem).delete();
  }


}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
