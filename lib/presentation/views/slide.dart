// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:nftickets/utils/theme.dart';
import '../router/routes.dart';
import '../widgets/onBoarding/progress_button.dart';
import 'package:nftickets/utils/strings.dart';

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
    //final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.background,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kbigSpace, vertical: AppSizes.khugeSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset(image, height: height / 2.5, fit: BoxFit.fill),
          Text(
            AppStrings.kappName,
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSizes.ksmallSpace),
          Text(
            fullDescription,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSizes.khugeSpace),
          ProgressButton(function: function, progressValue: progressValue),
          const SizedBox(height: AppSizes.ksmallSpace),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.signInScreen),
              child: Text(
                AppStrings.kskip,
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.colorScheme.secondary),
              )),
        ],
      ),
    );
  }
}
