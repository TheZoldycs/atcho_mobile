import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:workmanager/workmanager.dart';
import 'package:atcho/app/app.locator.dart';
import 'package:atcho/foreground_notifications.dart';
import 'package:atcho/services/api_service.dart';
import 'package:atcho/services/token_service.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/views/index/index_viewmodel.dart';
import 'package:atcho/ui/views/navbar/people/people_view.dart';
import 'package:atcho/ui/views/navbar/profile/profile_view.dart';
import 'package:atcho/ui/views/navbar/map/map_view.dart';
import 'package:atcho/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:atcho/ui/widgets/nav_item.dart';

class WebSocketListener extends StatelessWidget {
  const WebSocketListener({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebSocketListenerViewModel>.reactive(
      viewModelBuilder: () => WebSocketListenerViewModel(),
      builder: (context, model, child) {
        return !model.dataReady ? const SizedBox() : StreamBuilder<dynamic>(
          stream: model.data!.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LocalNotificationService.display(jsonDecode(snapshot.data));
              Workmanager().registerPeriodicTask(
                "2",
                "simplePeriodicTask",
                inputData: jsonDecode(snapshot.data),
                frequency: const Duration(seconds: 1),
              );
            }

            return const IndexView();
          },
        );
      },
    );
  }
}

class WebSocketListenerViewModel extends FutureViewModel<WebSocketChannel?> {
  final _apiService = locator<ApiService>();
  final _tokenService = locator<TokenService>();

  Future<WebSocketChannel?> getWebSocket() async {
    String? token = await _tokenService.getTokenValue();

    LocalNotificationService.initialize();

    return _apiService.webSocket(token: token);
  }

  @override
  Future<WebSocketChannel?> futureToRun() {
    return getWebSocket();
  }
}

class IndexView extends StatelessWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IndexViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: !model.thereIsConnection! ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Internet Connection, please check your internet'.tr()).center(),
              verticalSpaceSmall,
              Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kMainColor1,
                ),
                child: model.isReload! ? const Loader().center() : Center(
                  child: Text('Reload internet'.tr(), style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                ),
              ).gestures(
                onTap: () {
                  model.updateIsReload();
                  model.getConnectivityStatus();
                },
              )
            ],
          ) : model.isBusy ? const Loader() : PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: model.reverse,
            transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation,) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: getViewForIndex(index: model.currentIndex, ),
          ),
          bottomNavigationBar: Container(
            alignment: Alignment.bottomCenter,
            height: 65,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  onTap: () => model.setIndex(0),
                  label: 'People'.tr(),
                  isSelected: model.currentIndex == 0,
                  image: "assets/icons/people.svg",
                ),
                NavItem(
                  onTap: () => model.setIndex(1),
                  label: 'Map'.tr(),
                  isSelected: model.currentIndex == 1,
                  image: "assets/icons/map.svg",
                ),
                NavItem(
                  onTap: () => model.setIndex(2),
                  label: 'Profile'.tr(),
                  isSelected: model.currentIndex == 2,
                  image: "assets/icons/profile.svg",
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => IndexViewModel(),
      onViewModelReady: (model) => model.getConnectivityStatus(context: context),
    );
  }

  Widget getViewForIndex({int? index, }) {
    switch (index) {
      case 0:
        return const PeopleView();
      case 1:
        return const MapView();
      case 2:
        return const ProfileView();
      default:
        return Container();
    }
  }
}