import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/logic/cubits/user/user_cubit.dart';
import 'package:nftickets/logic/cubits/user/user_state.dart';
import 'package:nftickets/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:nftickets/presentation/router/routes.dart';
import 'package:nftickets/presentation/widgets/button.dart';
import 'package:nftickets/presentation/widgets/text_form_field.dart';
import 'package:nftickets/utils/constants.dart';
import 'package:nftickets/utils/theme.dart';
import 'package:nftickets/utils/strings.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BuildContext? dialogContext;
  ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserIsFailure) {
              if (state.error != ktimeOut) {
                Navigator.pop(dialogContext!);
              }
              showScaffold(context, state.error);
            } else if (state is UserLoadInProgress) {
              showDialog(
                  context: context,
                  builder: (context) {
                    dialogContext = context;
                    return const Center(child: CircularProgressIndicator());
                  });
            } else if (state is UserSendCodeSuccess) {
              Navigator.pop(dialogContext!);
              Navigator.of(context).pushNamed(AppRoutes.otpVerificationScreen);
            } else if (state is UserLogInSuccess) {
              Navigator.pop(dialogContext!);
              Navigator.of(context).pushNamed(AppRoutes.mainScreen);
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kbigSpace,
                  vertical: AppSizes.khugeSpace),
              color: theme!.colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO Display an image
                  const SizedBox(height: AppSizes.kbigSpace),
                  Text(
                    AppStrings.klogin,
                    style: theme!.textTheme.headlineLarge,
                  ),
                  Text(
                    AppStrings.ksubLogin,
                    style: theme!.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSizes.khugeSpace),
                  Form(
                    key: _formKey,
                    child: TextFormFieldWidget(_phoneController, Icons.phone,
                        AppStrings.kphoneNumber, TextInputType.phone),
                  ),
                  const SizedBox(height: AppSizes.kbigSpace),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        Center(
                          child: ButtonWidget(
                              text: AppStrings.ksignIn,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  if (state is ConnectivityConnectSuccess) {
                                    BlocProvider.of<UserCubit>(context).sendOTP(
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
                            const Expanded(
                              child: Divider(
                                height: AppSizes.kdividerHeight,
                              ),
                            ),
                            const SizedBox(width: AppSizes.ksmallSpace),
                            Text(
                              AppStrings.kor,
                              style: theme!.textTheme.bodySmall,
                            ),
                            const SizedBox(width: AppSizes.ksmallSpace),
                            const Expanded(
                              child: Divider(
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
                            backgroundColor: theme!.colorScheme.onBackground,
                            textColor: Colors.black,
                            function: () {
                              if (state is ConnectivityConnectSuccess) {
                                BlocProvider.of<UserCubit>(context)
                                    .signInWithGoogle();
                              } else {
                                showScaffold(context, kcheckInternetConnection);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: AppSizes.ksmallSpace),
                        if (Platform.isIOS)
                          Center(
                            child: ButtonWidget(
                              text: AppStrings.ksignInWithApple,
                              image: 'assets/apple.png',
                              backgroundColor: theme!.colorScheme.onBackground,
                              textColor: Colors.black,
                              function: () {
                                if (state is ConnectivityConnectSuccess) {
                                  BlocProvider.of<UserCubit>(context)
                                      .signInWithApple();
                                } else {
                                  showScaffold(
                                      context, kcheckInternetConnection);
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
      content: Text(text),
      duration: const Duration(milliseconds: 2000),
    ));
  }
}
