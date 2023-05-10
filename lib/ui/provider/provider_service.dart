import 'package:flutter/cupertino.dart';
import 'package:lavacar/ui/provider/provider_reserve.dart';

import '../../data/model/response_service.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/api_interface.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';

class ProviderService with ChangeNotifier {
  ApiInterface apiInterface;
  TextEditingController editService = TextEditingController();
  int? _type = 1;
  bool? _contList = false;
  List<Service>? listService = [];
  String? _selectedService = '';

  ProviderService(this.apiInterface);

  String get selectedService => _selectedService!;

  set selectedService(String value) {
    _selectedService = value;
    notifyListeners();
  }

  bool get contList => _contList!;

  set contList(bool value) {
    _contList = value;
    notifyListeners();
  }

  int get type => _type!;

  set type(int value) {
    _type = value;
    notifyListeners();
  }

  /// Get list service
  getListService() async {
    await Future.delayed(const Duration(milliseconds: 300));
    apiInterface.responseListService((code, data) {
      if (code != 1) {
        listService!.clear();
        notifyListeners();
        return;
      }
      addListService(data);
      return null;
    });
  }

  addListService(ResponseService responseService) {
    if (listService!.isNotEmpty) listService!.clear();
    listService!.addAll(responseService.lS!);
    if (listService!.isNotEmpty) {
      _contList = false;
    } else {
      _contList = true;
    }
    notifyListeners();
  }

  /// Save new service
  saveService() {
    if (editService.text.toString().trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textInsertService);
    }
    apiInterface.responseSaveService(editService.text.toString().trim(),
        (code, data) {
      if (code != 1) {
        return GlobalFunction().messageAlert(data);
      }
      clearTextField();
      GlobalFunction().messageAlert(data);
      getListService();
      return null;
    });
  }

  /// Clear text field
  clearTextField() {
    editService.clear();
  }

  /// Set text field edit
  setTextField(String service) {
    editService.text = service;
    notifyListeners();
  }

  /// Delete service
  deleteService(String idService) {
    apiInterface.responseDeleteService(idService, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      clearTextField();
      getListService();
      return;
    });
  }

  /// Edit service
  updateService() {
    if (editService.text.toString().trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textInsertService);
    }
    apiInterface.responseEditService(
        selectedService, editService.text.toString().trim(), (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      clearTextField();
      getListService();
      return;
    });
  }

  /// Check service
  checkService(ProviderReserve providerReserve, String idService) {
    for (Service service in listService!) {
      if (service.id == idService) {
        service.check = true;
        providerReserve.serviceActive = service.name!;
      } else {
        service.check = false;
      }
    }
    notifyListeners();
  }

  /// Clean selected service active
  cleanSelectedActive(){
    for(Service service in listService!){
      service.check = false;
    }
    notifyListeners();
  }
}
