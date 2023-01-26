import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../components/constants.dart';
import '../network/cachehelper.dart';

class LocaleController extends GetxController {
  void changelang(lange) {
    Locale locale = Locale(lange);
    lang = lange;
    CacheHelper.saveData(key: 'lang', value: lange);
    Get.updateLocale(locale);
  }
}
