import 'package:e_shop/Config/config.dart';

import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/constance.dart';

import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/custom_button.dart';

import 'package:e_shop/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';


import 'address.dart';

class AddAddress extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<bool> _backStore() async{

      return await Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHome()));
    }
    return WillPopScope(
      onWillPop: _backStore,
        child:SafeArea(
      child: Scaffold(
        key: scaffoldKey,

        appBar: AppBar(

          backgroundColor: Colors.white,
          title: Text(
            "EcommerceApp.appNameSNY",
            style: TextStyle(
              fontSize: 20.0,
              color: primaryColor,
            ),
          ),
          centerTitle: true,

        ),
      /*  floatingActionButton: FloatingActionButton.extended(
            onPressed: ()
                {
                  if(formKey.currentState.validate())
                    {
                      final model = AddressModel(
                        name: cName.text.trim(),
                        state: cState.text.trim(),
                        pincode: cPinCode.text.trim(),
                        city: cCity.text.trim(),
                        flatNumber: cFlatHomeNumber.text.trim(),
                        phoneNumber: cPhoneNumber.text.trim(),
                      ).toJson();

                      EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddress)
                      .document(DateTime.now().millisecondsSinceEpoch.toString())
                      .setData(model)
                      .then((value){
                        final snack = SnackBar(content: Text("New Address added susccessfully."));
                        // ignore: deprecated_member_use
                        scaffoldKey.currentState.showSnackBar(snack);
                        FocusScope.of(context).requestFocus(FocusNode());
                        formKey.currentState.reset();
                      });
                      Route route = MaterialPageRoute(builder: (C) => StoreHome());
                      Navigator.pushReplacement(context, route);
                    }
                },
                label: Text("Done"),
        backgroundColor: Colors.black,
        icon: Icon(Icons.check),
        ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Add New Address",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      text: "Name",
                      controller: cName,
                    ),
                    SizedBox(height: 40,),
                    CustomTextFormField(
                      text: "Phone Number",
                      controller: cPhoneNumber,
                    ),
                    SizedBox(height: 40,),
                    CustomTextFormField(
                      text: "Flat Number / House Number",
                      controller: cFlatHomeNumber,
                    ),
                    SizedBox(height: 40,),
                    CustomTextFormField(
                      text: "City",
                      controller: cCity,
                    ),
                    SizedBox(height: 40,),
                    CustomTextFormField(
                      text: "State / Country",
                      controller: cState,
                    ),
                    SizedBox(height: 40,),
                    CustomTextFormField(

                        text:"Postal Code",

                      controller: cPinCode,
                    ),
                  ],
                ),

              ),

            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container( decoration: BoxDecoration(border: Border.all(color:Colors.green)),
                      width: 180,
                      height: 50,
                      child: CustomButton(

                        onPress: (){
                        Route route = MaterialPageRoute(builder: (C) => Address());
                        Navigator.pushReplacement(context, route);

                      },
                        text: "Back",
                        color: Colors.white,
                        textColor: primaryColor,



                      ),
                    ),
                    Container(
                      width: 180,
                      height: 50,
                      child: CustomButton(onPress: (){if(formKey.currentState.validate())
                      {
                        final model = AddressModel(
                          name: cName.text.trim(),
                          state: cState.text.trim(),
                          pincode: cPinCode.text.trim(),
                          city: cCity.text.trim(),
                          flatNumber: cFlatHomeNumber.text.trim(),
                          phoneNumber: cPhoneNumber.text.trim(),
                        ).toJson();

                        EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                            .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                            .collection(EcommerceApp.subCollectionAddress)
                            .document(DateTime.now().millisecondsSinceEpoch.toString())
                            .setData(model)
                            .then((value){
                          final snack = SnackBar(content: Text("New Address added susccessfully."));
                          // ignore: deprecated_member_use
                          scaffoldKey.currentState.showSnackBar(snack);
                          FocusScope.of(context).requestFocus(FocusNode());
                          formKey.currentState.reset();
                        });
                        Route route = MaterialPageRoute(builder: (C) => StoreHome());
                        Navigator.pushReplacement(context, route);
                      }
                      },
                        text: "Done",



                      ),
                    ),
                  ],),
              ),
            ),
          ],


        ),

      ),
      ),
    ));
  }
}
class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  MyTextField({Key key, this.hint, this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),

        validator: (val)=> val.isEmpty ?"field can not be empty." : null,

      ),
    );
  }
}
