import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:covid19/providers/country-provider.dart';
import 'package:covid19/providers/global-provider.dart';
import 'package:covid19/providers/one-country-provider.dart';
import 'package:covid19/providers/travel-alert-provider.dart';
import 'package:covid19/tabview.dart';
import 'package:covid19/themes/dark-theme.dart';
import 'package:covid19/themes/light-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;

  const MyApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: [
        Provider(create: (_) => GlobalProvider()),
        Provider(create: (_) => TravelAlertProvider()),
        Provider(create: (_) => OneCountryProvider()),
        FutureProvider(create: (_) => CountryProvider().getCountry()),
        FutureProvider(create: (_) => SharedPreferences.getInstance()),
        Provider(create: (_) => SharedPreferences.getInstance()),
        // StreamProvider(create: (_) => SharedPreferences.getInstance().asStream())
      ],
      child: AdaptiveTheme(
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        light: LightTheme.theme,
        dark: DarkTheme.theme,
        builder: (light, dark) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Covid 19 Tracker',
            theme: light,
            darkTheme: dark,
            home: TabView(),
          );
        },
      ),
    );
  }
}
