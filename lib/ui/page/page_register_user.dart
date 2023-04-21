import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_user.dart';
import '../util/global_color.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageRegisterUser extends StatelessWidget {
  static const route = GlobalLabel.routeRegisterUser;
  ProviderUser? _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser ??= Provider.of<ProviderUser>(context);
    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textAddUser),
          body: SafeArea(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            color: GlobalColor.colorWhite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GlobalWidget().messageInformative(
                      GlobalLabel.textTitleRegisterUser,
                      GlobalLabel.textDescriptionRegisterUser),
                  form()
                ],
              ),
            ),
          )),
        ));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                children: [
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerUser!.editName,
                      GlobalLabel.textName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerUser!.editLastName,
                      GlobalLabel.textLastName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.number,
                      11,
                      _providerUser!.editEmail,
                      GlobalLabel.textEmail,
                      Icons.email,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerUser!.editPassword,
                      GlobalLabel.textPassword,
                      Icons.key,
                      45),
                  GlobalWidget().divider(),
                ],
              ),
            ),
            buttonSaveUser(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buttonSaveUser() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(GlobalLabel.buttonSaveUser),
        onPressed: () {
          _providerUser!.saveUser();
        },
      ),
    );
  }
}
