import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/logic/cubits/user/user_cubit.dart';
import 'package:nftickets/logic/cubits/user/user_state.dart';
import 'package:nftickets/presentation/widgets/button.dart';
import 'package:nftickets/presentation/widgets/otp_text_form_field.dart';
import 'package:nftickets/utils/constants.dart';
import 'package:nftickets/utils/strings.dart';
import 'package:nftickets/utils/theme.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _code = ['', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserTypeCodeFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(AppStrings.kinvalidCode),
              duration: Duration(milliseconds: 2000),
            ));
          } else if (state is UserIsFailure && state.error == ktimeOut) {
            Navigator.pop(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.kbigSpace, vertical: AppSizes.khugeSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO Display an image
              Text(
                AppStrings.kotpVerification,
                style: theme.textTheme.headlineLarge,
              ),
              Text(
                AppStrings.kcodeSent,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSizes.kbigSpace),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 6; i++)
                      OtpTextFormField(
                        code: _code,
                        index: i,
                      )
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.kbigSpace),
              Center(
                child: ButtonWidget(
                    text: AppStrings.kverify,
                    function: () {
                      if (_code.join().length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(AppStrings.ktype6DigitCode),
                          duration: Duration(milliseconds: 2000),
                        ));
                      } else {
                        BlocProvider.of<UserCubit>(context)
                            .verifyOTP(_code.join());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
