import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../provider/provider_log_in.dart';
import 'global_color.dart';
import 'global_function.dart';
import 'global_label.dart';

class GlobalWidget {
  /// Set color bar in the splash
  SystemUiOverlayStyle colorBarSplash(Color color) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: color,
    );
  }

  /// Set color bar in all view
  SystemUiOverlayStyle colorBarView(Color color) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: color,
    );
  }

  /// Style text subtitle
  Widget styleTextSubTitle(
      String title, Color color, double size, TextAlign align) {
    return Text(title,
        style: TextStyle(
            fontFamily: GlobalLabel.typeLetterSubTitle,
            color: color,
            fontSize: size == 0.0 ? 15.0 : size),
        textAlign: align);
  }

  /// Style text title
  Widget styleTextTitle(
      String title, Color color, double size, TextAlign align) {
    return Text(title,
        style: TextStyle(
            fontFamily: GlobalLabel.typeLetterTitle,
            color: color,
            fontSize: size == 0.0 ? 15.0 : size),
        textAlign: align);
  }

  /// Style text field
  Widget textField(type, double longitude, identifier, String nameTextField,
      IconData icon, int limitCharacter) {
    return Container(
        height: 60.0,
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: identifier,
          autocorrect: true,
          autofocus: false,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [
            LengthLimitingTextInputFormatter(limitCharacter),
          ],
          keyboardType: type,
          style: TextStyle(
              fontSize: 16,
              color: GlobalColor.colorLetterTitle.withOpacity(.8),
              fontFamily: GlobalLabel.typeLetterTitle),
          decoration: InputDecoration(
            hintText: nameTextField,
            contentPadding: const EdgeInsets.only(top: 10.0),
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(
                color: GlobalColor.colorLetterSubTitle.withOpacity(.8),
                fontSize: 16,
                fontFamily: GlobalLabel.typeLetterSubTitle),
            filled: true,
            fillColor: GlobalColor.colorBorder.withOpacity(.6),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: GlobalColor.colorBorder, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  color: GlobalColor.colorBorder.withOpacity(.6), width: .5),
            ),
          ),
        ));
  }

  /// Style text field type password operator
  Widget textFieldPasswordOperator(
    type,
    double longitude,
    identifier,
    String nameTextField,
    IconData icon,
    int limitCharacter,
  ) {
    return Container(
        height: 60.0,
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: identifier,
          autocorrect: true,
          autofocus: false,
          obscureText: true,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [
            LengthLimitingTextInputFormatter(limitCharacter),
          ],
          keyboardType: type,
          style: TextStyle(
              fontSize: 16,
              color: GlobalColor.colorLetterTitle.withOpacity(.8),
              fontFamily: GlobalLabel.typeLetterTitle),
          decoration: InputDecoration(
            hintText: nameTextField,
            contentPadding: const EdgeInsets.only(top: 10.0),
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(
                color: GlobalColor.colorLetterSubTitle.withOpacity(.8),
                fontSize: 16,
                fontFamily: GlobalLabel.typeLetterSubTitle),
            filled: true,
            fillColor: GlobalColor.colorBorder.withOpacity(.6),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: GlobalColor.colorBorder, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  color: GlobalColor.colorBorder.withOpacity(.6), width: .5),
            ),
          ),
        ));
  }

  /// Style text field type password
  Widget textFieldPassword(type, double longitude, identifier,
      String nameTextField, IconData icon, ProviderLogIn providerLogin) {
    return Container(
        height: 60.0,
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: identifier,
          autocorrect: true,
          autofocus: false,
          obscureText: providerLogin.stateShowEditPassword,
          keyboardType: type,
          style: TextStyle(
              fontSize: 16,
              color: GlobalColor.colorLetterTitle.withOpacity(.8),
              fontFamily: GlobalLabel.typeLetterTitle),
          decoration: InputDecoration(
            hintText: nameTextField,
            contentPadding: const EdgeInsets.only(top: 10.0),
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(
                color: GlobalColor.colorLetterSubTitle.withOpacity(.8),
                fontSize: 16,
                fontFamily: GlobalLabel.typeLetterSubTitle),
            filled: true,
            fillColor: GlobalColor.colorBorder.withOpacity(.6),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: GlobalColor.colorBorder, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  color: GlobalColor.colorBorder.withOpacity(.6), width: .5),
            ),
          ),
        ));
  }

  /// Style divider component
  Widget divider() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: const DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: 4.0,
        dashColor: GlobalColor.colorBorder,
        dashRadius: 0.0,
        dashGapLength: 4.0,
        dashGapColor: Colors.transparent,
        dashGapRadius: 0.0,
      ),
    );
  }

  /// Transtition navegation page
  animationNavigatorView(Widget secondPage) {
    Navigator.push(
        GlobalFunction.contextGlobal.currentContext!,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 200),
            child: secondPage));
  }

  /// Style text button
  Widget styleTextButton(String title) {
    return Text(title,
        style: const TextStyle(
            fontFamily: GlobalLabel.typeLetterTitle,
            color: GlobalColor.colorWhite,
            fontSize: 16),
        textAlign: TextAlign.center);
  }

  /// Style title bar in the view
  titleBar(String title) {
    return AppBar(
      title: AutoSizeText(
        title,
        style: const TextStyle(
            fontFamily: GlobalLabel.typeLetterTitle,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: GlobalColor.colorLetterTitle),
      ),
      leading: IconButton(
        color: GlobalColor.colorLetterTitle,
        onPressed: () {
          GlobalFunction().closeView();
          GlobalFunction().deleteFocusForm();
        },
        icon: const Icon(Icons.arrow_back_ios, size: 20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  /// Show message informative page
  Widget messageInformative(String title, String message) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          GlobalWidget().styleTextTitle(
              title, GlobalColor.colorLetterTitle, 30.0, TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          GlobalWidget().styleTextSubTitle(
              message, GlobalColor.colorLetterSubTitle, 0.0, TextAlign.center),
        ],
      ),
    );
  }

  /// Show no result
  Widget noResult(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlobalWidget().styleTextTitle(
              message, GlobalColor.colorLetterTitle, 18.0, TextAlign.center)
        ],
      ),
    );
  }
}
