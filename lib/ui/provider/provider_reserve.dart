import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lavacar/ui/provider/provider_service.dart';
import '../../data/model/response_reserve.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/hour.dart';
import '../../domain/repositories/api_interface.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_preference.dart';
import 'provider_principal.dart';

class ProviderReserve with ChangeNotifier {
  ApiInterface apiInterface;
  TextEditingController editName = TextEditingController();
  TextEditingController editLastName = TextEditingController();
  TextEditingController editLate = TextEditingController();
  TextEditingController editBrand = TextEditingController();
  TextEditingController editModel = TextEditingController();
  TextEditingController editColor = TextEditingController();
  TextEditingController editTypeVehicle = TextEditingController();
  int? _typeService;
  double? _latitude;
  double? _longitude;
  int? _type;
  List<Hour>? listResult = [];
  bool? _stateCheckHome = false;
  bool? _stateCheckBusiness = false;
  String? _selectedDate = '';
  String? _selectedHour = '';
  double? _latitudeReserve = 0.0;
  double? _longitudeReserve = 0.0;
  String? _idOperator = '';
  String? _selectedNameOperator = '';
  List<Booking>? listReservePendingAccepted = [];
  String? _serviceActive = '';

  /// Construct
  ProviderReserve(this.apiInterface);

  String get serviceActive => _serviceActive!;

  set serviceActive(String value) {
    _serviceActive = value;
    notifyListeners();
  }

  String get selectedNameOperator => _selectedNameOperator!;

  set selectedNameOperator(String value) {
    _selectedNameOperator = value;
    notifyListeners();
  }

  String get idOperator => _idOperator!;

  set idOperator(String value) {
    _idOperator = value;
    notifyListeners();
  }

  double get latitudeReserve => _latitudeReserve!;

  set latitudeReserve(double value) {
    _latitudeReserve = value;
    notifyListeners();
  }

  double get longitudeReserve => _longitudeReserve!;

  set longitudeReserve(double value) {
    _longitudeReserve = value;
    notifyListeners();
  }

  String get selectedHour => _selectedHour!;

  set selectedHour(String value) {
    _selectedHour = value;
    notifyListeners();
  }

  String get selectedDate => _selectedDate!;

  set selectedDate(String value) {
    _selectedDate = value;
    notifyListeners();
  }

  bool get stateCheckBusiness => _stateCheckBusiness!;

  set stateCheckBusiness(bool value) {
    _stateCheckBusiness = value;
    notifyListeners();
  }

  bool get stateCheckHome => _stateCheckHome!;

  set stateCheckHome(bool value) {
    _stateCheckHome = value;
    notifyListeners();
  }

  int get type => _type!;

  set type(int value) {
    _type = value;
    notifyListeners();
  }

  int get typeService => _typeService!;

  set typeService(int value) {
    _typeService = value;
  }

  double get latitude => _latitude!;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude!;

  set longitude(double value) {
    _longitude = value;
  }

  /// Set data user
  setDataUser(ProviderPrincipal providerPrincipal) {
    if (providerPrincipal.user.rol != 1) {
      GlobalPreference.getDataUser().then((user) {
        editName.text = user!.name!;
        editLastName.text = user.lastName!;
      });
    }
  }

  /// Update check home
  updateCheckHome() {
    if (stateCheckHome) {
      stateCheckHome = false;
    } else {
      stateCheckHome = true;
      stateCheckBusiness = false;
    }
    notifyListeners();
  }

  /// Update check business
  updateCheckBusiness() {
    if (stateCheckBusiness) {
      stateCheckBusiness = false;
    } else {
      stateCheckBusiness = true;
      stateCheckHome = false;
    }
    notifyListeners();
  }

  /// Generate list hour
  generateReserve(ProviderPrincipal providerPrincipal, String date,
      String hourInitial, String hourFinish) {
    final DateFormat formatter = DateFormat('HH:mm');
    DateTime dateInitial = DateTime.parse(date);
    int horaTotal = (int.parse(hourFinish.split(":")[0]) -
        int.parse(hourInitial.split(":")[0]));

    int interval = 30;
    int numHora = int.parse(((horaTotal) * (60 / interval)).toStringAsFixed(0));
    List<DateTime> listPrincipal = [];
    listResult!.clear();
    if (listPrincipal.isEmpty) {
      listPrincipal.add(dateInitial);
      for (int j = 0; j < listPrincipal.length; j++) {
        if (listPrincipal.length < numHora) {
          listPrincipal.add(listPrincipal[j].add(Duration(minutes: interval)));
        }
        Hour hour = Hour();
        hour.hour = formatter.format(listPrincipal[j]);
        hour.state = 1;
        listResult!.add(hour);
      }
    }
    notifyListeners();
    updateListHour(providerPrincipal);
  }

  /// Send scheduled
  sendReserve() {
    if (editName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('');
    }
    if (editLastName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteName);
    }
    if (editLate.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteLate);
    }
    if (editBrand.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteBrandVehicle);
    }
    if (editModel.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteModelVehicle);
    }
    if (editColor.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteColorVehicle);
    }
    if (editTypeVehicle.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteTypeVehicle);
    }
    if (_serviceActive!.isEmpty) {
      return GlobalFunction()
          .messageAlert(GlobalLabel.textWriteDescriptionService);
    }
  }

  /// Get schedule global
  getReserve(ProviderPrincipal providerPrincipal, String date, int day) {
    apiInterface.responseHourDay(GlobalFunction().getFormatDay(day),
        (code, data) {
      ResponseReserve schedule = data;
      if (code != 1) {
        listResult!.clear();
        providerPrincipal.resetListHour(this);
        GlobalFunction().messageAlert(schedule.m!);
      } else {
        _selectedDate = date;
        generateReserve(
            providerPrincipal,
            '$date ${schedule.h!.hourInitial}:00',
            schedule.h!.hourInitial!,
            schedule.h!.hourFinish!);
      }
      notifyListeners();
      return null;
    });
  }

  /// State hour()
  stateHour(int state) {
    switch (state) {
      case 1:
        return 'Disponible';
      case 2:
        return 'Reservado';
      case 3:
        return 'No disponible';
    }
  }

  /// Set color state hour
  /// 1: Available
  /// 2: My reservation
  /// 3: Not available
  colorStateHour(int state) {
    switch (state) {
      case 1:
        return GlobalColor.colorGreen;
      case 2:
        return GlobalColor.colorRed;
      case 3:
        return GlobalColor.colorBorder;
    }
  }

  /// Send reserved
  sendReserved(ProviderPrincipal providerPrincipal, ProviderService providerService) {
    if (editName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu nombre');
    }
    if (editLastName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu apellido');
    }

    if (editLate.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la placa del vehiculo');
    }
    if (editBrand.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la marca del vehículo');
    }
    if (editModel.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el modelo del vehículo');
    }
    if (editColor.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el color del vehículo');
    }
    if (editTypeVehicle.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el tipo de vehículo');
    }

    if (!stateCheckHome && !stateCheckBusiness) {
      return GlobalFunction().messageAlert('Selecciona el lugar del servicio');
    }
    if (stateCheckHome) {
      if (latitudeReserve == 0.00 && longitudeReserve == 00) {
        return GlobalFunction().messageAlert('Fija la ubicación del domicilio');
      }
    }

    if (_selectedDate!.isEmpty) {
      return GlobalFunction().messageAlert('Selecciona la fecha de la reserva');
    }

    if (_serviceActive!.isEmpty) {
      return GlobalFunction()
          .messageAlert('Selecciona el tipo de servicio');
    }

    if (providerPrincipal.user.rol == 1) {
      if (_idOperator!.isEmpty) {
        return GlobalFunction().messageAlert('Selecciona el operador');
      }
    }

    apiInterface.responseSaveReserve(
        editBrand.text.trim(),
        editColor.text.trim(),
        _selectedDate!,
        _selectedHour!,
        _serviceActive!.trim(),
        _idOperator!,
        _selectedNameOperator!,
        providerPrincipal.user.idUser!,
        editLastName.text.trim(),
        editLate.text.trim(),
        latitudeReserve,
        longitudeReserve,
        editModel.text.trim(),
        editName.text.trim(),
        editTypeVehicle.text.trim(),
        _stateCheckBusiness! ? 1 : 2,
        providerPrincipal.user.rol == 1 ? 2 : 1, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      GlobalFunction().closeView();
      providerService.cleanSelectedActive();
      providerPrincipal.addReserve(
          this,
          GlobalFunction()
              .formatterDate
              .format(providerPrincipal.dateTimeSelected),
          providerPrincipal.dateTimeSelected);
      return null;
    });
  }

  /// Edit reserved
  editReserve(ProviderPrincipal providerPrincipal, ProviderService providerService) {
    if (editName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu nombre');
    }
    if (editLastName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu apellido');
    }

    if (editLate.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la placa del vehiculo');
    }
    if (editBrand.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la marca del vehículo');
    }
    if (editModel.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el modelo del vehículo');
    }
    if (editColor.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el color del vehículo');
    }
    if (editTypeVehicle.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el tipo de vehículo');
    }
    if (!stateCheckHome && !stateCheckBusiness) {
      return GlobalFunction().messageAlert('Selecciona el lugar del servicio');
    }
    if (stateCheckHome) {
      if (latitudeReserve == 0.00 && longitudeReserve == 00) {
        return GlobalFunction().messageAlert('Fija la ubicación del domicilio');
      }
    }

    if (_selectedDate!.isEmpty) {
      return GlobalFunction().messageAlert('Selecciona la fecha de la reserva');
    }

    if (_serviceActive!.trim().isEmpty) {
      return GlobalFunction()
          .messageAlert('Selecciona el tipo de servicio');
    }

    if (providerPrincipal.user.rol == 1) {
      if (_selectedNameOperator!.isEmpty) {
        return GlobalFunction().messageAlert('Selecciona el operador');
      }
    }

    apiInterface.responseEditReserve(
        providerPrincipal.selectedBooking.idReserve!,
        editBrand.text.trim(),
        editColor.text.trim(),
        _selectedDate!,
        _selectedHour!,
        _serviceActive!.trim(),
        _idOperator!,
        _selectedNameOperator!,
        providerPrincipal.user.idUser!,
        editLastName.text.trim(),
        editLate.text.trim(),
        latitudeReserve,
        longitudeReserve,
        editModel.text.trim(),
        editName.text.trim(),
        editTypeVehicle.text.trim(),
        _stateCheckBusiness! ? 1 : 2,
        providerPrincipal.selectedBooking.state!, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      GlobalFunction().closeView();
      providerService.cleanSelectedActive();
      providerPrincipal.addReserve(
          this,
          GlobalFunction()
              .formatterDate
              .format(providerPrincipal.dateTimeSelected),
          providerPrincipal.dateTimeSelected);
      return null;
    });
  }

  /// Add list reserve pending and accept
  updateListHour(ProviderPrincipal providerPrincipal) {
    if (listReservePendingAccepted!.isNotEmpty) {
      listReservePendingAccepted!.clear();
    }
    for (Booking booking in providerPrincipal.listTemp!) {
      for (Hour hours in listResult!) {
        if (booking.hour == hours.hour) {
          hours.state = 2;
          notifyListeners();
        }
      }
    }
  }

  /// Set operator to reserve
  setOperatorReserve(ProviderPrincipal providerPrincipal, String nameOperator,
      String idOperator) {
    apiInterface.responseAddOperatorReserve(
        providerPrincipal.bookingWaitOperator.idReserve!,
        2,
        idOperator,
        nameOperator, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      Navigator.of(GlobalFunction.contextGlobal.currentContext!).pop();
      Navigator.of(GlobalFunction.contextGlobal.currentContext!).pop();
      providerPrincipal.listNotification!.removeWhere((element) =>
          element.idReserve == providerPrincipal.bookingWaitOperator.idReserve);
      providerPrincipal.addReserve(
          this,
          GlobalFunction()
              .formatterDate
              .format(providerPrincipal.dateTimeSelected),
          providerPrincipal.dateTimeSelected);
      notifyListeners();
      return;
    });
  }

  /// Edit reserve
  editReserveSelected(ProviderPrincipal providerPrincipal) async {
    await Future.delayed(const Duration(milliseconds: 300));
    editName.text = providerPrincipal.selectedBooking.nameUser!;
    editLastName.text = providerPrincipal.selectedBooking.lastNameUser!;
    editLate.text = providerPrincipal.selectedBooking.numberLate!;
    editBrand.text = providerPrincipal.selectedBooking.brand!;
    editModel.text = providerPrincipal.selectedBooking.model!;
    editColor.text = providerPrincipal.selectedBooking.color!;
    editTypeVehicle.text = providerPrincipal.selectedBooking.typeVehicle!;
    if (providerPrincipal.selectedBooking.typeService == 1) {
      stateCheckBusiness = true;
    } else {
      stateCheckHome = true;
      latitudeReserve = providerPrincipal.selectedBooking.location!.latitude!;
      longitudeReserve = providerPrincipal.selectedBooking.location!.longitude!;
    }
    _selectedDate = providerPrincipal.selectedBooking.date!;
    _selectedHour = providerPrincipal.selectedBooking.hour;
    _idOperator = providerPrincipal.selectedBooking.idOperator;
    _selectedNameOperator = providerPrincipal.selectedBooking.nameOperator;

    notifyListeners();
  }

  /// Clean reserve
  cleanReserve() {
    editName.clear();
    editLastName.clear();
    editLate.clear();
    editBrand.clear();
    editModel.clear();
    editColor.clear();
    editTypeVehicle.clear();
    _stateCheckHome = false;
    _stateCheckBusiness = false;
    _selectedDate = '';
    _selectedHour = '';
    _latitudeReserve = 0.0;
    _longitudeReserve = 0.0;
    _idOperator = '';
    _selectedNameOperator = '';
    notifyListeners();
  }
}
