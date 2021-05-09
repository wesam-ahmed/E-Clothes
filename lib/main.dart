import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/Section.dart';
import 'Store/storehome.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  EcommerceApp.auth=FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (c)=> CartItemCounter()),
       ChangeNotifierProvider(create: (c)=> ItemQuantity()),
       ChangeNotifierProvider(create: (c)=> AddressChanger()),
       ChangeNotifierProvider(create: (c)=> TotalAmount()),
     ],
     child: MaterialApp(
      title: 'e-Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,),
      home: SplashScreen()
    ),
   );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    displaySplash();
  }
  displaySplash(){
    Timer(Duration(seconds: 2), ()async{
      if(await EcommerceApp.auth.currentUser() !=null){
        Route route=MaterialPageRoute(builder: (_) => Section());
        Navigator.pushReplacement(context, route);
      }else{
        Route route=MaterialPageRoute(builder: (_) => Login());
        Navigator.pushReplacement(context, route);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors:[Colors.white,Colors.grey],
          begin:const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png"),
              SizedBox(height: 20.0,),
              Text("welcome to e-Shop",style: TextStyle(color: Colors.black54),)
            ],
          ),
        ),
      ),
    );
  }
}
