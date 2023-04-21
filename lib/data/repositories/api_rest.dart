import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/api_interface.dart';
import '../../ui/util/global_function.dart';
import '../../ui/util/global_label.dart';
import '../model/response_notification.dart';
import '../model/response_operator.dart';
import '../model/response_reserve.dart';
import '../model/response_user.dart';

class ApiRest implements ApiInterface {
  Dio dio = Dio();

  /// LogIn application
  @override
  Future responseLogIn(String email, String password,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}login/$email/$password";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT LOGIN >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], ResponseUser.fromMap(response.data));
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Get list operator
  @override
  Future responseListOperator(
      VoidCallback? Function(int code, dynamic data) callback) async {
    const url = "${GlobalLabel.url}operator";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT LIST OPERATOR >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], ResponseOperator.fromMap(response.data));
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// LogIn application
  @override
  Future responseCheckOperator(String dni,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}checkOperator/$dni";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT CHECK OPERATOR >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Save operator
  @override
  Future responseSaveOperator(
      String name,
      String lastName,
      String dni,
      String phone,
      String email,
      String password,
      String post,
      int rol,
      VoidCallback? Function(int t, dynamic data) callback) async {
    const url = "${GlobalLabel.url}saveOperator";
    final data = {
      'dni': dni,
      'email': email,
      'idUser': GlobalFunction().generateId(),
      'lastName': lastName,
      'name': name,
      'password': password,
      'phone': phone,
      'post': post,
      'rol': rol,
    };
    try {
      final response = await dio.post(url, data: data);
      if (kDebugMode) {
        print('RESULT SAVE OPERATOR >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Get list hour
  @override
  Future responseHourDay(String day,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}hourDay/$day";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT LIST HOUR DAY >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], ResponseReserve.fromMap(response.data));
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Save reserve
  @override
  Future responseSaveReserve(
      String brandVehicle,
      String colorVehicle,
      String dateReserve,
      String hourReserve,
      String descriptionService,
      String idOperator,
      String nameOperator,
      String idUser,
      String lastNameUser,
      String lateVehicle,
      double latitude,
      double longitude,
      String modelVehicle,
      String nameUser,
      String typeVehicle,
      int typeService,
      int state,
      VoidCallback? Function(int t, dynamic data) callback) async {
    const url = "${GlobalLabel.url}saveReserve";
    final data = {
      'idReserve': GlobalFunction().generateId(),
      'brandVehicle': brandVehicle,
      'colorVehicle': colorVehicle,
      'dateReserve': dateReserve,
      'hourReserve': hourReserve,
      'descriptionService': descriptionService,
      'idOperator': idOperator,
      'nameOperator': nameOperator,
      'idUser': idUser,
      'lastNameUser': lastNameUser,
      'lateVehicle': lateVehicle,
      'latitude': latitude,
      'longitude': longitude,
      'modelVehicle': modelVehicle,
      'nameUser': nameUser,
      'typeVehicle': typeVehicle,
      'typeService': typeService,
      'state': state,
    };
    try {
      final response = await dio.post(url, data: data);
      if (kDebugMode) {
        print('RESULT SAVE RESERVE >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// LogIn application
  @override
  Future responseNotification(String date,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}getReserve/$date";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT GET NOTIFICATION >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(
          response.data['en'], ResponseNotification.fromMap(response.data));
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Decline notification
  @override
  Future responseDeclineNotification(String idReserve, int state,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}declineNotification/$idReserve";
    final data = {
      'state': state,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT DECLINE NOTIFICATION >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Decline notification
  @override
  Future responseAddOperatorReserve(
      String idReserve,
      int state,
      String idOperator,
      String nameOperator,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}addOperatorReserve/$idReserve";
    final data = {
      'idOperator': idOperator,
      'name_operator': nameOperator,
      'state': state,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT DECLINE NOTIFICATION >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Edit reserve
  @override
  Future responseEditReserve(
      String idReserve,
      String brandVehicle,
      String colorVehicle,
      String dateReserve,
      String hourReserve,
      String descriptionService,
      String idOperator,
      String nameOperator,
      String idUser,
      String lastNameUser,
      String lateVehicle,
      double latitude,
      double longitude,
      String modelVehicle,
      String nameUser,
      String typeVehicle,
      int typeService,
      int state,
      VoidCallback? Function(int t, dynamic data) callback) async {
    final url = "${GlobalLabel.url}editReserve/$idReserve";
    final data = {
      'idReserve': idReserve,
      'brandVehicle': brandVehicle,
      'colorVehicle': colorVehicle,
      'dateReserve': dateReserve,
      'hourReserve': hourReserve,
      'descriptionService': descriptionService,
      'idOperator': idOperator,
      'nameOperator': nameOperator,
      'idUser': idUser,
      'lastNameUser': lastNameUser,
      'lateVehicle': lateVehicle,
      'latitude': latitude,
      'longitude': longitude,
      'modelVehicle': modelVehicle,
      'nameUser': nameUser,
      'typeVehicle': typeVehicle,
      'typeService': typeService,
      'state': state,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT EDIT RESERVE >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Finish reserve
  @override
  Future responseFinishReserve(String idReserve, int state,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}finishReserve/$idReserve";
    final data = {
      'state': state,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT FINISH RESERVE >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Edit operator
  @override
  Future responseEditOperator(
      String idOperator,
      String name,
      String lastName,
      String dni,
      String phone,
      String email,
      String password,
      String post,
      VoidCallback? Function(int t, dynamic data) callback) async {
    final url = "${GlobalLabel.url}editOperator/$idOperator";
    final data = {
      'dni': dni,
      'email': email,
      'idUser': idOperator,
      'lastName': lastName,
      'name': name,
      'password': password,
      'phone': phone,
      'post': post,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT EDIT OPERATOR >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Check user
  @override
  Future responseCheckUser(String email,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}checkUser/$email";
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print('RESULT CHECK USER >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      if (response.data['en'] == 1) {
        callback(response.data['en'], ResponseUser.fromMap(response.data));
      } else {
        callback(response.data['en'], response.data['m']);
      }
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Save user
  @override
  Future responseSaveUser(
      String email,
      String name,
      String lastName,
      String password,
      int rol,
      VoidCallback? Function(int t, dynamic data) callback) async {
    const url = "${GlobalLabel.url}saveUser";
    final data = {
      'dni': '',
      'email': email,
      'idUser': GlobalFunction().generateId(),
      'lastName': lastName,
      'name': name,
      'password': password,
      'phone': '',
      'post': '',
      'rol': rol,
    };
    try {
      final response = await dio.post(url, data: data);
      if (kDebugMode) {
        print('RESULT SAVE USER >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Delete operator
  @override
  Future responseDeleteOperator(String idOperator, bool state,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}deleteOperator/$idOperator";
    final data = {
      'state': state,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT DELETE OPERATOR >>> $response');
      }
      if (response.data == null) {
        return GlobalFunction().messageAlert(GlobalLabel.textMessageError);
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }

  /// Save token notification
  @override
  Future responseSaveToken(String idUser, String token,
      VoidCallback? Function(int code, dynamic data) callback) async {
    final url = "${GlobalLabel.url}saveToken/$idUser";
    final data = {
      'token': token,
    };
    try {
      final response = await dio.put(url, data: data);
      if (kDebugMode) {
        print('RESULT SAVE TOKEN >>> $response');
      }
      callback(response.data['en'], response.data['m']);
    } catch (e) {
      GlobalFunction().messageAlert(GlobalLabel.textMessageError);
    }
  }
}
