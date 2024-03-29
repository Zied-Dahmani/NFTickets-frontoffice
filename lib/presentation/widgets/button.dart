import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftickets/utils/theme.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      this.text,
      this.image,
      this.icon,
      this.backgroundColor,
      this.textColor,
      this.function})
      : super(key: key);
  final text, image, icon, backgroundColor, textColor, function;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 54.0,
      width: width - 100,
      child: ElevatedButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(backgroundColor != null
                  ? theme.colorScheme.secondary.withOpacity(0.4)
                  : theme.colorScheme.onBackground.withOpacity(0.2)),
              backgroundColor: MaterialStateProperty.all(
                  backgroundColor ?? theme.colorScheme.secondary)),
          onPressed: () => function(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null) ...[
                Image.asset(image,
                    height: AppSizes.kiconSize, width: AppSizes.kiconSize),
                const SizedBox(width: AppSizes.ksmallSpace)
              ],
              if (icon != null) ...[
                Icon(icon, color: textColor ?? theme.colorScheme.onBackground),
                const SizedBox(width: AppSizes.ksmallSpace)
              ],
              Text(
                text,
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: textColor ?? theme.colorScheme.onBackground),
              )
            ],
          )),
    );
  }
}
