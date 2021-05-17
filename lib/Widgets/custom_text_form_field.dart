import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;
  final TextEditingController controller;
  final Function onSave;
  final Function validator;

  CustomTextFormField({

    this.text,
    this.hint,
    this.onSave,
    this.validator, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          TextFormField(
            onSaved: onSave,
            validator: (val)=> val.isEmpty ?"field can not be empty." : null,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}