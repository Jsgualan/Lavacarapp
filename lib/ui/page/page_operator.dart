import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_operator.dart';
import '../util/global_color.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageOperator extends StatelessWidget {
  static const route = GlobalLabel.routeAddOperator;
  ProviderOperator? _providerOperator;
  int? type;

  @override
  Widget build(BuildContext context) {
    if (_providerOperator == null) {
      _providerOperator = Provider.of<ProviderOperator>(context);
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        type = args['type'];
      }
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textAddOperator),
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
                      GlobalLabel.textTitleOperator,
                      GlobalLabel.textDescriptionOperator),
                  form()
                ],
              ),
            ),
          )),
        ));
  }

  Widget form() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
                      _providerOperator!.editName,
                      GlobalLabel.textName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerOperator!.editLastName,
                      GlobalLabel.textLastName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.number,
                      11,
                      _providerOperator!.editDNI,
                      GlobalLabel.textDNI,
                      Icons.credit_card,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.phone,
                      11,
                      _providerOperator!.editPhone,
                      GlobalLabel.textPhone,
                      Icons.phone_android_rounded,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.emailAddress,
                      11,
                      _providerOperator!.editEmail,
                      GlobalLabel.textEmail,
                      Icons.email,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textFieldPasswordOperator(
                      TextInputType.text,
                      11,
                      _providerOperator!.editPassword,
                      GlobalLabel.textPassword,
                      Icons.key,
                      6),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerOperator!.editPost,
                      GlobalLabel.textPost,
                      Icons.settings_accessibility,
                      45),
                  GlobalWidget().divider(),
                ],
              ),
            ),
            buttonSaveOperator(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buttonSaveOperator() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(type == 1
            ? GlobalLabel.buttonSaveOperator
            : GlobalLabel.buttonEdit),
        onPressed: () {
          if (type == 1) {
            _providerOperator!.saveOperator();
          } else {
            _providerOperator!.editOperator();
          }
        },
      ),
    );
  }
}
