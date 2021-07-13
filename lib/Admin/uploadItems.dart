
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Admin/uploadUsedItems.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  bool isUsed=false;
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
      appBar:AppBar(
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
      body: getAdminHomeScreenBody(),
    );
  }
  getAdminHomeScreenBody(){
    return Container(

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: primaryColor, size:200),
            Container(
              width:180 ,
              height: 50,
              child: CustomButton(
                onPress: (){
                  takeImage(context);
                },
                color: Colors.grey.shade400,
                text: "Add New Items",
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width:180 ,
              height: 50,
              child: CustomButton(
                onPress: (){
                  Route route = MaterialPageRoute(builder: (C) => UploadUsedPage());
                  Navigator.pushReplacement(context, route);
                },

                text: "Add Used Items",
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width:180 ,
              height: 50,
              child: CustomButton(
                onPress: (){
                  Route route = MaterialPageRoute(builder: (C) => AdminOrders());
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.grey.shade400,
                text: "My Products",
              ),
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
//Upload Item Layout
  displayAdminUploadHomeScreen(){
    Future<bool> _backStore() async {
      return await Navigator.push(
          context, MaterialPageRoute(builder: (context) => UploadPage()));
    }
    return WillPopScope(
      onWillPop: _backStore,
      child: Scaffold(
        appBar:AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: primaryColor,),onPressed: clearFromInfo ),
          backgroundColor: Colors.white,
          title: Text("New product",
            style: TextStyle(
              fontSize: 20.0,
              color: primaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed:uploading? null: (){
                  uploadImageandSaveIteminfo();
                } ,
                child: Text("Add",style: TextStyle(color: primaryColor,fontSize: 16.0,fontWeight: FontWeight.bold),)
            )
          ],

        ),
        body:getBody(),
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
      "shortInfo":toBeginningOfSentenceCase(_shortInfoTextEditingController.text).trim(),
      "longDescription":toBeginningOfSentenceCase(_descriptionTextEditingController.text).trim(),
      "price":int.parse(_priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "thumbnailUrl":downloadUrl,
      "status":"available",
      "title":toBeginningOfSentenceCase(_titleTextEditingController.text).trim(),
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
      "buyers":1,
      "isUsed":isUsed,
      "rate":5,
      "rater":1,
      "finalrate":5
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
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(file),fit: BoxFit.fill)
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
                        hint: DropdownValue_Section == null
                            ? Text('Section')
                            : Text(DropdownValue_Section),
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
                        hint: DropdownValue_Category ==null
                       ? Text("Category")
                        :Text(DropdownValue_Category),
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
                        items: <String>['Shoes', 'Shirts', 'T-Shirt', 'Pants','Jackets','Hoodies','Shorts','accessories']
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
                  SizedBox(height: 8),
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

