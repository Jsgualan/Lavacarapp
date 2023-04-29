import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/providerMapa.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import '../util/style_map.dart';


class PageMap extends StatefulWidget {
  static const route = GlobalLabel.routeMap;

  @override
  State<PageMap> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  ProviderMap? _providerMap;
  ProviderReserve? _providerReserve;
  LatLng? _latLng;

  @override
  Widget build(BuildContext context) {
    if (_providerMap == null) {
      _providerMap = Provider.of<ProviderMap>(context);
      _providerReserve = Provider.of<ProviderReserve>(context);
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textMap),
          body: SafeArea(
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(3),
                  height: MediaQuery.of(context).size.height,
                  color: GlobalColor.colorBackground,
                  child: Stack(
                    children: [
                      // googleMap(),
                      pinLocation(),
                      setLocation(),
                      myLocation()
                    ],
                  ))),
        ));
  }

  Widget googleMap() {
    return GoogleMap(
      minMaxZoomPreference: const MinMaxZoomPreference(15, 16.8),
      initialCameraPosition: CameraPosition(
        target: GlobalFunction().positionInitial,
        zoom: 16.8,
      ),
      onMapCreated: (GoogleMapController controller) {
        _providerMap!.googleMapController = controller;
        _providerMap!.googleMapController.setMapStyle(jsonEncode(styleMap));
        _providerMap!.googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: GlobalFunction().positionInitial, zoom: 16.8),
          ),
        );
      },
      myLocationButtonEnabled: false,
      // markers: Set<Marker>.of(_providerPrincipal!.markers),
      compassEnabled: false,
      zoomControlsEnabled: false,
      buildingsEnabled: false,
      onCameraMove: (position) {
        _latLng = position.target;
      },
    );
  }


  Widget myLocation() {
    return Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            _providerMap!.centerLocationMap();
          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 200, right: 20),
              child: const CircleAvatar(
                  backgroundColor: GlobalColor.colorWhite,
                  child: Icon(
                    Icons.my_location,
                    size: 30,
                    color: GlobalColor.colorLetterTitle,
                  ))),
        ));
  }

  Widget pinLocation() {
    return const Center(child: Icon(Icons.location_on_rounded, size: 50));
  }

  Widget setLocation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
          child: GlobalWidget().styleTextButton(GlobalLabel.buttonSetLocation),
          onPressed: () {
            _providerReserve!.latitudeReserve = _latLng!.latitude;
            _providerReserve!.longitudeReserve = _latLng!.longitude;
            GlobalFunction().closeView();
          },
        ),
      ),
    );
  }
}
