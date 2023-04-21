import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/provider_log_in.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_user.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import 'page_register_reserve.dart';

class PageLogIn extends StatelessWidget {
  static const route = GlobalLabel.routeLogin;
  ProviderLogIn? _providerLogIn;
  ProviderPrincipal? _providerPrincipal;
  ProviderUser? _providerUser;

  @override
  Widget build(BuildContext context) {
    if (_providerLogIn == null) {
      _providerLogIn = Provider.of<ProviderLogIn>(context);
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerUser = Provider.of<ProviderUser>(context);
      _providerLogIn!.getVersionApplication();
    }

    return AnnotatedRegion(
      value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                owner(),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [welcome(), form(), menuOption()],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget welcome() {
    return Center(
      child: Container(
          margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalWidget().styleTextTitle(GlobalLabel.textTitleWelcome,
                  GlobalColor.colorLetterTitle, 40.0, TextAlign.center),
              GlobalWidget().styleTextSubTitle(
                  GlobalLabel.textDescriptionWelcome,
                  GlobalColor.colorLetterSubTitle,
                  0.0,
                  TextAlign.center),
            ],
          )),
    );
  }

  Widget form() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Card(
        elevation: .1,
        shadowColor: GlobalColor.colorBorder,
        color: GlobalColor.colorWhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: GlobalColor.colorBorder, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                children: [
                  GlobalWidget().textField(
                      TextInputType.emailAddress,
                      11,
                      _providerLogIn!.editEmail,
                      GlobalLabel.textEmail,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GlobalWidget().textFieldPassword(
                            TextInputType.text,
                            10,
                            _providerLogIn!.editPassword,
                            GlobalLabel.textPassword,
                            Icons.key,
                            _providerLogIn!),
                      ),
                      Expanded(
                        flex: 0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          icon: const Icon(Icons.remove_red_eye,
                              color: GlobalColor.colorLetterTitle),
                          onPressed: () {
                            _providerLogIn!.showPassword();
                          },
                        ),
                      ),
                    ],
                  ),
                  GlobalWidget().divider(),
                ],
              ),
            ),
            buttonGetInto(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget menuOption() {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      child: Column(
        children: [
          GlobalWidget().styleTextTitle(GlobalLabel.buttonLogInWith,
              GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    GlobalFunction().showProgress();
                    _providerLogIn!
                        .loginGoogle(_providerPrincipal!, _providerUser!);
                  },
                  child: Card(
                    elevation: .9,
                    shadowColor: GlobalColor.colorBorder,
                    color: GlobalColor.colorWhite,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: GlobalColor.colorBorder, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 60,
                        child: const Image(
                            width: 30,
                            image: AssetImage(
                                '${GlobalLabel.directionImageInternal}gmail.png'))),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    GlobalFunction().showProgress();
                    _providerLogIn!
                        .loginFacebook(_providerPrincipal!, _providerUser!);
                  },
                  child: Card(
                    elevation: .9,
                    shadowColor: GlobalColor.colorBorder,
                    color: GlobalColor.colorWhite,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: GlobalColor.colorBorder, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 60,
                      child: const Image(
                          width: 30,
                          image: AssetImage(
                              '${GlobalLabel.directionImageInternal}facebook.png')),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                  .pushNamed(PageRegisterReserve.route,
                  arguments: {'type': 3});
            },
            child: GlobalWidget().styleTextTitle(GlobalLabel.buttonNextNoUser,
                GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget buttonGetInto() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(GlobalLabel.buttonLogIn),
        onPressed: () {
          _providerLogIn!.logIn(_providerPrincipal!);
        },
      ),
    );
  }

  Widget owner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.bottomCenter,
      child: GlobalWidget().styleTextSubTitle(_providerLogIn!.version,
          GlobalColor.colorLetterTitle, 14, TextAlign.left),
    );
  }
}
