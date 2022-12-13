// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:nftickets/presentation/widgets/text.dart';
import 'package:nftickets/utils/theme.dart';
import '../router/routes.dart';
import '../widgets/onBoarding/progress_button.dart';

class Slide extends StatelessWidget {
  const Slide(
      {Key? key,
      this.image,
      this.fullDescription,
      this.progressValue,
      this.function})
      : super(key: key);
  final image, fullDescription, progressValue, function;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.kdarkPurple,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace,vertical: AppSizes.khugeSpace ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset(image, height: height / 2.5, fit: BoxFit.fill),
          const TextWidget(
            text: AppStrings.kappName,
            color: AppColors.kwhite,
            bold: true,
            size: AppFontSizes.ktitle,
            shadow: false,
          ),
          const SizedBox(height: AppSizes.ksmallSpace),
          TextWidget(
            text: fullDescription,
            color: AppColors.kgrey,
            bold: false,
            size: AppFontSizes.kdescription,
            shadow: false,
          ),
          const SizedBox(height: AppSizes.khugeSpace),
          ProgressButton(function: function, progressValue: progressValue),
          const SizedBox(height: AppSizes.ksmallSpace),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.signInScreen),
              child: const TextWidget(
                  text: AppStrings.kskip,
                  color: AppColors.klightPurple,
                  bold: false,
                  size: AppFontSizes.ksmallText,
                  shadow: false)),
        ],
      ),
    );
  }
}
