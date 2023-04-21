import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/dispositive.dart';
import 'global_color.dart';
import 'global_label.dart';
import 'global_preference.dart';
import 'global_widget.dart';

class GlobalFunction {
  static GlobalKey<NavigatorState> contextGlobal = GlobalKey<NavigatorState>();
  LatLng positionInitial = const LatLng(-4.0008182, -79.2042697);
  Dispositive? dispositive;
  IosDeviceInfo? iosDeviceInfo;
  AndroidDeviceInfo? androidDeviceInfo;
  final DeviceInfoPlugin? deviceInfoPlugin = DeviceInfoPlugin();
  PackageInfo? packageInfo;
  DateTime dateNow = DateTime.now();
  final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
  String? selectDay = '';

  /// Get information dispositive
  informationDispositive() async {
    packageInfo = await PackageInfo.fromPlatform();
    dispositive = Dispositive();
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin!.androidInfo;
      dispositive!.imei = androidDeviceInfo!.id!;
      dispositive!.model = androidDeviceInfo!.model;
      dispositive!.brand =
          '${androidDeviceInfo!.manufacturer} ${androidDeviceInfo!.model}';
      dispositive!.version = packageInfo!.version;
      dispositive!.versionSystem = androidDeviceInfo!.version.release;
    } else {
      iosDeviceInfo = await deviceInfoPlugin!.iosInfo;
      dispositive!.imei = iosDeviceInfo!.identifierForVendor!;
      dispositive!.model = iosDeviceInfo!.model;
      dispositive!.brand = iosDeviceInfo!.name;
      dispositive!.version = packageInfo!.version;
      dispositive!.versionSystem = iosDeviceInfo!.systemVersion;
    }
    GlobalPreference().setDataDispositive(dispositive);
  }

  /// Format date
  formatDate(String date) {}

  /// Get format day
  getFormatDay(int day) {
    switch (day) {
      case 1:
        selectDay = 'Lunes';
        break;
      case 2:
        selectDay = 'Martes';
        break;
      case 3:
        selectDay = 'Miercoles';
        break;
      case 4:
        selectDay = 'Jueves';
        break;
      case 5:
        selectDay = 'Viernes';
        break;
      case 6:
        selectDay = 'Sabado';
        break;
      case 7:
        selectDay = 'Domingo';
        break;
    }
    return selectDay;
  }

  /// Quit focus text field
  deleteFocusForm() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  /// Close view active
  closeView() {
    Navigator.of(GlobalFunction.contextGlobal.currentContext!).pop(true);
  }

  /// Show message alert
  messageAlert(String message) {
    final snackBar = SnackBar(
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Container(
            child: GlobalWidget().styleTextTitle(
                message, GlobalColor.colorWhite, 14.0, TextAlign.left)),
        backgroundColor: GlobalColor.colorBackgroundAlert);
    ScaffoldMessenger.of(GlobalFunction.contextGlobal.currentContext!)
        .showSnackBar(snackBar);
  }

  /// Generate text with encryption MD5
  generatedMd5(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }

  /// Generate id
  generateId() {
    return dateNow.millisecondsSinceEpoch.toString();
  }

  /// Message confirmation
  messageConfirmation(String description, VoidCallback? callbackAccept,
      {title = GlobalLabel.textConfirmation}) async {
    return Alert(
      context: GlobalFunction.contextGlobal.currentContext!,
      type: AlertType.none,
      title: title,
      desc: description,
      style: AlertStyle(
        isCloseButton: true,
        isOverlayTapDismiss: true,
        descStyle: const TextStyle(
            fontFamily: GlobalLabel.typeLetterSubTitle, fontSize: 16.0),
        descTextAlign: TextAlign.center,
        animationDuration: const Duration(milliseconds: 250),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        titleStyle: const TextStyle(
            color: GlobalColor.colorLetterTitle,
            fontSize: 18.0,
            fontFamily: GlobalLabel.typeLetterTitle),
        alertAlignment: Alignment.center,
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(GlobalFunction.contextGlobal.currentContext!);
          },
          color: GlobalColor.colorButton,
          child: const Text(
            GlobalLabel.buttonCancel,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: GlobalLabel.typeLetterTitle),
          ),
        ),
        DialogButton(
          onPressed: () {
            Navigator.pop(GlobalFunction.contextGlobal.currentContext!);
            if (callbackAccept != null) {
              callbackAccept();
            }
          },
          color: GlobalColor.colorButton,
          child: const Text(
            GlobalLabel.buttonAccept,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: GlobalLabel.typeLetterTitle),
          ),
        )
      ],
    ).show();
  }

  /// Open google map
  openGoogleMaps(double latitude, double longitude) async {
    Uri url1, url2;
    if (Platform.isAndroid) {
      url2 = Uri.parse(
          "https://play.google.com/store/apps/details?id=com.google.android.apps.maps");
      url1 = Uri.parse("google.navigation:q=$latitude,$longitude&mode=a");
    } else {
      url2 = Uri.parse(
          "https://apps.apple.com/es/app/google-maps-routes-y-comida/id585027354");
      url1 = Uri.parse("https://maps.apple.com/?q=$latitude,$longitude");
    }
    if (await canLaunchUrl(url1)) {
      await launchUrl(url1);
    } else {
      await launchUrl(url2);
    }
  }

  /// Show progress
  showProgress() {
    showDialog(
      useSafeArea: false,
      useRootNavigator: false,
      barrierColor: GlobalColor.colorLetterTitle.withOpacity(.8),
      context: GlobalFunction.contextGlobal.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  size: 50,
                  color: GlobalColor.colorPrincipal,
                ),
                GlobalWidget().styleTextTitle(GlobalLabel.textWait,
                    GlobalColor.colorWhite, 0.0, TextAlign.center)
              ],
            ),
          ),
        );
      },
    );
  }

  /// Hide progress
  hideProgress() {
    Navigator.of(GlobalFunction.contextGlobal.currentContext!).pop();
  }
}
