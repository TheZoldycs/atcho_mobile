// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  Future<bool> isTokenExist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool exist = prefs.containsKey('token');
    return exist;
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void setTokenValue(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lang');
  }

  void setLangValue(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }

  Future<String> getLangValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lang') ?? Platform.localeName.substring(0, 2);
  }

  Future<void> clearCacheAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
