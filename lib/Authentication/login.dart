import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Authentication/register.dart';
import 'package:e_shop/Store/Section.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/Widgets/custom_buttom.dart';
import 'package:e_shop/Widgets/custom_button_social.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Welcome,",
                    fontSize: 30,
                  ),
                  CustomButton(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    text: "Sign Up",
                    color: primaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Sign in to Continue',
                fontSize: 14,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _emailTextEditingController,
                data: Icons.email,
                hintText: "Email",
                isObsecure: false,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: _passwordTextEditingController,
                data: Icons.lock,
                hintText: "Password",
                isObsecure: true,
              ),
              SizedBox(
                height: 20,
              ),

              CustomButton(
                onPress: () {
                  _emailTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty
                      ? loginUser()
                      : showDialog(
                          context: context,
                          builder: (C) {
                            return ErrorAlertDialog(
                              message: "please write email and password.",
                            );
                          });
                },
                text: 'SIGN IN',
              ),
              SizedBox(
                height: 30,
              ),
              CustomText(
                text: '-OR-',
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButtonSocial(
                text: 'Sign In with Facebook',
                onPress: () {
                  //controller.facebookSignInMethod();
                },
                imageName: 'images/facebook.png',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButtonSocial(
                text: 'Sign In with Google',
                onPress: () {
                  //controller.googleSignInMethod();
                },
                imageName: 'images/google.png',
              ),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminSignInPage())),
                icon: (Icon(
                  Icons.nature_people,
                  color:primaryColor ,
                )),
                label: Text(
                  "i'm Admin",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /* return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 240,
                width: 240,
              ),
            ),
            Padding(
            padding: EdgeInsets.all(8),
              child: Text(
                "Login to your account",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: (){
                _emailTextEditingController.text.isNotEmpty
                    && _passwordTextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                  context: context,
                  builder: (C)
                    {
                      return ErrorAlertDialog(message: "please write email and password.",);
                    }
                );
              },
              color: Colors.white,
              child: Text("Login",style:TextStyle(color: Colors.black,fontFamily: "Signatra" ,fontSize: 30),),
            ),
            SizedBox(height: 50),
            Container(height: 4,
              width: _screenWidth*0.8,
              color: Colors.black,),
            SizedBox(height: 10,),
            TextButton.icon(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminSignInPage())),
              icon: (Icon(Icons.nature_people, color: Colors.black,)),
              label: Text("i'm Admin", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );*/
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (C) {
          return LoadingAlertDialog(
            message: "Authenticating, please wait...",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
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
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (C) => Section());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences
          .setString("uid", dataSnapshot.data[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userName, dataSnapshot.data[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,
          dataSnapshot.data[EcommerceApp.userAvatarUrl]);
      List<String> carList =
          dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, carList);
    });
  }
}
