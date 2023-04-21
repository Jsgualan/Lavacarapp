import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import 'page_register_reserve.dart';

class PageDetailReserve extends StatelessWidget {
  static const route = GlobalLabel.routeDetailReserve;
  ProviderPrincipal? _providerPrincipal;
  ProviderReserve? _providerReserve;

  @override
  Widget build(BuildContext context) {
    if (_providerReserve == null) {
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerReserve = Provider.of<ProviderReserve>(context);
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textDetailReserve),
          body: SafeArea(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            color: GlobalColor.colorWhite,
            child: SingleChildScrollView(
              child: Column(
                children: [information(), buttonAction()],
              ),
            ),
          )),
        ));
  }

  Widget information() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: _providerPrincipal!.selectedBooking.state == 2
                    ? GlobalColor.colorPrincipal
                    : GlobalColor.colorRed,
                child: _providerPrincipal!.selectedBooking.typeService == 2
                    ? const Icon(Icons.home,
                        color: GlobalColor.colorWhite, size: 50)
                    : const Icon(Icons.store,
                        color: GlobalColor.colorWhite, size: 50),
              ),
              const SizedBox(height: 10),
              GlobalWidget().styleTextTitle(
                  _providerPrincipal!.selectedBooking.state == 2
                      ? GlobalLabel.textServicePending
                      : GlobalLabel.textServiceFinish,
                  GlobalColor.colorLetterTitle,
                  0,
                  TextAlign.center)
            ],
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textUser,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.nameUser} ${_providerPrincipal!.selectedBooking.lastNameUser}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textBrandVehicle,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.brand}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textModelVehicle,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.model}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textLateVehicle,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.numberLate}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textColorVehicle,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.color}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textTypeVehicle,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    '${_providerPrincipal!.selectedBooking.typeVehicle}',
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalWidget().styleTextTitle(GlobalLabel.textDescriptionService,
                GlobalColor.colorLetterTitle, 0, TextAlign.left),
            GlobalWidget().styleTextSubTitle(
                '${_providerPrincipal!.selectedBooking.descriptionService}',
                GlobalColor.colorLetterTitle,
                0,
                TextAlign.left)
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textTypeService,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: GlobalWidget().styleTextSubTitle(
                        _providerPrincipal!.selectedBooking.typeService == 2
                            ? GlobalLabel.textHome
                            : GlobalLabel.textBusiness,
                        GlobalColor.colorLetterTitle,
                        0,
                        TextAlign.left),
                  ),
                  GestureDetector(
                    onTap: () {
                      GlobalFunction().openGoogleMaps(
                          _providerPrincipal!
                              .selectedBooking.location!.latitude!,
                          _providerPrincipal!
                              .selectedBooking.location!.longitude!);
                    },
                    child: Visibility(
                        visible:
                            _providerPrincipal!.selectedBooking.typeService == 1
                                ? false
                                : true,
                        child: const Icon(Icons.location_on_rounded)),
                  )
                ],
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textDateService,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    _providerPrincipal!.selectedBooking.date!,
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(GlobalLabel.textHourService,
                  GlobalColor.colorLetterTitle, 0, TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    _providerPrincipal!.selectedBooking.hour!,
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
        GlobalWidget().divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GlobalWidget().styleTextTitle(
                  GlobalLabel.textOperatorAssigned,
                  GlobalColor.colorLetterTitle,
                  0,
                  TextAlign.left),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: GlobalWidget().styleTextSubTitle(
                    _providerPrincipal!.selectedBooking.nameOperator!,
                    GlobalColor.colorLetterTitle,
                    0,
                    TextAlign.left),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buttonAction() {
    return Visibility(
      visible: _providerPrincipal!.selectedBooking.state == 2 ? true : false,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Row(children: [
          Visibility(
            visible: _providerPrincipal!.user.rol != 3 ? true : false,
            child: Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  child: GlobalWidget()
                      .styleTextButton(GlobalLabel.buttonDeleteReserve),
                  onPressed: () {
                    GlobalFunction()
                        .messageConfirmation(GlobalLabel.textDeleteReserve, () {
                      _providerPrincipal!.deleteReserve(
                          _providerPrincipal!.selectedBooking.idReserve!);
                    });
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _providerPrincipal!.user.rol != 3 ? true : false,
            child: Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  child: GlobalWidget().styleTextButton(GlobalLabel.buttonEdit),
                  onPressed: () {
                    GlobalFunction().closeView();
                    Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                        .pushNamed(PageRegisterReserve.route,
                            arguments: {'type': 2});
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _providerPrincipal!.user.rol == 1 ||
                    _providerPrincipal!.user.rol == 3
                ? true
                : false,
            child: Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  child: GlobalWidget()
                      .styleTextButton(GlobalLabel.buttonFinishReserve),
                  onPressed: () {
                    GlobalFunction().messageConfirmation(
                        GlobalLabel.textQuestionFinishReserve, () {
                      _providerPrincipal!.finishReserve(
                          _providerPrincipal!.selectedBooking.idReserve!,
                          _providerReserve!);
                    });
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
