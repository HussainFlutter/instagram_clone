import 'package:flutter/material.dart';

import '../../../core/constants.dart';


class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.inputType,
    this.controller,
    this.validator,
    this.fieldKey,
    this.helperText,
    this.hintText,
    this.isPasswordField,
    this.onFieldSubmitted,
    this.onSaved,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  
  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Constants.secondaryColor.withOpacity(.35),
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextFormField(
        //style: const TextStyle(color: Constants.primaryColor),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Constants.secondaryColor),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true ? Icon(_obscureText ?Icons.visibility_off : Icons.visibility,color: _obscureText == false ? Constants.blueColor:Constants.secondaryColor,):const Text(""),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
