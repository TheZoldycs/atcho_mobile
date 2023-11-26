import 'package:atcho/app/app.locator.dart';
import 'package:atcho/services/connectivity_service.dart';
import 'package:stacked/stacked.dart';

class IndexViewModel extends IndexTrackingViewModel {
  bool? thereIsConnection = true;
  final _connectivityService = locator<ConnectivityService>();
  bool? isReload = false;

  updateIsReload() {
    isReload = !isReload!;
    notifyListeners();
  }

  getConnectivityStatus({context}) {
    setIndex(1);
    _connectivityService.checkConnectivity(() {
      thereIsConnection = true;
      notifyListeners();
    }, () {
      thereIsConnection = false;
      notifyListeners();
    });
  }
}