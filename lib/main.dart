// import 'package:firebase_core/firebase_core.dart';

import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';

// import 'firebase_options.dart';

/* This is an E-Commerce project (BLoC)
  * Completed by TAMIM HASAN
  * Date: 22-01-2025
  */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Dependencies
  configureDependencies();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    debugPrint('Bloc ${bloc.runtimeType} is closed.');
    super.onClose(bloc);
  }
}
