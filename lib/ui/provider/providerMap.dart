import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderMap with ChangeNotifier {
  GoogleMapController? _googleMapController;
  LatLng? _positionDefault;

  GoogleMapController get googleMapController => _googleMapController!;

  set googleMapController(GoogleMapController value) {
    _googleMapController = value;
    notifyListeners();
  }

  LatLng? get positionDefault => _positionDefault;

  set positionDefault(LatLng? value) {
    if (value != null) {
      _positionDefault = value;
    }
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
                LatLng(_positionDefault!.latitude, _positionDefault!.longitude),
            zoom: 16.8),
      ),
    );
    notifyListeners();
  }

  onCameraMove(CameraPosition position) async {}
}
