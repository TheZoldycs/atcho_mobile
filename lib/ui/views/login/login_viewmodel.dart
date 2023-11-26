import 'package:flutter/material.dart';
import 'package:atcho/app/app.locator.dart';
import 'package:atcho/services/api_service.dart';
import 'package:atcho/services/token_service.dart';
import 'package:atcho/services/validation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({this.lang});
  String? lang;

  bool isObscure = true;
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _validationService = locator<ValidationService>();
  final _tokenService = locator<TokenService>();
  bool? isClicked = false;

  updateLang({value, BuildContext? context}) {
    lang = value;
    setLang(lang: lang, context: context);
    notifyListeners();
  }

  setLang({lang, BuildContext? context}) {
    _tokenService.setLangValue(lang);

    if (lang == "ar") {
      context!.setLocale(const Locale('ar', 'DZ'));
    } else if (lang == "fr") {
      context!.setLocale(const Locale('fr', 'FR'));
    } else {
      context!.setLocale(const Locale('en', 'UK'));
    }
  }

  updateIsClicked({value}) {
    isClicked = value;
    notifyListeners();
  }

  String? validateEmail ({String? value}) {
    return _validationService.validateEmail(value);
  }

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  void clearAndNavigateTo({view}) {
    _navigationService.clearStackAndShowView(view,);
  }


  String? validatePassword ({String? value}) {
    return _validationService.passwordValidation(value);
  }

  Future<String?> login({Map<String, dynamic>? body, context}) async {

    updateIsClicked(value: true);
    return await _apiService.login(
      body: body,
      context: context
    ).catchError((e) {
      updateIsClicked(value: false);
    });
  }
}