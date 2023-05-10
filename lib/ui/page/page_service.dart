import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/service.dart';
import '../provider/provider_service.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageService extends StatelessWidget {
  static const route = GlobalLabel.routeService;
  ProviderService? _providerService;

  @override
  Widget build(BuildContext context) {
    _providerService ??= Provider.of<ProviderService>(context);

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textAddService),
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
                      GlobalLabel.textTitleService,
                      GlobalLabel.textDescriptionAddService),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GlobalWidget().textField(
                    TextInputType.text,
                    11,
                    _providerService!.editService,
                    GlobalLabel.textService,
                    Icons.room_service_outlined,
                    45),
              ),
              Expanded(
                flex: 0,
                child: Visibility(
                  visible: _providerService!.type == 1 ? false : true,
                  child: GestureDetector(
                      onTap: () {
                        _providerService!.type = 1;
                        _providerService!.clearTextField();
                      },
                      child: const Icon(Icons.close_outlined)),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          buttonSaveService(),
          listService()
        ],
      ),
    );
  }

  Widget listService() {
    return !_providerService!.contList
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
                itemCount: _providerService!.listService!.length,
                itemBuilder: (context, index) {
                  return itemService(
                      _providerService!.listService![index], index + 1);
                },
              ),
            ),
          )
        : GlobalWidget().noResult(GlobalLabel.textNoResult);
  }

  Widget itemService(Service service, int index) {
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
                    GlobalWidget().styleTextTitle(service.name!,
                        GlobalColor.colorLetterTitle, 0, TextAlign.left),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                    onTap: () {
                      menuOption(service);
                    },
                    child: const Icon(Icons.more_horiz)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonSaveService() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: GlobalWidget().styleTextButton(_providerService!.type == 1
            ? GlobalLabel.buttonSaveService
            : GlobalLabel.buttonEditService),
        onPressed: () {
          if (_providerService!.type == 1) {
            _providerService!.saveService();
          } else {
            _providerService!.updateService();
          }
        },
      ),
    );
  }

  menuOption(Service service) {
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
                              GestureDetector(
                                onTap: () {
                                  GlobalFunction().closeView();
                                  _providerService!.type = 2;
                                  _providerService!.setTextField(service.name!);
                                  _providerService!.selectedService =
                                      service.id!;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GlobalWidget().styleTextSubTitle(
                                          GlobalLabel.textEditService,
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
                                  _providerService!.deleteService(service.id!);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GlobalWidget().styleTextSubTitle(
                                          GlobalLabel.textDeleteService,
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
