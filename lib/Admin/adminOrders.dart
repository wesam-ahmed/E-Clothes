import 'package:e_shop/Store/Section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminOrders extends StatefulWidget{
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
  }
class _AdminOrdersState extends State<AdminOrders>{
  Future<bool> _backStore() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Section()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

    );
  }

}



