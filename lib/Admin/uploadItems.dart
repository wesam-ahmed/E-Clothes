
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;



class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{

  bool get wantKeepAlive => true;
  File file;
  TextEditingController _desctiptiontextEditingController=TextEditingController();
  TextEditingController _pricetextEditingController=TextEditingController();
  TextEditingController _titletextEditingController=TextEditingController();
  TextEditingController _shortInfotextEditingController=TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading =false;
  @override
  Widget build(BuildContext context) {
    return file==null ? displayAdminHomeScreen():displayAdminUploadHomeScreen();
  }
  displayAdminHomeScreen()
  {
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
        leading: IconButton(
          icon:Icon(Icons.border_color,color: Colors.black,) ,
          onPressed: (){
            Route route = MaterialPageRoute(builder: (C) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          FlatButton(
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
            colors: [Colors.white,Colors.grey],
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
            Icon(Icons.shop_two,color: Colors.black, size:200),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                child: Text("Add New Items",style: TextStyle(fontSize: 20,color: Colors.black),),
                color: Colors.grey,
                onPressed: ()=>takeImage(context),
              ) ,
            )

          ],
        ),
      ),
    );
  }
  takeImage(mContext){
    return showDialog(context: mContext,
      builder: (con){
       return SimpleDialog(
         title: Text("Item image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
         children: [
           SimpleDialogOption(
             child: Text("Capturre with Camera",style: TextStyle(color: Colors.black),),
             onPressed: capturePhotoWithCamera,
           ),
           SimpleDialogOption(
             child: Text("Selact from Gallery",style: TextStyle(color: Colors.black),),
             onPressed: pickPhotoFromGallery,
           ),
           SimpleDialogOption(
             child: Text("cancel",style: TextStyle(color: Colors.black),),
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
  File imageFile=  await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680.0,maxWidth: 970.0);
  setState(() {
    file=imageFile;
  });
  }
  pickPhotoFromGallery()async{
    Navigator.pop(context);
    File imageFile=  await ImagePicker.pickImage(source: ImageSource.gallery);
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
          FlatButton(onPressed:uploading? null: ()=> uploadImageandSaveIteminfo(), child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),))
        ],
      ),
      body: ListView(
        children: [
          uploading?circularProgress():Text(""),
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
            leading:Icon(Icons.perm_device_info,color: Colors.black87,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _shortInfotextEditingController,
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
            leading:Icon(Icons.title,color: Colors.black87,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _titletextEditingController,
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
            leading:Icon(Icons.info,color: Colors.black87,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _desctiptiontextEditingController,
                decoration:  InputDecoration(
                  hintText: "Desctiption",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: InputBorder.none,
                ),
              ),
            ),

          ),
          Divider(color: Colors.grey,),
          ListTile(
            leading:Icon(Icons.monetization_on,color: Colors.black87,),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                controller: _pricetextEditingController,
                decoration:  InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: InputBorder.none,
                ),
              ),
            ),

          ),
          Divider(color: Colors.grey,),



        ],
      ),
    );


  }
  clearFromInfo() {
    setState(() {
      file = null;
      _desctiptiontextEditingController.clear();
      _titletextEditingController.clear();
      _shortInfotextEditingController.clear();
      _titletextEditingController.clear();
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
      final StorageReference storageReference=FirebaseStorage.instance.ref().child("Items");
      StorageUploadTask uploadTask=storageReference.child("product_$productId.jpg").putFile(mFileImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadurl =await taskSnapshot.ref.getDownloadURL();
      return downloadurl;
    }
  saveIteminfo(String downloadUrl){
    final itemsRef=Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo":_shortInfotextEditingController.text.trim(),
      "longDescription":_desctiptiontextEditingController.text.trim(),
      "price":_pricetextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "status":downloadUrl,
      "title":_titletextEditingController.text.trim(),
    });
    setState(() {
       file=null;
       uploading=false;
       productId=DateTime.now().millisecondsSinceEpoch.toString();
       _desctiptiontextEditingController.clear();
       _titletextEditingController.clear();
       _shortInfotextEditingController.clear();
       _pricetextEditingController.clear();
    });
  }
  }

