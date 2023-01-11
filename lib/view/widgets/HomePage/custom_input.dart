import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final bool issearch;
  final TextEditingController mycontroller;
  final bool isText;
  final String focusDirection;

  final Function(String)? function;
  const CustomInput({
    super.key,
    required this.hint,
    this.issearch = false,
    required this.mycontroller,
    this.isText = false,
    this.function,
    required this.focusDirection,
  });

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return TextFormField(
      inputFormatters:
          !isText ? [FilteringTextInputFormatter.allow(RegExp("[0-9]"))] : [],
      controller: mycontroller,
      onChanged: function,
      enableIMEPersonalizedLearning: true,
      style: TextStyle(color: Get.theme.primaryColor),
      cursorColor: Get.theme.primaryColor,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        if (focusDirection == "left") {
          focus.focusInDirection(TraversalDirection.left);
        } else if (focusDirection == "right") {
          focus.focusInDirection(TraversalDirection.down);
          focus.focusInDirection(TraversalDirection.right);
          focus.focusInDirection(TraversalDirection.right);
          focus.focusInDirection(TraversalDirection.right);
        } else {
          focus.unfocus();
        }
      },
      textDirection: TextDirection.rtl,
      keyboardType: isText ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
        ),
        hintText: issearch ? hint : null,
        hintStyle: Get.theme.textTheme.bodyText1!
            // ignore: deprecated_member_use
            .copyWith(fontSize: 12, color: Get.theme.accentColor),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        labelStyle: Get.theme.textTheme.bodyText1!
            .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
        label: !issearch
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  hint,
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        hintTextDirection: TextDirection.rtl,
        prefixIcon: issearch
            ? Icon(
                Icons.search,
                color: Get.theme.primaryColor,
              )
            : null,
        prefixIconColor: Get.theme.primaryColor,
        fillColor: Get.theme.backgroundColor,
        filled: true,
      ),
    );
  }
}
