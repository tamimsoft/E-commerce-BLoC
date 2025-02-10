import 'package:fakestore/app/config/routes/routes.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Fake Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: Routes.generateRoutes,
      initialRoute: RoutesName.initial,
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
