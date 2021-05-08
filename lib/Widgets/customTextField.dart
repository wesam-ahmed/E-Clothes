import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;



  CustomTextField(
      {Key key, this.controller, this.data, this.hintText,this.isObsecure}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,

        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(data,color: Colors.black,),
          hintText: hintText
        ),
      ),
    );
  }
}
