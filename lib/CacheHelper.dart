import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper{
  static SharedPreferences? sharedPreferences1;
  static init() async{
    sharedPreferences1=await SharedPreferences.getInstance();
  }
  static Future<bool> putbool({required String key,required bool value}) async{
    return sharedPreferences1!.setBool(key, value);
  }

  static bool? getbool({required String key}){
    return sharedPreferences1!.getBool(key);
  }

  static Future<bool> putstring({required String key,required String? value}) async{
    return sharedPreferences1!.setString(key, value!);
  }
  static String? getstring({required String key}){
    return sharedPreferences1!.getString(key);
  }

  static Future<bool> StringList({required String key,required List<String> value}) async{
    return sharedPreferences1!.setStringList(key, value);
  }

  static List<String>? getStringList({required String key}){
    return sharedPreferences1!.getStringList(key);
  }

}