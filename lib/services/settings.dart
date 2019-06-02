import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quotz/models/settings.dart';

class SettingsService{
  Future<Settings> getSettings() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    String settings = pref.getString("settings");
    if(settings != null){
      Map<String, dynamic> settingsData = jsonDecode(settings);
      return Settings.fromMap(settingsData);
    } else{
      return Settings(
        refreshPeriod: RefreshPeriod.hours,
        refreshPeriodValue: 2,
        quoteLength: QuoteLength.random,
        category: QuoteCategory.random
      );
    }
  }

  Future<bool> storeSettings(Settings settings) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("settings", jsonEncode(settings));
    return true;
  }
}