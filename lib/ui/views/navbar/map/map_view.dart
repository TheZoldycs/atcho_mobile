import 'package:atcho/ui/views/ar_view.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:atcho/ui/views/navbar/map/map_viewmodel.dart';
import 'package:styled_widget/styled_widget.dart';

class MapView extends HookWidget {
  const MapView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Stack(
            children: [
              model.isBusy ? const Loader(color: kMainColor1,) : GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: model.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  model.controller.complete(controller);
                },
                onTap: (l) {
                  print(l);
                },
                padding: const EdgeInsets.symmetric(horizontal: 20),
                markers: model.customMarkers.toSet(),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
              Positioned(
                top: 25,
                left: 10,
                right: 10,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/store${(1 % 2) + 1}.png"),
                      horizontalSpaceRegular,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((1 % 2) + 1 == 0 ? "Lidl Store" : "Royal Store", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                          verticalSpaceTiny,
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp, color: kMainColor1, size: 18),
                              horizontalSpaceTiny,
                              Text((1 % 2) + 1 == 0 ? "40 Mtr left" : "500 Mtr left", style: TextStyle(color: Colors.black),),
                            ],
                          ),

                        ],
                      ),
                      const Spacer(),
                      const Text("Track", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xff0070F0)),),
                      horizontalSpaceSmall,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 10,
                left: 10,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          verticalSpaceRegular,
                          const Text("Store Royal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          const Text("Store Royal located near you", style: TextStyle(color: Colors.grey)),
                          verticalSpaceRegular,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFE9C9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.info_outline, size: 20),
                                        horizontalSpaceTiny,
                                        Text("3 minutes left", ),
                                      ],
                                    ),
                                    verticalSpaceSmall,
                                    Image.asset("assets/icons/percent.png"),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: kMainColor1,
                                  ),
                                  child: const Center(
                                    child: Text('Switch to AR', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -185,
                      left: 10,
                      right: 10,
                      child: Image.asset("assets/icons/store_near.png"),
                    ),
                  ],
                ).gestures(
                  onTap: () => model.navigateTo(view: const ArView()),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MapViewModel(),
      onViewModelReady: (model) => model.mapToMarkers(),
    );
  }
}
