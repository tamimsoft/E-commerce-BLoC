import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:fakestore/app/config/routes/routes.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(getIt()),
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Fake Store',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: RoutesName.initial,
      ),
    );
  }
}

//
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
