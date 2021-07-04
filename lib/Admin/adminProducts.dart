import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../main.dart';
import 'adminOrders.dart';
import 'adminShiftOrders.dart';

class AdminProducts extends StatefulWidget {
  final ItemModel itemModel;

  AdminProducts({this.itemModel});
  @override
  _AdminProductsState createState() => _AdminProductsState();
}
class _AdminProductsState extends State<AdminProducts> {
  List <String> colorList1=[];
  List <String> sizeList1=[];
  Future<bool> _backStore()async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => AdminOrders()));
  }
  String DropdownValue_Section ;
  String DropdownValue_Category ;
  TextEditingController _priceTextEditingController=TextEditingController();
  TextEditingController _shortInfoTextEditingController=TextEditingController();
  TextEditingController _descriptionTextEditingController=TextEditingController();
  TextEditingController _titleTextEditingController=TextEditingController();
  TextEditingController _QuantityInfoTextEditingController=TextEditingController();
  int quantityOfItems=1;



  @override
  Widget build(BuildContext context)
  {
  return WillPopScope(
      onWillPop: _backStore,
      child:SafeArea(
        child: Scaffold(
            appBar:  AppBar(
              leading: new IconButton(
                icon:Icon(Icons.border_color,color:primaryColor,) ,
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (C) => AdminShiftOrders());
                  Navigator.pushReplacement(context, route);
                },

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
                    TextButton(
                        child: Text("Logout",style: TextStyle(color: primaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (C) => SplashScreen());
                          Navigator.pushReplacement(context, route);
                        }
                    ),
                  ],
                )
              ],
            ),

            body:getBody(),/*Column(
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
               /* Expanded(
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
                ),*/

              ],
            )*/


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
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[

          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.itemModel.thumbnailUrl))
            ),
            child: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center
                    ,children: [
                      Container(
                        width:100 ,
                        height: 50,
                        child: CustomButton(
                          onPress: (){
                            _shortInfoTextEditingController..text=widget.itemModel.title.toString();
                            _descriptionTextEditingController..text=widget.itemModel.longDescription.toString();
                            _priceTextEditingController..text=widget.itemModel.price.toString();
                            _shortInfoTextEditingController..text=widget.itemModel.shortInfo.toString();
                            _titleTextEditingController..text=widget.itemModel.title.toString();
                            DropdownValue_Section=widget.itemModel.section.toString();
                            DropdownValue_Category=widget.itemModel.category.toString();
                          },

                          text: "Edit",
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width:100 ,
                        height: 50,
                        child: CustomButton(
                          onPress: (){
                            saveIteminfo();
                            Route route = MaterialPageRoute(builder: (_) => AdminOrders());
                            Navigator.pushReplacement(context, route);
                          },

                          text: "Update",
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width:100 ,
                        height: 50,
                        child: CustomButton(
                          onPress: (){
                            DeleteItem();
                            Route route = MaterialPageRoute(builder: (_) => AdminOrders());
                            Navigator.pushReplacement(context, route);
                          },

                          text: "Delete",
                        ),
                      ),

                    ],),
                  CustomTextField(
                    controller: _shortInfoTextEditingController,
                    data: Icons.perm_device_info,
                    hintText:"Shot info" ,
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _titleTextEditingController,
                    data: Icons.title,
                    hintText:"Title" ,
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _descriptionTextEditingController,
                    data: Icons.info,
                    hintText:"Description" ,
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _priceTextEditingController,
                    data: Icons.monetization_on,
                    hintText:"Price" ,
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _QuantityInfoTextEditingController,
                    data: Icons.countertops,
                    hintText:"Quantity" ,
                    isObsecure: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16),

                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: DropdownButton(
                        hint: Text("Selction"),
                        elevation: 3,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        isExpanded: true,
                        dropdownColor: Colors.grey.shade200,
                        onChanged: (String newValue) {
                          setState(() {
                            DropdownValue_Section = newValue;
                          });
                        },
                        items: <String>['Men', 'Woman', 'Kids']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                            .toList(),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16),

                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: DropdownButton(
                        hint: Text("Category"),
                        elevation: 3,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        isExpanded: true,
                        dropdownColor: Colors.grey.shade200,
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

                      ),
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.add_road_rounded,color: Colors.black,),
                              SizedBox(height: 8,),
                              Text("size",style: TextStyle(fontSize: 15),)
                            ],
                          ),

                          SizedBox(width: 5,),
                          CheckboxGroup(
                              checkColor: primaryColor,
                              activeColor: Colors.grey.shade200,
                              orientation: GroupedButtonsOrientation.HORIZONTAL,
                              labels: <String>[
                                "XS", "S", "M", "L", "XL", "XXL", "XXXL","One Size"
                              ],
                              onSelected: (List<String> sizeChecked) {
                                sizeList1=sizeChecked;
                                print(sizeList1);
                              }
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.color_lens,color: Colors.black,),
                              SizedBox(height: 8,),
                              Text("color",style: TextStyle(fontSize: 15),)
                            ],
                          ),

                          SizedBox(width: 5,),
                          CheckboxGroup(
                              checkColor: primaryColor,
                              activeColor: Colors.grey.shade200,
                              orientation: GroupedButtonsOrientation.HORIZONTAL,
                              labels: <String> [
                                "Red", "Blue", "Green", "Orange", "White", "Black", "Yellow", "Grey", "Violet", "Brown","Other"
                              ],
                              onSelected: (List<String> colorChecked) {
                                colorList1= colorChecked;
                                print(colorList1);
                              }
                          ),

                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
