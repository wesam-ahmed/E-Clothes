import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';

import 'constance.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        padding: EdgeInsets.only(top: 100,left: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        elevation: 8,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage: EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl)==null ?
                            AssetImage('images/google.png')
                                :NetworkImage(EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),),

                          ),

                   /* Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(100),),

                            backgroundImage: EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl)==null ?
                            AssetImage('images/google.png')
                                :NetworkImage(EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),),

                          ),*/
                        ),
                      ),

                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(
                          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                          style: TextStyle(color: Colors.black,fontSize: 22 ,fontWeight: FontWeight.normal),
                        ),
                        Text(
                          EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
                          style: TextStyle(color: Colors.black,fontSize: 10 ,fontWeight: FontWeight.normal),
                        ),
                      ],

                    )

                  ],
                ),
              ),
              SizedBox(height: 80,),
              Container(

                  child:ListTile(
                    leading: Icon(Icons.home,color: primaryColor,),
                    title: Text("Home",style: TextStyle(color: Colors.black),),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (C) => StoreHome());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
              Container(
                child:ListTile(
                  leading: Icon(Icons.reorder,color: primaryColor,),
                  title: Text("My Orders",style: TextStyle(color: Colors.black),),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (C) => MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
              Container(
                child:ListTile( leading: Icon(Icons.shopping_cart,color: primaryColor,),
                  title: Text("My Cart",style: TextStyle(color: Colors.black),),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (C) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
              Container(
                child:ListTile(
                  leading: Icon(Icons.search,color: primaryColor,),
                  title: Text("Search",style: TextStyle(color: Colors.black),),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (C) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },

                ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
              Container(
                child:ListTile(
                  leading: Icon(Icons.add_location,color: primaryColor,),
                  title: Text("Add New Address",style: TextStyle(color: Colors.black),),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (C) => AddAddress());
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
              Container(
                child:ListTile(
                  leading: Icon(Icons.exit_to_app,color: primaryColor,),
                  title: Text("Logout",style: TextStyle(color: Colors.black),),
                  onTap: () {
                    EcommerceApp.auth.signOut().then((c) {
                      Route route = MaterialPageRoute(builder: (C) => Login());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
              ),
              Divider(height: 5,color: Colors.grey.shade200,thickness: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
