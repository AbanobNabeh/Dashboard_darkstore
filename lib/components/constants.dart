import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../network/cachehelper.dart';

var id = CacheHelper.getData(key: "id");
var onboarding = CacheHelper.getData(key: "onboarding");
var lang = CacheHelper.getData(key: "lang");
HexColor defcolor = HexColor('2E2E47');
HexColor defgraycolor = HexColor('3D3D5A');
HexColor secondcolor = HexColor('5C87FF');

// getlang
String trans() {
  if (lang == null) {
    if (Get.deviceLocale.toString() == 'ar_EG') {
      return "ar";
    } else {
      return "en";
    }
  } else {
    if (lang == 'ar') {
      return "ar";
    } else {
      return "en";
    }
  }
}
// end