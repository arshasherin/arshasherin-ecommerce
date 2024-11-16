
import 'package:ecommerce/Screens.dart/Login/login._screen.dart';
import 'package:ecommerce/Screens.dart/Login/loginvm.dart';
import 'package:ecommerce/Screens.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens.dart/honevm.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => HomeDashboardVm()), ChangeNotifierProvider(create: (context) => LoginViewModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: const HomeDashboard(),
    );
  }
}
