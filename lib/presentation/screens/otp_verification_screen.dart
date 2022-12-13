import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftickets/presentation/widgets/button.dart';
import 'package:nftickets/presentation/widgets/text.dart';
import 'package:nftickets/utils/theme.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kdarkPurple,
      appBar: AppBar(backgroundColor: AppColors.kdarkPurple, elevation: 0),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.kbigSpace, vertical: AppSizes.khugeSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              text: AppStrings.kotpVerification,
              color: AppColors.kwhite,
              bold: true,
              size: AppFontSizes.ktitle,
              shadow: false,
            ),
            const TextWidget(
              text: AppStrings.kcodeSent,
              color: AppColors.kgrey,
              bold: false,
              size: AppFontSizes.ksmallText,
              shadow: false,
            ),
            const SizedBox(height:AppSizes.kbigSpace),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //TODO Create otp textformfield widget file
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                          borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                       ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                            borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                            borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                            borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                            borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length == 1) {
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
                            borderSide:  BorderSide(color: AppColors.kgrey.withOpacity(0.1))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
                            borderSide: const BorderSide(color: AppColors.klightPurple,width: AppSizes.kTextFormFieldBorderWidth)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height:AppSizes.kbigSpace),
            Center(
              child: ButtonWidget(
                  text: AppStrings.ksignIn,
                  backgroundColor: AppColors.klightPurple,
                  textColor: AppColors.kwhite,
                  function: () {
                    if (_formKey.currentState!.validate()) {
                        //TODO check the otp
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
