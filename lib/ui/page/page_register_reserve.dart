import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../domain/entities/service.dart';
import '../provider/providerMapa.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../provider/provider_service.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import '../util/gps.dart';
import 'page_calendar.dart';
import 'page_list_operator.dart';
import 'page_map.dart';

class PageRegisterReserve extends StatelessWidget {
  static const route = GlobalLabel.routeRegisterReserve;
  ProviderReserve? _providerReserve;
  ProviderService? _providerService;
  ProviderMap? _providerMap;
  ProviderPrincipal? _providerPrincipal;
  int? type;

  @override
  Widget build(BuildContext context) {
    if (_providerReserve == null) {
      _providerReserve = Provider.of<ProviderReserve>(context);
      _providerMap = Provider.of<ProviderMap>(context);
      _providerService = Provider.of<ProviderService>(context);
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);

      /// 1: Save reserve
      /// 2: Edit reserve
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        type = args['type'];
      }
      if (type == 2) {
        _providerReserve!.editReserveSelected(_providerPrincipal!);
      }
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textReserve),
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
                      GlobalLabel.textTitleReserve,
                      GlobalLabel.textDescriptionReserve),
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
                      _providerReserve!.editName,
                      GlobalLabel.textName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editLastName,
                      GlobalLabel.textLastName,
                      Icons.perm_identity,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editLate,
                      GlobalLabel.textNumberLate,
                      Icons.credit_card,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editBrand,
                      GlobalLabel.textBrand,
                      Icons.car_repair_rounded,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editModel,
                      GlobalLabel.textModel,
                      Icons.car_repair_rounded,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editColor,
                      GlobalLabel.textColor,
                      Icons.format_paint,
                      45),
                  GlobalWidget().divider(),
                  GlobalWidget().textField(
                      TextInputType.text,
                      11,
                      _providerReserve!.editTypeVehicle,
                      GlobalLabel.textTypeVehicle,
                      Icons.car_repair_rounded,
                      45),
                  GlobalWidget().divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlobalWidget().styleTextSubTitle(GlobalLabel.textBusiness,
                          GlobalColor.colorLetterSubTitle, 16, TextAlign.left),
                      Checkbox(
                        checkColor: Colors.white,
                        value: _providerReserve!.stateCheckBusiness,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          _providerReserve!.updateCheckBusiness();
                        },
                      ),
                      GlobalWidget().styleTextSubTitle(GlobalLabel.textHome,
                          GlobalColor.colorLetterSubTitle, 16, TextAlign.left),
                      Checkbox(
                        checkColor: Colors.white,
                        value: _providerReserve!.stateCheckHome,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          _providerReserve!.updateCheckHome();
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Gps().checkGPS(_providerMap!).then((value) {
                        if (value) {
                          GlobalWidget().animationNavigatorView(PageMap());
                        }
                      });
                    },
                    child: Visibility(
                      visible: _providerReserve!.stateCheckHome,
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: GlobalColor.colorBorder.withOpacity(.6),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: GlobalColor.colorBorder,
                            width: .1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: GlobalColor.colorLetterSubTitle,
                            ),
                            const SizedBox(width: 10),
                            _providerReserve!.latitudeReserve == 0
                                ? GlobalWidget().styleTextSubTitle(
                                    GlobalLabel.textLocation,
                                    GlobalColor.colorLetterSubTitle,
                                    16,
                                    TextAlign.left)
                                : GlobalWidget().styleTextTitle(
                                    GlobalLabel.textSelectedLocation,
                                    GlobalColor.colorLetterTitle,
                                    16,
                                    TextAlign.left),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GlobalWidget().divider(),
                  GestureDetector(
                    onTap: () {
                      _providerPrincipal!.resetListHour(_providerReserve!);
                      GlobalWidget().animationNavigatorView(PageCalendar());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: GlobalColor.colorBorder.withOpacity(.6),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: GlobalColor.colorBorder,
                          width: .1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: GlobalColor.colorLetterSubTitle,
                          ),
                          const SizedBox(width: 10),
                          _providerReserve!.selectedDate.isNotEmpty &&
                                  _providerReserve!.selectedHour.isNotEmpty
                              ? GlobalWidget().styleTextTitle(
                                  '${_providerReserve!.selectedDate} ${_providerReserve!.selectedHour}',
                                  GlobalColor.colorLetterTitle,
                                  16,
                                  TextAlign.left)
                              : GlobalWidget().styleTextSubTitle(
                                  GlobalLabel.textDate,
                                  GlobalColor.colorLetterSubTitle,
                                  16,
                                  TextAlign.left),
                        ],
                      ),
                    ),
                  ),
                  GlobalWidget().divider(),
                  listService(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                          .pushNamed(PageListOperator.route,
                              arguments: {'type': type == 1 ? 2 : 1});
                    },
                    child: Visibility(
                      visible: type != 3
                          ? _providerPrincipal!.user.rol == 1
                              ? true
                              : false
                          : false,
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: GlobalColor.colorBorder.withOpacity(.6),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: GlobalColor.colorBorder,
                            width: .1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: GlobalColor.colorLetterSubTitle,
                            ),
                            const SizedBox(width: 10),
                            _providerReserve!.selectedNameOperator.isEmpty
                                ? GlobalWidget().styleTextSubTitle(
                                    GlobalLabel.textOperator,
                                    GlobalColor.colorLetterSubTitle,
                                    16,
                                    TextAlign.left)
                                : GlobalWidget().styleTextTitle(
                                    _providerReserve!.selectedNameOperator,
                                    GlobalColor.colorLetterTitle,
                                    16,
                                    TextAlign.left),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            type == 1 ? buttonSendReserve() : buttonEditReserve(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buttonSendReserve() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(GlobalLabel.buttonSendReserve),
        onPressed: () {
          _providerReserve!
              .sendReserved(_providerPrincipal!, _providerService!);
        },
      ),
    );
  }

  Widget listService() {
    return Visibility(
      visible: _providerService!.listService!.isNotEmpty,
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: GlobalWidget().styleTextTitle('Servicio ha realizar',
                  GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _providerService!.listService!.length,
              itemBuilder: (context, index) {
                return itemService(
                    _providerService!.listService![index], index + 1);
              },
            ),
            GlobalWidget().divider()
          ],
        ),
      ),
    );
  }

  Widget itemService(Service service, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GlobalWidget().styleTextSubTitle(service.name!,
                GlobalColor.colorLetterSubTitle, 16, TextAlign.left),
          ),
        ),
        Expanded(
          flex: 0,
          child: Checkbox(
            checkColor: Colors.white,
            value: service.check,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              _providerService!.checkService(_providerReserve!, service.id!);
            },
          ),
        ),
      ],
    );
  }

  Widget buttonEditReserve() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(GlobalLabel.buttonEdit),
        onPressed: () {
          _providerReserve!.editReserve(_providerPrincipal!, _providerService!);
        },
      ),
    );
  }
}
