import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:atcho/services/api_service.dart';
import 'package:atcho/services/connectivity_service.dart';
import 'package:atcho/services/token_service.dart';
import 'package:atcho/services/validation_service.dart';
import 'package:atcho/ui/views/navbar/people/people_view.dart';
import 'package:atcho/ui/views/splash/splash_view.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: TokenService),
    LazySingleton(classType: ValidationService),
  ],
  routes: [
    MaterialRoute(
      page: SplashView,
      name: 'splashView',
      initial: true,
    ),
    MaterialRoute(
      page: PeopleView,
      name: 'homeView',
    ),
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}