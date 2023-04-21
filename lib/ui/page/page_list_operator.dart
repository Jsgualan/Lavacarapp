import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/user.dart';
import '../provider/provider_operator.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import 'page_operator.dart';

class PageListOperator extends StatelessWidget {
  static const route = GlobalLabel.routeListOperator;
  ProviderOperator? _providerOperator;
  ProviderReserve? _providerReserve;
  ProviderPrincipal? _providerPrincipal;
  int? type;

  @override
  Widget build(BuildContext context) {
    if (_providerOperator == null) {
      _providerOperator = Provider.of<ProviderOperator>(context);
      _providerReserve = Provider.of<ProviderReserve>(context);
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerOperator!.consultListOperator();
      dynamic args = ModalRoute.of(context)!.settings.arguments;

      /// 1: Assigned operator
      /// 2: Edit assigned operator
      /// 3: Create operator
      if (args != null) {
        type = args['type'];
      }
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textAddOperator),
          body: SafeArea(
              child: _providerOperator!.listOperator!.isEmpty &&
                      !_providerOperator!.contList
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      color: GlobalColor.colorWhite,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Column(
                              children: [
                                GlobalWidget().messageInformative(
                                    GlobalLabel.textTitleListOperator,
                                    GlobalLabel.textDescriptionListOperator),
                                addOperator(),
                              ],
                            ),
                          ),
                          Expanded(flex: 1, child: listOperator())
                        ],
                      ),
                    )),
        ));
  }

  Widget addOperator() {
    return GestureDetector(
      onTap: () {
        _providerOperator!.clearTextField();
        Navigator.of(GlobalFunction.contextGlobal.currentContext!)
            .pushNamed(PageOperator.route, arguments: {'type': 1});
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  Widget listOperator() {
    return !_providerOperator!.contList
        ? SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: GlobalColor.colorWhite,
                border: Border.all(width: 1.0, color: GlobalColor.colorWhite),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _providerOperator!.listOperator!.length,
                itemBuilder: (context, index) {
                  return itemOperator(
                      _providerOperator!.listOperator![index], index + 1);
                },
              ),
            ),
          )
        : GlobalWidget().noResult(GlobalLabel.textNoResult);
  }

  Widget itemOperator(User user, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: GlobalColor.colorBackgroundBlue,
        border: Border.all(width: 1.0, color: GlobalColor.colorWhite),
      ),
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 0,
                child: CircleAvatar(
                    radius: 13,
                    child: GlobalWidget().styleTextTitle(
                        '$index', GlobalColor.colorWhite, 0, TextAlign.left)),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalWidget().styleTextTitle(
                        '${user.name} ${user.lastName}',
                        GlobalColor.colorLetterTitle,
                        0,
                        TextAlign.left),
                    const SizedBox(height: 5),
                    GlobalWidget().styleTextSubTitle(user.dni!,
                        GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
                    GlobalWidget().styleTextSubTitle(user.phone!,
                        GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
                    GlobalWidget().styleTextSubTitle(user.post!,
                        GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                    onTap: () {
                      menuOption(user);
                    },
                    child: const Icon(Icons.more_horiz)),
              )
            ],
          ),
        ],
      ),
    );
  }

  menuOption(User user) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: GlobalFunction.contextGlobal.currentContext!,
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) =>
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: GlobalColor.colorWhite,
                        border: Border.all(
                          width: .2,
                          color: GlobalColor.colorBorder,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 15.0, right: 15.0, bottom: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GlobalWidget().styleTextTitle(
                                  GlobalLabel.textMenuOption,
                                  GlobalColor.colorLetterTitle,
                                  18.0,
                                  TextAlign.center),
                              GlobalWidget().divider(),
                              Visibility(
                                visible: type == 3 ? false : true,
                                child: GestureDetector(
                                  onTap: () {
                                    if (type == 1) {
                                      _providerReserve!.setOperatorReserve(
                                          _providerPrincipal!,
                                          '${user.name} ${user.lastName}',
                                          user.idUser!);
                                    } else {
                                      _providerReserve!.selectedNameOperator =
                                          '${user.name} ${user.lastName}';
                                      _providerReserve!.idOperator =
                                      user.idUser!;
                                      GlobalFunction().closeView();
                                      GlobalFunction().closeView();
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GlobalWidget().styleTextSubTitle(
                                            GlobalLabel.textAssignedOperator,
                                            GlobalColor.colorLetterSubTitle,
                                            0.0,
                                            TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  GlobalFunction().closeView();
                                  _providerOperator!.addDataOperator(user);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GlobalWidget().styleTextSubTitle(
                                          GlobalLabel.textEditOperator,
                                          GlobalColor.colorLetterSubTitle,
                                          0.0,
                                          TextAlign.left),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  GlobalFunction().closeView();
                                  GlobalFunction().messageConfirmation(
                                      GlobalLabel.textQuestionDeleteOperator,
                                      () {
                                    _providerOperator!.deleteOperator(
                                        user.idUser!, false);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GlobalWidget().styleTextSubTitle(
                                          GlobalLabel.textDeleteOperator,
                                          GlobalColor.colorLetterSubTitle,
                                          0.0,
                                          TextAlign.left),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
    return null;
  }
}
