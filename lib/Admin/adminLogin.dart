import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminRegistar.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIDTextEditingController =
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
          top: 70,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Admin",
                    fontSize: 30,
                  ),
                  CustomButton(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => adminRegister()),
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
                controller: _adminIDTextEditingController,
                data: Icons.person,
                hintText: "ID",
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
                  _adminIDTextEditingController.text.isNotEmpty &&
                      _passwordTextEditingController.text.isNotEmpty
                      ? loginAdmin()
                      : showDialog(
                      context: context,
                      builder: (C) {
                        return ErrorAlertDialog(
                          message: "please write email and password.",
                        );
                      });

                },
                text: 'LOGIN',
              ),
              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 30,
              ),
              TextButton.icon(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login())),
                icon: (Icon(
                  Icons.nature_people,
                  color: primaryColor,
                )),
                label: Text(
                  "i'm not Admin",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
          )

        ),
      ),
    );

  }

  /*loginAdmin() {
    Firestore.instance.collection("admins").getDocuments().then((snapshot) {
      snapshot.documents.forEach((result) {
        if (result.data["id"] != _adminIDTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("your ID is not correct. "),
          ));
        } else if (result.data["password"] !=
            _passwordTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("your Password is not correct. "),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome Dear Admin, " + result.data["name"]),
          ));
          EcommerceApp.collectionAdmin = result.data["name"];
          EcommerceApp.collectionAdminId = result.data["id"];
          EcommerceApp.collectionAdminName = result.data["name"];
          EcommerceApp.collectionAdminAddress = result.data["address"];
          EcommerceApp.collectionAdminphoto = result.data["thumbnailUrl"];


          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
          Route route = MaterialPageRoute(builder: (C) => UploadPage());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }*/
  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginAdmin() async {
    showDialog(
        context: context,
        builder: (C) {
          return LoadingAlertDialog(
            message: "Authenticating, please wait...",
          );
        });
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(
      email: _adminIDTextEditingController.text.trim(),
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
        Route route = MaterialPageRoute(builder: (C) => UploadPage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance.collection("admins").document(fUser.uid).get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.collectionAdminName, dataSnapshot.data["name"]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.collectionAdminId, dataSnapshot.data["id"]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.collectionAdminphoto, dataSnapshot.data["thumbnailUrl"]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.collectionAdminAddress, dataSnapshot.data["address"]);


    });
  }
}
