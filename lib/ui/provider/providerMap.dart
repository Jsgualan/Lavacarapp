import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderMap with ChangeNotifier {
  GoogleMapController? _googleMapController;
  Position _positionDefault = const Position(
      longitude: -79.201673,
      latitude: -3.996744,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  GoogleMapController get googleMapController => _googleMapController!;

  set googleMapController(GoogleMapController value) {
    _googleMapController = value;
    notifyListeners();
  }

  Position get positionDefault => _positionDefault;

  set positionDefault(Position value) {
    _positionDefault = value;
    notifyListeners();
  }

  /// Center pin location in the map
  centerLocationMap() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_googleMapController == null) return;
    _googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
            LatLng(_positionDefault.latitude, _positionDefault.longitude),
            zoom: 16.8,
            bearing: positionDefault.speed > 8 ? positionDefault.heading : 0),
      ),
    );
    notifyListeners();
  }


  onCameraMove(CameraPosition position) async {

  }
}
