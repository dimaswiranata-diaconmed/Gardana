import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import './scoped-models/main.dart';
import 'package:gardana/pages/login_page.dart';
import './helpers/translation/application.dart';
import './helpers/translation/app_translations_delegate.dart';
import 'package:gardana/helpers/adaptive_theme.dart';

List<CameraDescription> _cameras = [];

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code + ': ' + e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final MainModel _model = MainModel();
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  SharedPreferences prefs;
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Firebase.initializeApp();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    // main navigator used for notification routing
    _model.navigatorKey = navigatorKey;
    // set device cameras
    _model.device.cameras = _cameras;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// function to change app language
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: getAdaptiveTheme(context),
          localizationsDelegates: [
            _newLocaleDelegate,
            //provides localised strings
            GlobalMaterialLocalizations.delegate,
            //provides RTL support
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale("id", ""),
            // const Locale("en", ""),
          ],
          routes: {
            '/': (BuildContext context) => LoginPage(_model),
          }),
    );
  }
}