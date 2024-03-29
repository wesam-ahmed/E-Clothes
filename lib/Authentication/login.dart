import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Authentication/register.dart';
import 'package:e_shop/Store/Section.dart';
import 'package:e_shop/Widgets/constance.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/Widgets/custom_button.dart';
import 'package:e_shop/Widgets/custom_button_social.dart';
import 'package:e_shop/Widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          child: SingleChildScrollView(
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
                  Signinfacebook();
                },
                imageName: 'images/facebook.png',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButtonSocial(
                text: 'Sign In with Google',
                onPress: () {
                  SignInG();
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
                  color: primaryColor,
                )),
                label: Text(
                  "i'm Admin",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
        ),
      ),
    );

  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookLogin _facebookLogin=FacebookLogin();

  void Signinfacebook()async{
   FacebookLoginResult result= await _facebookLogin.logIn(['email']);
    final accessToken=result.accessToken.token;
    if(result.status==FacebookLoginStatus.loggedIn){
       final faceCredential=FacebookAuthProvider.credential(accessToken);
       User user = (await _auth.signInWithCredential(faceCredential)).user;
       readData(user).then((s) {
         saveUserGoogleandFacebookToFirestore(user);
         Route route = MaterialPageRoute(builder: (C) => Section());
         Navigator.pushReplacement(context, route);
       });
    }
  }

  void SignInG() async {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    User user= (await _auth.signInWithCredential(credential)).user;


    readData(user).then((s) {
      saveUserGoogleandFacebookToFirestore(user);
      Route route = MaterialPageRoute(builder: (C) => Section());
      Navigator.pushReplacement(context, route);

    });

  }
  Future saveUserGoogleandFacebookToFirestore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": fUser.displayName,
      "url": fUser.photoURL,
      EcommerceApp.userCartList: ["garbageValue"],
    });
    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, fUser.displayName);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, fUser.photoURL);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }

  void loginUser() async {
    showDialog(
        context: context,
        builder: (C) {
          return LoadingAlertDialog(
            message: "Authenticating, please wait...",
          );
        });
    User firebaseUser;
    await _auth.signInWithEmailAndPassword(
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

  Future readData(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences.setString("uid", dataSnapshot.data()[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, dataSnapshot.data()[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, dataSnapshot.data()[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, dataSnapshot.data()[EcommerceApp.userAvatarUrl]);
      List<String> carList = dataSnapshot.data()[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, carList);
    });
  }


}

