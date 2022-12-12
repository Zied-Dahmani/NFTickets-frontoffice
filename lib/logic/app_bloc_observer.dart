import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase cubit) {
    super.onCreate(cubit);
    stderr.writeln(cubit);
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    stderr.writeln(change);
  }

  @override
  void onClose(BlocBase cubit) {
    super.onClose(cubit);
    stderr.writeln(cubit);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    stderr.writeln(cubit);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    stderr.writeln(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    stderr.writeln(bloc);
  }
}
