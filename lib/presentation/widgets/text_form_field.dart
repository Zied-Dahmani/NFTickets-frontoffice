import 'package:flutter/material.dart';
import 'package:nftickets/utils/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      this.controller, this.icon, this.labelText, this.hintText, this.inputType,
      {super.key});
  final controller, icon, labelText, hintText, inputType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        // ignore: missing_return
        validator: (val) {
          if (val!.isEmpty) {
            return "${AppStrings.ktypeYour} ${labelText.toString().toLowerCase()}!";
          } else if (AppStrings.kphoneNumber == labelText &&
              val.trim().length != 8) {
            return AppStrings.ktypeAValidPhoneNumber;
          }
        },
        cursorColor: AppColors.kgrey,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
              color: AppColors.kred,
              fontSize: AppFontSizes.ksmallText,
              fontWeight: FontWeight.normal),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
            borderSide: const BorderSide(
                color: AppColors.kred,
                width: AppSizes.kTextFormFieldBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
            borderSide: const BorderSide(color: AppColors.kgrey, width: AppSizes.kTextFormFieldBorderWidth),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
              borderSide: const BorderSide(color: AppColors.kgrey,width: AppSizes.kTextFormFieldBorderWidth)),
          prefixIcon: Icon(icon, color: AppColors.kgrey),
          labelText: labelText,
          labelStyle: const TextStyle(
              fontSize: AppFontSizes.kbuttonText, color: AppColors.kgrey),
        ),
        style: const TextStyle(
          color: AppColors.kgrey,
        ),
      ),
    );
  }
}
