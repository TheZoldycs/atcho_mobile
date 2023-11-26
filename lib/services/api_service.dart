// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/resources/arrays.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:atcho/app/app.locator.dart';
import 'package:atcho/services/token_service.dart';
import 'package:atcho/shared/app_configs.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/views/splash/splash_view.dart';

class ApiService {
  final _tokenService = locator<TokenService>();
  final _navigationService = locator<NavigationService>();

  Future<String?> login({Map? body, context}) async {
    return http.post(
      Uri.parse("$baseUrl/api/accounts/login/"),
      body: body,
      headers: {
        "Accept-Language": await getCurrentLanguage(),
      },
    ).then((response) async {
      if (response.statusCode == 200) {
        _tokenService.setTokenValue(jsonDecode(utf8.decode(response.bodyBytes))['access']);
        return jsonDecode(utf8.decode(response.bodyBytes))['access'];
      } else {
        showMotionToast(context: context, title: "Login Failed".tr(), msg: jsonDecode(utf8.decode(response.bodyBytes))["message"], type: MotionToastType.error);
        return null;
      }
    });
  }

  Future<WebSocketChannel?> webSocket({String? token}) async {
    final wsUrl = Uri.parse('ws://atcho.com:8001/ws/?token=$token');
    var channel = IOWebSocketChannel.connect(
      wsUrl,
      protocols: {'http'},
      connectTimeout: const Duration(seconds: 10),
    );

    return channel;
  }

  logout({context}) {
    showMotionToast(context: context!, type: MotionToastType.error, msg: "See you soon, Have a good day".tr(),);
    _tokenService.clearToken();
    Timer(const Duration(milliseconds: 1000), () {
      _navigationService.clearStackAndShowView(const SplashView());
    });
  }

  Future<String> getCurrentLanguage() async {
    return await _tokenService.getLangValue();
  }

  unAuthClearAndRestart({BuildContext? context}) {
    showMotionToast(context: context!, type: MotionToastType.error, msg: "Your session has expired, you must login again".tr(), title: 'Unauthorized'.tr());
    _tokenService.clearToken();
    Timer(const Duration(milliseconds: 1000), () {
      _navigationService.clearStackAndShowView(const SplashView());
    });
  }
}