import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:andit/screens/login_screen/login_screen.dart';
import 'package:andit/screens/login_screen/forgot_password_screen.dart';
import 'package:andit/screens/tabbar_screen.dart';
import 'package:andit/utils/app_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';
import 'package:andit/utils/themes.dart';

import 'package:andit/view_models/tabber_view_model.dart';
import 'package:andit/view_models/search_place_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      supportedLocales: const [Locale('en')],
      useOnlyLangCode: true,
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TabbarViewModel(),
            lazy: true,
          ),
          ChangeNotifierProvider(
            create: (context) => PlaceResultsViewModel(),
            lazy: true,
          ),
          ChangeNotifierProvider(
            create: (context) => SearchToggleViewModel(),
            lazy: true,
          ),
          ChangeNotifierProvider(
            create: (context) => ApplicationState(),
            lazy: false,
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: MyTheme.lightTheme,
        dark: MyTheme.darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return MaterialApp(
            title: 'Trace food map',
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            localizationsDelegates: [
              FormBuilderLocalizations.delegate,
              ...context.localizationDelegates
            ],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routes: {
              '/sign-in': ((context) {
                return const LoginScreen();
              }),
              '/forgot-password': ((context) {
                return const ForgotPasswordScreenMain();
              }),
            },
            home: Builder(
              builder: (context) {
                AppConfig().setConfig(context);
                EasyLoading.instance
                  ..indicatorType = EasyLoadingIndicatorType.circle
                  ..loadingStyle = EasyLoadingStyle.dark
                  ..indicatorWidget = SpinKitWave(
                    color: Theme.of(context).primaryColor,
                  )
                  ..radius = 16.0;
                return const TabbarScreen();
              },
            ),
          );
        });
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  String userName = 'Null';
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  String? getEmail() {
    return userName;
    return 'Null';
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(
          clientId:
              '209344773710-gsg7t2tpih3un6nth9l22j2kbcd370ue.apps.googleusercontent.com'),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        userName = user.email!;
      } else {
        userName = 'Null';
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
