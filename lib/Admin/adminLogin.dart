import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/Widgets/custom_buttom.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: [Colors.white,Colors.grey],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
          ),
        ),
        title: Text(
          "Lebsy",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
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
          top: 50,
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






   /* return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
          colors: [Colors.white, Colors.grey],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240,
                width: 240,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.person,
                    hintText: "ID",
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
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () {
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
              color: Colors.white,
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black, fontFamily: "Signatra", fontSize: 30),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 4,
              width: _screenWidth * 0.8,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())),
              icon: (Icon(
                Icons.nature_people,
                color: Colors.black,
              )),
              label: Text(
                "i'm not Admin",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );*/
  }

  loginAdmin() {
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
          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
          Route route = MaterialPageRoute(builder: (C) => UploadPage());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
