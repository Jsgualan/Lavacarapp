import 'package:geolocator/geolocator.dart' as geolocation;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart' as permit;
import 'package:permission_handler/permission_handler.dart';

import '../provider/providerMap.dart';

class Gps {
  final geolocation.GeolocatorPlatform _geolocationPlatform =
      geolocation.GeolocatorPlatform.instance;

  Future checkGPS(ProviderMap providerMap) async {
    final status = await permit.Permission.locationWhenInUse.request();
    if (status == permit.PermissionStatus.granted) {
      if (!(await geolocation.Geolocator.isLocationServiceEnabled())) {
        geolocation.Geolocator.openLocationSettings();
        return false;
      } else {
        positionInitial(providerMap);
        return true;
      }
    } else {
      openAppSettings();
      return false;
    }
  }

  positionInitial(ProviderMap providerMap) async {
    final positionStream = _geolocationPlatform.getPositionStream();
    positionStream.handleError((error) {
      checkGPS(providerMap);
    }).listen((position) {
      providerMap.positionDefault =
          LatLng(position.latitude, position.longitude);
    });
    providerMap.centerLocationMap();
  }
}
