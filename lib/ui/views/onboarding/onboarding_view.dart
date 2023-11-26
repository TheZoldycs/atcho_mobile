import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:atcho/ui/views/index/index_view.dart';
import 'package:atcho/ui/views/login/login_view.dart';
import 'package:atcho/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:atcho/ui/views/onboarding_views/onboarding1.dart';
import 'package:atcho/ui/views/onboarding_views/onboarding2.dart';
import 'package:atcho/ui/views/onboarding_views/onboarding3.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverse: model.reverse,
                  transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      ) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: getViewForIndex(
                    index: model.currentIndex,
                    toPage2: () => model.setIndex(1),
                    toPage3: () => model.setIndex(2),
                    createAccount: () => model.navigateTo(view: const WebSocketListener()),
                    passer: () => model.setIndex(2),
                    login: () async {
                      String? lang = await model.getLang();
                      model.navigateTo(view: LoginView(lang: lang,));
                    },
                    usersCount: model.usersCount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => OnBoardingViewModel(),
    );
  }

  Widget getViewForIndex({int? index, Function()? toPage2, Function()? toPage3,
        Function()? createAccount, Function()? passer, Function()? login, usersCount}) {
    switch (index) {
      case 0:
        return OnBoarding1(onTap: () => toPage2!, passer: () => passer!, login: () => login, usersCount: usersCount);
      case 1:
        return OnBoarding2(onTap: () => toPage3!, passer: () => passer!, login: () => login, usersCount: usersCount);
      case 2:
        return OnBoarding3(onTap: () => createAccount!, login: () => login, usersCount: usersCount);
      default:
        return Container();
    }
  }
}
