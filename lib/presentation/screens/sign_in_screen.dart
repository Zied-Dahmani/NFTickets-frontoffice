import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/logic/cubits/auth/auth_cubit.dart';
import 'package:nftickets/logic/cubits/auth/auth_state.dart';
import 'package:nftickets/presentation/router/routes.dart';
import 'package:nftickets/presentation/widgets/button.dart';
import 'package:nftickets/presentation/widgets/text.dart';
import 'package:nftickets/presentation/widgets/text_form_field.dart';
import 'package:nftickets/utils/theme.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kbigSpace, vertical: AppSizes.khugeSpace),
            color: AppColors.kdarkPurple,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSizes.kbigSpace),
                  const TextWidget(
                    text: AppStrings.klogin,
                    color: AppColors.kwhite,
                    bold: true,
                    size: AppFontSizes.ktitle,
                    shadow: false,
                  ),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  const TextWidget(
                    text: AppStrings.ksubLogin,
                    color: AppColors.kgrey,
                    bold: false,
                    size: AppFontSizes.ksmallText,
                    shadow: false,
                  ),
                  const SizedBox(height: AppSizes.khugeSpace),
                  TextFormFieldWidget(_phoneController, Icons.phone,
                      AppStrings.kphoneNumber, '', TextInputType.phone),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      } else if (state is AuthCodeNotSentErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(AppStrings.ktryLater),
                          duration: Duration(milliseconds: 2000),
                        ));
                      } else if (state is AuthCodeSentState) {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.verifyPhoneNumberScreen);
                      } else if (state is AuthLoggedInState) {
                        Navigator.of(context).pushNamed(AppRoutes.homeScreen);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (state is AuthLoadingState)
                            const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.korange,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  ButtonWidget(
                      text: AppStrings.ksignIn,
                      backgroundColor: AppColors.korange,
                      textColor: AppColors.kwhite,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          String phoneNumber =
                              '+216${_phoneController.text}';
                          BlocProvider.of<AuthCubit>(context)
                              .sendOTP(phoneNumber);
                        }
                      }),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          color: AppColors.kgrey,
                          height: AppSizes.kdividerHeight,
                          width: width / 2.5),
                      const SizedBox(width: AppSizes.ksmallSpace),
                      const TextWidget(
                        text: AppStrings.kor,
                        color: AppColors.kwhite,
                        bold: false,
                        size: AppFontSizes.ksmallText,
                        shadow: false,
                      ),
                      const SizedBox(width: AppSizes.ksmallSpace),
                      Container(
                          color: AppColors.kgrey,
                          height: AppSizes.kdividerHeight,
                          width: width / 2.5),
                    ],
                  ),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  ButtonWidget(
                    text: AppStrings.ksignInWithGoogle,
                    image: 'assets/google.png',
                    backgroundColor: AppColors.kwhite,
                    textColor: AppColors.kdarkPurple,
                    function: () {
                      BlocProvider.of<AuthCubit>(context)
                          .googleSignIn();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
