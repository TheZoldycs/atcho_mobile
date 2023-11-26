
import 'package:flutter/cupertino.dart';
import 'package:atcho/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PeopleViewModel extends BaseViewModel {
  PeopleViewModel({this.context});
  BuildContext? context;

  List staticPeople = ["Djalil", "Aya", "Michael", "Tai"];

  final _navigationService = locator<NavigationService>();

  navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }
}