import 'dart:ui';

abstract class ApiInterface {
  Future responseLogIn(String email, String password,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseListOperator(
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseCheckOperator(
      String dni, VoidCallback? Function(int code, dynamic data) callback);

  Future responseSaveOperator(
      String name,
      String lastName,
      String dni,
      String phone,
      String email,
      String password,
      String post,
      int rol,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseHourDay(
      String day, VoidCallback? Function(int code, dynamic data) callback);

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
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseNotification(
      String date, VoidCallback? Function(int code, dynamic data) callback);

  Future responseDeclineNotification(String idReserve, int state,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseAddOperatorReserve(
      String idReserve,
      int state,
      String idOperator,
      String nameOperator,
      VoidCallback? Function(int code, dynamic data) callback);

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
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseFinishReserve(String idReserve, int state,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseEditOperator(
      String idOperator,
      String name,
      String lastName,
      String dni,
      String phone,
      String email,
      String password,
      String post,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseCheckUser(
      String email, VoidCallback? Function(int code, dynamic data) callback);

  Future responseSaveUser(
      String email,
      String name,
      String lastName,
      String password,
      int rol,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseDeleteOperator(String idOperator, bool state,
      VoidCallback? Function(int code, dynamic data) callback);

  Future responseSaveToken(String idUser, String token,
      VoidCallback? Function(int code, dynamic data) callback);
}
