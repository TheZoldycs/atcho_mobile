import 'package:flutter/animation.dart';
import 'package:atcho/app/app.locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:atcho/services/token_service.dart';

class OnBoardingViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();
  final _tokenService = locator<TokenService>();
  dynamic usersCount;

  Future<String?> getLang() async {
    return await _tokenService.getLangValue();
  }

  void navigateTo({view}) {
    _navigationService.replaceWithTransition(view, curve: Curves.easeIn);
  }
}