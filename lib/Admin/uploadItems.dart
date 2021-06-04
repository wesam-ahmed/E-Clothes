
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';

import 'adminOrders.dart';



class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  String DropdownValue_Section ;
  String DropdownValue_Category ;
  List <String> colorList1=[];
  List <String> sizeList1=[];

  //var size=[];
  //var itemcolor=[];


  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEditingController=TextEditingController();
  TextEditingController _priceTextEditingController=TextEditingController();
  TextEditingController _titleTextEditingController=TextEditingController();
  TextEditingController _shortInfoTextEditingController=TextEditingController();
  TextEditingController _QuantityInfoTextEditingController=TextEditingController();

  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading =false;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return file==null ? displayAdminHomeScreen():displayAdminUploadHomeScreen();
  }
  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.green,Colors.green],
                begin:const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
          icon:Icon(Icons.border_color,color: Colors.black,) ,
          onPressed: (){
            Route route = MaterialPageRoute(builder: (C) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          TextButton(
            child: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
            onPressed: (){
              Route route = MaterialPageRoute(builder: (C) => SplashScreen());
              Navigator.pushReplacement(context, route);
            },
          )
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }
  getAdminHomeScreenBody(){
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.lightGreen,Colors.green],
            begin:const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: Colors.white, size:200),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:TextButton(
                style: TextButton.styleFrom(primary: Colors.white,
                  backgroundColor: Colors.black87,
                  onSurface: Colors.grey,
                ),
                child: Text("Add New Items",style: TextStyle(fontSize: 20,color: Colors.white),),

                onPressed: ()=>takeImage(context),
              ) ,

            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:TextButton(
                style: TextButton.styleFrom(primary: Colors.white,
                  backgroundColor: Colors.black87,
                  onSurface: Colors.green,
                ),
                child: Text("My Products",style: TextStyle(fontSize: 20,color: Colors.white),),

                onPressed: (){
                  Route route = MaterialPageRoute(builder: (C) => AdminOrders());
                  Navigator.pushReplacement(context, route);

                },
              ) ,

            ),

          ],
        ),
      ),
    );
  }
  //Dialog of upload pic
  takeImage(mContext){
    return showDialog(context: mContext,
        builder: (con){
          return SimpleDialog(
            title: Text("Item image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera",style: TextStyle(color: Colors.black),),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery",style: TextStyle(color: Colors.black),),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel",style: TextStyle(color: Colors.black),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );

  }
  capturePhotoWithCamera()async{
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile=  await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680.0,maxWidth: 970.0,imageQuality: 40);
    setState(() {
      file=imageFile;
    });
  }
  pickPhotoFromGallery()async{
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile=  await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 15);
    setState(() {
      file=imageFile;
    });
  }
  displayAdminUploadHomeScreen(){
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.white,Colors.grey],
                begin:const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: clearFromInfo ),
        title: Text("New product",style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
        actions: [
          TextButton(
              onPressed:uploading? null: ()=> uploadImageandSaveIteminfo(),
              child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: ListView(
        children: [
          uploading ? circularProgress() : Text(""),
          Container(
            height:230.0 ,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
                ),
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
                  hintText: "shot info",
                  hintStyle: TextStyle(color: Colors.blueGrey),
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
                  hintText: "Title",
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
                  hintText: "Description",
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
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: InputBorder.none,
                ),
              ),
            ),

          ),
          Divider(color: Colors.grey,),
          ListTile(
            leading:Icon(Icons.countertops,color: Colors.grey,),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                controller: _QuantityInfoTextEditingController,
                decoration:  InputDecoration(
                  hintText: "Quantity",
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
                  hint: DropdownValue_Section == null
                      ? Text('Section')
                      : Text(DropdownValue_Section),
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
                  hint: DropdownValue_Category == null
                      ? Text('Category')
                      : Text(DropdownValue_Category),
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
          Divider(color: Colors.grey,),
          ListTile(
    leading:Icon(Icons.add_road_rounded,color: Colors.grey,),
    title: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: CheckboxGroup(

      orientation: GroupedButtonsOrientation.HORIZONTAL,
        labels: <String>[
          "XS", "S", "M", "L", "XL", "XXL", "XXXL","One Size"
        ],
        onSelected: (List<String> sizeChecked) {
        sizeList1=sizeChecked;
          print(sizeList1);
        }
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
                      "Red", "Blue", "Green", "Orange", "White", "Black", "Yellow", "Grey", "Violet", "Brown","Other"
                    ],
                    onSelected: (List<String> colorChecked) {
                      colorList1= colorChecked;
                      print(colorList1);
                    }

                ),
              )



          ),


        ],
      ),
    );


  }
  clearFromInfo() {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }
  uploadImageandSaveIteminfo()async{
    setState(() {
      uploading=true;
    });
    String imageDownloadUrl=await uploadItemImage(file);
    saveIteminfo(imageDownloadUrl);
  }
  Future<String> uploadItemImage(mFileImage)async{
    final Reference storageReference=FirebaseStorage.instance.ref().child(DropdownValue_Section).child(DropdownValue_Category);
    UploadTask uploadTask=storageReference.child("product_$productId.jpg").putFile(mFileImage);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl =await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  saveIteminfo(String downloadUrl){
    final itemsRef=FirebaseFirestore.instance.collection("items");
    itemsRef.doc(productId).set({
      "shortInfo":_shortInfoTextEditingController.text.trim(),
      "longDescription":_descriptionTextEditingController.text.trim(),
      "price":int.parse(_priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "thumbnailUrl":downloadUrl,
      "status":"available",
      "title":_titleTextEditingController.text.trim(),
      "idItem":productId,
      "section":DropdownValue_Section.toString(),
      "category":DropdownValue_Category.toString(),
      "quantity":int.parse(_QuantityInfoTextEditingController.text),
      "size":sizeList1,
      "color":colorList1,
      "sellerid":EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminId),
      "sellername":EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminName),
      "selleraddress":EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminAddress),
      "sellerthumbnailUrl":EcommerceApp.sharedPreferences.getString(EcommerceApp.collectionAdminphoto),
      "buyers":1
    });
    setState(() {
      file=null;
      uploading=false;
      productId=DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      _QuantityInfoTextEditingController.clear();
      DropdownValue_Section=null;
      DropdownValue_Category=null;

    });
  }
}

