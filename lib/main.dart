import 'package:dashboardstore/components/constants.dart';
import 'package:dashboardstore/components/theme/theme.dart';
import 'package:dashboardstore/firebase_options.dart';
import 'package:dashboardstore/network/dioapp.dart';
import 'package:dashboardstore/view/screen/auth/signin.dart';
import 'package:dashboardstore/view/screen/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'locale/locale.dart';
import 'network/cachehelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  await CacheHelper.init();
  await DioApp.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scrollBehavior: ScrollBehavior(),
        locale: Locale(trans() == 'ar' ? 'ar_eg' : 'en_us'),
        translations: LocaleApp(),
        debugShowCheckedModeBanner: false,
        home: id == null ? SigninScreen() : HomeScreen(),
        themeMode: ThemeMode.dark,
        darkTheme: themeData);
  }
}
