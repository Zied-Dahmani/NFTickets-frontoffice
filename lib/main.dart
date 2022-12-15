import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nftickets/logic/cubits/auth/auth_cubit.dart';
import 'package:nftickets/logic/cubits/auth/auth_state.dart';
import 'package:nftickets/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:nftickets/presentation/screens/on_boarding_screen.dart';
import 'package:nftickets/presentation/screens/sign_in_screen.dart';
import 'package:nftickets/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => runApp(MyApp()),
      storage: storage, blocObserver: AppBlocObserver());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.kdarkPurple,
      statusBarIconBrightness: Brightness.light, // For Android
      statusBarBrightness: Brightness.dark, // For iOS
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit(), lazy: true),
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit(), lazy: false),
        ],
        child: MaterialApp(
          title: 'NFTickets',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _appRouter.onGenerateRoute,
          home: Builder(builder: (context) {
            final connectivityState = context.watch<ConnectivityCubit>().state;
            final authState = context.watch<AuthCubit>().state;
            if (connectivityState is ConnectivityConnect &&
                authState is AuthLogInSuccess) {
              //return MainScreen();
            }
            return const OnBoardingScreen();
          }),
        ));
  }
}
