import 'package:flutter/cupertino.dart';
import 'package:nftickets/presentation/widgets/text.dart';
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
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => function(),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSizes.ksmallSpace),
          height: AppSizes.kbuttonHeight,
          width: width - 100,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppSizes.kbuttonRadius),
              border: Border.all(color: backgroundColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null)
                Image.asset(image,
                    height: AppSizes.kiconSize, width: AppSizes.kiconSize),
              if (image != null) const SizedBox(width: AppSizes.ksmallSpace),
              if (icon != null)
                Icon(icon, color: textColor, size: AppSizes.kiconSize),
              if (icon != null) const SizedBox(width: AppSizes.ksmallSpace),
              TextWidget(
                text: text,
                color: textColor,
                bold: false,
                size: AppFontSizes.kbuttonText,
                shadow: false,
              ),
            ],
          )),
    );
  }
}
