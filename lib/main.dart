import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nftickets/logic/cubits/auth/auth_cubit.dart';
import 'package:nftickets/logic/cubits/auth/auth_state.dart';
import 'package:nftickets/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:nftickets/presentation/screens/main_screen.dart';
import 'package:nftickets/presentation/screens/on_boarding_screen.dart';
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
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit(), lazy: true),
          BlocProvider<ConnectivityCubit>(create: (context) => ConnectivityCubit(), lazy: true),
        ],
        child: MaterialApp(
          title: 'NFTickets',
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: _appRouter.onGenerateRoute,
          home: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            if (state is AuthLogInSuccess) {
              return const MainScreen();
            }
            return const OnBoardingScreen();
          }),
        ));
  }
}
