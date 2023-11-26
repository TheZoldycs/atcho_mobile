// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked/stacked_annotations.dart' as annotations;
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:atcho/services/api_service.dart';
import 'package:atcho/services/connectivity_service.dart';
import 'package:atcho/services/token_service.dart';
import 'package:atcho/services/validation_service.dart';

final locator = annotations.StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, annotations.EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => TokenService());
  locator.registerLazySingleton(() => ValidationService());
}
