import 'package:geolocator/geolocator.dart' as geolocation;

import 'package:permission_handler/permission_handler.dart' as permit;
import 'package:permission_handler/permission_handler.dart';

import '../provider/providerMap.dart';
import 'global_function.dart';
import 'global_label.dart';

class Gps {
  final geolocation.GeolocatorPlatform _geolocationPlatform =
      geolocation.GeolocatorPlatform.instance;

  Future checkGPS(ProviderMap providerMap) async {
    final status = await permit.Permission.locationWhenInUse.request();
    if (status == permit.PermissionStatus.granted) {
      final locationServiceEnabled =
          await geolocation.Geolocator.isLocationServiceEnabled();
      if (locationServiceEnabled) {
        positionInitial(providerMap);
        return true;
      } else {
        GlobalFunction().messageAlert(GlobalLabel.textGPSDisable);
        return false;
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
      providerMap.positionDefault = position;
    });
    providerMap.centerLocationMap();
  }
}
