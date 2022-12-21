import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftickets/utils/theme.dart';

class OtpTextFormField extends StatelessWidget {
  const OtpTextFormField({Key? key, this.code, this.index}) : super(key: key);

  final code, index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 54.0,
      width: 42.0,
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            if (value.length == 1) {
              code[index] = value;
              FocusScope.of(context).nextFocus();
            }
          },
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          cursorColor: theme.colorScheme.secondary,
          style: TextStyle(
            color: theme.colorScheme.tertiary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colorScheme.tertiary.withOpacity(0.1),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.kradius),
                borderSide: BorderSide(color: theme.colorScheme.tertiary.withOpacity(0.1))),
          ),
        ),
      ),
    );
  }
}
