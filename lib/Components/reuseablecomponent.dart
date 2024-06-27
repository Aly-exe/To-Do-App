import 'package:flutter/material.dart';

Widget defaultInputField({
  required String? labelText,
  required String? hintText,
  TextEditingController? FormFieldcontroller,
  TextInputType type= TextInputType.name,
  bool issecure=false,
  Icon? prefixIcon,
  IconData? suffixIcon,
  Function? suffixpressed,
  Function? validate,
})=> TextFormField(  
              controller: FormFieldcontroller,
              keyboardType: type,
              obscureText: issecure,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon!= null? IconButton(icon: Icon(suffixIcon), onPressed: suffixpressed!(),): null ,
                labelText:labelText,
                labelStyle: TextStyle(
                  fontSize: 20.0
                ),
                hintText: hintText,
                border: OutlineInputBorder()
                ),
            );