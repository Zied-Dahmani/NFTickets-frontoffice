import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftickets/utils/theme.dart';

class OtpTextFormField extends StatelessWidget {
  const OtpTextFormField({Key? key, this.code, this.index}) : super(key: key);

  final code, index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kotpTextFormFieldHeight,
      width: AppSizes.kotpTextFormFieldWidth,
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            if (value.length == 1) {
              code[index] = value;
              FocusScope.of(context).nextFocus();
            }
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          style: const TextStyle(
            color: AppColors.kgrey,
          ),
          cursorColor: AppColors.klightPurple,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kgrey.withOpacity(0.1),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                borderSide: BorderSide(color: AppColors.kgrey.withOpacity(0.1))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                borderSide: const BorderSide(
                    color: AppColors.klightPurple,
                    width: AppSizes.kTextFormFieldBorderWidth)),
          ),
        ),
      ),
    );
  }
}
