import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/logic/cubits/auth/auth_cubit.dart';
import 'package:nftickets/logic/cubits/auth/auth_state.dart';
import 'package:nftickets/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:nftickets/presentation/router/routes.dart';
import 'package:nftickets/presentation/widgets/button.dart';
import 'package:nftickets/presentation/widgets/text.dart';
import 'package:nftickets/presentation/widgets/text_form_field.dart';
import 'package:nftickets/utils/constants.dart';
import 'package:nftickets/utils/theme.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthIsFailure) {
              if (state.error != ktimeOut) {
                Navigator.pop(dialogContext!);
              }
              showScaffold(context, state.error);
            } else if (state is AuthLoadInProgress) {
              showDialog(
                  context: context,
                  builder: (context) {
                    dialogContext = context;
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.klightPurple));
                  });
            } else if (state is AuthSendCodeSuccess) {
              Navigator.pop(dialogContext!);
              Navigator.of(context).pushNamed(AppRoutes.otpVerificationScreen);
            } else if (state is AuthLogInSuccess) {
              Navigator.pop(dialogContext!);
              Navigator.of(context).pushNamed(AppRoutes.homeScreen);
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kbigSpace,
                  vertical: AppSizes.khugeSpace),
              color: AppColors.kdarkPurple,
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
                  Form(
                    key: _formKey,
                    child: TextFormFieldWidget(_phoneController, Icons.phone,
                        AppStrings.kphoneNumber, '', TextInputType.phone),
                  ),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        Center(
                          child: ButtonWidget(
                              text: AppStrings.ksignIn,
                              backgroundColor: AppColors.klightPurple,
                              textColor: AppColors.kwhite,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  if (state is ConnectivityConnect) {
                                    BlocProvider.of<AuthCubit>(context).sendOTP(
                                        '+216${_phoneController.text}');
                                  } else {
                                    showScaffold(
                                        context, kcheckInternetConnection);
                                  }
                                }
                              }),
                        ),
                        const SizedBox(height: AppSizes.ksmallSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: AppColors.kgrey,
                                height: AppSizes.kdividerHeight,
                              ),
                            ),
                            const SizedBox(width: AppSizes.ksmallSpace),
                            const TextWidget(
                              text: AppStrings.kor,
                              color: AppColors.kwhite,
                              bold: false,
                              size: AppFontSizes.ksmallText,
                              shadow: false,
                            ),
                            const SizedBox(width: AppSizes.ksmallSpace),
                            Expanded(
                              child: Container(
                                color: AppColors.kgrey,
                                height: AppSizes.kdividerHeight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.ksmallSpace),
                        Center(
                          child: ButtonWidget(
                            text: AppStrings.ksignInWithGoogle,
                            image: 'assets/google.png',
                            backgroundColor: AppColors.kwhite,
                            textColor: AppColors.kdarkPurple,
                            function: () {
                              if (state is ConnectivityConnect) {
                                BlocProvider.of<AuthCubit>(context)
                                    .googleSignIn();
                              } else {
                                showScaffold(context, kcheckInternetConnection);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showScaffold(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.klightPurple,
      content: Text(text),
      duration: const Duration(milliseconds: 2000),
    ));
  }
}
