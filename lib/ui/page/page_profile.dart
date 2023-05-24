import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_log_in.dart';
import '../provider/provider_principal.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import 'page_contact.dart';
import 'page_list_operator.dart';
import 'page_service.dart';

class PageProfile extends StatelessWidget {
  static const route = GlobalLabel.routeProfile;
  ProviderPrincipal? _providerPrincipal;
  ProviderLogIn? _providerLogIn;

  @override
  Widget build(BuildContext context) {
    _providerPrincipal ??= Provider.of<ProviderPrincipal>(context);
    _providerLogIn ??= Provider.of<ProviderLogIn>(context);

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          body: SafeArea(
              child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: GlobalColor.colorWhite,
            child: SingleChildScrollView(
              child: Column(
                children: [infoUser(), menu()],
              ),
            ),
          )),
        ));
  }

  Widget infoUser() {
    return Container(
      color: GlobalColor.colorBackground,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Center(
          child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    GlobalWidget().styleTextTitle(GlobalLabel.textWelcome,
                        GlobalColor.colorLetterTitle, 20.0, TextAlign.left),
                    const SizedBox(height: 10),
                    GlobalWidget().styleTextSubTitle(
                        '${_providerPrincipal!.user.name} ${_providerPrincipal!.user.lastName}',
                        GlobalColor.colorLetterSubTitle,
                        18.0,
                        TextAlign.left),
                  ],
                ),
              ))),
    );
  }

  Widget menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: GlobalColor.colorBackground,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          height: 40,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GlobalWidget().styleTextTitle(GlobalLabel.textMenu,
              GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
        ),
        GestureDetector(
          onTap: () {
            GlobalFunction().closeView();
            Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                .pushNamed(PageListOperator.route, arguments: {'type': 3});
          },
          child: Visibility(
            visible: _providerPrincipal!.user.rol == 1 ? true : false,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GlobalWidget().styleTextSubTitle(
                        GlobalLabel.textMenuOperator,
                        GlobalColor.colorLetterSubTitle,
                        0.0,
                        TextAlign.left),
                  ),
                  const Expanded(
                      flex: 0, child: Icon(Icons.navigate_next_rounded))
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            GlobalFunction().closeView();
            Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                .pushNamed(PageService.route);
          },
          child: Visibility(
            visible: _providerPrincipal!.user.rol == 1 ? true : false,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GlobalWidget().styleTextSubTitle(
                            GlobalLabel.textService,
                            GlobalColor.colorLetterSubTitle,
                            0.0,
                            TextAlign.left),
                      ),
                      const Expanded(
                          flex: 0, child: Icon(Icons.navigate_next_rounded))
                    ],
                  ),
                ),
                GlobalWidget().divider(),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            GlobalFunction().closeView();
            Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                .pushNamed(PageContact.route);
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GlobalWidget().styleTextSubTitle(
                          GlobalLabel.textContact,
                          GlobalColor.colorLetterSubTitle,
                          0.0,
                          TextAlign.left),
                    ),
                    const Expanded(
                        flex: 0, child: Icon(Icons.navigate_next_rounded))
                  ],
                ),
              ),
              GlobalWidget().divider(),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            GlobalFunction().closeView();
            _providerPrincipal!.logOut(_providerLogIn!);
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GlobalWidget().styleTextSubTitle(
                          GlobalLabel.textLogOut,
                          GlobalColor.colorLetterSubTitle,
                          0.0,
                          TextAlign.left),
                    ),
                    const Expanded(
                        flex: 0, child: Icon(Icons.navigate_next_rounded))
                  ],
                ),
              ),
              GlobalWidget().divider(),
            ],
          ),
        ),
      ],
    );
  }
}
