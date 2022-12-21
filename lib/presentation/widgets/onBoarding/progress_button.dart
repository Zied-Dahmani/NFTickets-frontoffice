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
      height: AppSizes.kiconBackgroundSize + 15.0,
      width: AppSizes.kiconBackgroundSize + 15.0,
      child: Stack(
        children: [
          Indicator(size: AppSizes.kiconBackgroundSize + 15.0, progressValue: progressValue),
          Center(
            child: GestureDetector(
              onTap: () => function(),
              child: Container(
                height: AppSizes.kiconBackgroundSize,
                width: AppSizes.kiconBackgroundSize,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(AppSizes.kiconBackgroundRadius)),
                child: const Center(
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
