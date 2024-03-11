import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/providers/LandRegisterModel.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'constant/routes.dart';
import 'providers/MetamaskProvider.dart';
import 'dart:js' as js;

void main() {
  setPathUrlStrategy();
  js.context.callMethod('setPageTitle', ['Land Registry App']); // Set initial title
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  void updatePageTitle(String title) {
  js.context.callMethod('setPageTitle', [title]);
}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LandRegisterModel>(
          create: (context) => LandRegisterModel(),
        ),
        ChangeNotifierProvider<MetaMaskProvider>(
          create: (context) => MetaMaskProvider()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Land Registry App',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
