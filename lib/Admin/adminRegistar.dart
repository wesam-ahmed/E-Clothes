import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../DialogBox/errorDialog.dart';
import '../DialogBox/loadingDialog.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

import '../Widgets/customTextField.dart';
import 'adminLogin.dart';


class adminRegister extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<adminRegister> {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  final TextEditingController _cpasswordTextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminSignInPage()),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body:SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomText(
                text: "Sign Up,",
                fontSize: 30,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  _selectAndPickImage();
                },
                child: CircleAvatar(
                  radius: _screenWidth *0.15,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _imageFile == null ? null : FileImage(_imageFile),
                  child: _imageFile ==null ? Icon(Icons.add_photo_alternate,size: _screenWidth*0.15,color: Colors.grey,):
                  null,
                ) ,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _nameTextEditingController,
                data: Icons.person,
                hintText: "Name",
                isObsecure: false,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _emailTextEditingController,
                data: Icons.email,
                hintText: "Email",
                isObsecure: false,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _emailTextEditingController,
                data: Icons.location_on_sharp,
                hintText: "Address",
                isObsecure: false,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _passwordTextEditingController,
                data: Icons.vpn_key_outlined,
                hintText: "Password",
                isObsecure: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _cpasswordTextEditingController,
                data: Icons.vpn_key_rounded,
                hintText: "Confirm Password",
                isObsecure: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                onPress: () {
                  uploadAndSaveImage();
                },
                text: 'SIGN Up',
              ),

            ],
          ),
        ),
      ),)
      ,
    );

    /* return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                _selectAndPickImage();
              },
              child: CircleAvatar(
                radius: _screenWidth *0.15,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile == null ? null : FileImage(_imageFile),
                child: _imageFile ==null ? Icon(Icons.add_photo_alternate,size: _screenWidth*0.15,color: Colors.grey,):
                null,
              ) ,
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.vpn_key_outlined,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cpasswordTextEditingController,
                    data: Icons.vpn_key_rounded,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: (){
                uploadAndSaveImage();
              },
              color: Colors.white,
              child: Text("Sign up",style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 30),
            Container(height: 4,
            width: _screenWidth*0.8,
            color: Colors.black,),
            SizedBox(height: 15,
            ),
          ],
        ),
      ),
    );*/
  }

  Future<void> _selectAndPickImage() async {
    // ignore: deprecated_member_use
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    /* if(_imageFile==null)
    {
      showDialog(
        context: context,
        builder: (c)
          {
            return ErrorAlertDialog(message: "PLease select an image file ",);
          }
      );
    }
    else*/

    _passwordTextEditingController.text == _cpasswordTextEditingController.text
        ? _emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty &&
        _cpasswordTextEditingController.text.isNotEmpty &&
        _nameTextEditingController.text.isNotEmpty
        ? uploadToStorage()
        : displayDialog("Please fill up registration complete form..")
        : displayDialog("Password do not match.");
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(message: "Registering, Please wait.....");
          });
      _registerUser();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(message: "Registering, Please wait.....");
          });
      String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
      StorageReference storageReference =
      FirebaseStorage.instance.ref().child(imageFileName);
      StorageUploadTask storageUploadTask =
      storageReference.putFile(_imageFile);
      StorageTaskSnapshot storageTaskSnapshot =
      await storageUploadTask.onComplete;
      await storageTaskSnapshot.ref.getDownloadURL().then((urlImage) {
        userImageUrl = urlImage;
        _registerUser();
      });
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (C) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      saveUserInfoToFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (C) => AdminSignInPage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFirestore(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "url": userImageUrl,
      EcommerceApp.userCartList: ["garbageValue"],
    });
    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameTextEditingController.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}