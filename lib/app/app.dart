import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:ecommerce2/app/routes/routes.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:ecommerce2/app/theme/app_theme.dart';
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
        title: 'E-commerce (BLoC)',
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
