import 'package:flutter/material.dart';
import 'package:lavacar/ui/page/page_log_in.dart';
import 'package:lavacar/ui/page/page_principal.dart';
import 'package:lavacar/ui/provider/provider_principal.dart';
import 'package:lavacar/ui/util/global_preference.dart';

import '../util/global_function.dart';
import '../util/global_widget.dart';

class ProviderSplash with ChangeNotifier {
  String? _versionApp = '';

  String get versionApp => _versionApp!;

  set versionApp(String value) {
    _versionApp = value;
  }

  /// Get data dispositive and initial application
  startApplication(ProviderPrincipal providerPrincipal) {
    Future.delayed(const Duration(seconds: 4), () {
      GlobalFunction().informationDispositive();
      GlobalPreference.getDataDispositive().then((data) {
        if (data != null) {
          _versionApp = data.version;
          notifyListeners();
        }
      });
      GlobalPreference.getStateLogin().then((state) {
        if (state) {
          GlobalPreference.getDataUser().then((user) {
            providerPrincipal.user = user!;
          });
          GlobalWidget().animationNavigatorView(PagePrincipal());
        } else {
          GlobalWidget().animationNavigatorView(PageLogIn());
        }
      });
    });
  }
}
