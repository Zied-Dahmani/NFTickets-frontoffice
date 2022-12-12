// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:nftickets/presentation/widgets/onBoarding/indicator.dart';
import 'package:nftickets/utils/theme.dart';

class ProgressButton extends StatelessWidget {
  const ProgressButton({Key? key, this.function, this.progressValue})
      : super(key: key);
  final function, progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kprogressButton,
      width: AppSizes.kprogressButton,
      child: Stack(
        children: [
          Indicator(
              size: AppSizes.kprogressButton, progressValue: progressValue),
          Center(
            child: GestureDetector(
              onTap: () => function(),
              child: Container(
                height: AppSizes.kprogressButton - 15,
                width: AppSizes.kprogressButton - 15,
                decoration: BoxDecoration(
                    color: AppColors.korange,
                    borderRadius:
                        BorderRadius.circular(AppSizes.kprogressButtonRadius)),
                child: const Center(
                  child: Icon(Icons.arrow_forward,
                      color: AppColors.kwhite, size: AppSizes.kiconSize),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
