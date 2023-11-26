import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:atcho/app/app.locator.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MapViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool isClicked = false;

  updateIsClicked({value}) {
    isClicked = value;
    notifyListeners();
  }

  void back() {
    _navigationService.back();
  }

  void navigateTo ({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(47.5166493182103, 18.991115768181448),
    // target: LatLng(36.2037100133405, 5.450100291943157),
    zoom: 13.4746,
  );

  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  List<Marker> customMarkers = [];

  List<LatLng> stores = [
    const LatLng(47.51693915731245, 18.98930259490486),
    const LatLng(47.516388461649484, 18.992714364738916),
    const LatLng(47.5168435777756, 18.990990530643998),
    const LatLng(47.517281958963224, 18.99144280483911),
    const LatLng(47.51565111063175, 18.990863859612244),
    const LatLng(47.49788405182449, 19.040183898682674),
    const LatLng(47.4978741720657, 19.040409747461933),
    const LatLng(47.49796748082463, 19.039972673205664),
    const LatLng(47.498013586267824, 19.04032525727113),
    const LatLng(47.49760961338886, 19.0402586400053),
  ];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

  mapToMarkers() async {
    await _determinePosition().then((position) async {
      final Uint8List meIcon = await getBytesFromAsset('assets/icons/position.png', 100);

      customMarkers.add(
        Marker(
          markerId: const MarkerId("me"),
          icon: await BitmapDescriptor.fromBytes(meIcon),
          position: LatLng(position.latitude, position.longitude),
        ),
      );

      notifyListeners();
    });



    final Uint8List storeIcon = await getBytesFromAsset('assets/icons/stores_map.png', 100);

    for (var store in stores) {
      customMarkers.add(
        Marker(
          markerId: MarkerId("store${store.latitude}"),
          icon: await BitmapDescriptor.fromBytes(storeIcon),
          position: LatLng(store.latitude, store.longitude),
        ),
      );
    }
    notifyListeners();
  }
}