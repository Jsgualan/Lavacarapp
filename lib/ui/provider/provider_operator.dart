import 'package:flutter/cupertino.dart';

import '../../data/model/response_operator.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/api_interface.dart';
import '../page/page_operator.dart';
import '../util/global_function.dart';

class ProviderOperator with ChangeNotifier {
  ApiInterface apiInterface;
  TextEditingController editName = TextEditingController();
  TextEditingController editLastName = TextEditingController();
  TextEditingController editDNI = TextEditingController();
  TextEditingController editPhone = TextEditingController();
  TextEditingController editPost = TextEditingController();
  TextEditingController editPassword = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  List<User>? listOperator = [];
  String? idUser;
  bool? _contList = false;

  ProviderOperator(this.apiInterface);

  bool get contList => _contList!;

  set contList(bool value) {
    _contList = value;
  }

  /// Save operator
  saveOperator() {
    if (editName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el nombre');
    }

    if (editName.text.trim().length < 4) {
      return GlobalFunction()
          .messageAlert('El nombre no puede o contener menos de 5 caracteres');
    }

    if (editLastName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el apellido');
    }
    if (editLastName.text.trim().length < 4) {
      return GlobalFunction().messageAlert(
          'El apellido no puede o contener menos de 5 caracteres');
    }

    if (editDNI.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la cedula');
    }
    if (editDNI.text.trim().length < 10) {
      return GlobalFunction()
          .messageAlert('Verifica el número de cedula ingresado');
    }

    if (editEmail.text.trim().length < 10) {
      return GlobalFunction().messageAlert('Ingres el correo');
    }
    if (!editEmail.text.trim().contains('@')) {
      return GlobalFunction().messageAlert('Verifica el correo ingresado');
    }

    if (editPassword.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa una contraseña');
    }

    if (editPassword.text.trim().length < 5) {
      return GlobalFunction().messageAlert(
          'La contraseña no puede contener menos de 5 caracteres');
    }

    if (editPost.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el cargo');
    }

    apiInterface.responseCheckOperator(editDNI.text.trim(), (code, data) {
      if (code != 1) return GlobalFunction().messageAlert(data);
      apiInterface.responseSaveOperator(
          editName.text.trim(),
          editLastName.text.trim(),
          editDNI.text.trim(),
          editPhone.text.trim(),
          editEmail.text.trim(),
          editPassword.text.trim(),
          editPost.text.trim(),
          3, (code, data) {
        if (code != 1) return;
        GlobalFunction().messageAlert(data);
        GlobalFunction().closeView();
        clearTextField();
        consultListOperator();
        return null;
      });
      return null;
    });
  }

  /// Edit operator
  editOperator() {
    if (editName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el nombre');
    }

    if (editName.text.trim().length < 4) {
      return GlobalFunction()
          .messageAlert('El nombre no puede o contener menos de 5 caracteres');
    }

    if (editLastName.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el apellido');
    }
    if (editLastName.text.trim().length < 4) {
      return GlobalFunction().messageAlert(
          'El apellido no puede o contener menos de 5 caracteres');
    }

    if (editDNI.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa la cedula');
    }
    if (editDNI.text.trim().length < 10) {
      return GlobalFunction()
          .messageAlert('Verifica el número de cedula ingresado');
    }

    if (editEmail.text.trim().length < 10) {
      return GlobalFunction().messageAlert('Ingres el correo');
    }
    if (!editEmail.text.trim().contains('@')) {
      return GlobalFunction().messageAlert('Verifica el correo ingresado');
    }

    if (editPassword.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa una contraseña');
    }

    if (editPassword.text.trim().length < 5) {
      return GlobalFunction().messageAlert(
          'La contraseña no puede contener menos de 5 caracteres');
    }

    if (editPost.text.trim().isEmpty) {
      return GlobalFunction().messageAlert('Ingresa el cargo');
    }

    apiInterface.responseEditOperator(
        idUser!,
        editName.text.trim(),
        editLastName.text.trim(),
        editDNI.text.trim(),
        editPhone.text.trim(),
        // GlobalFunction().generatedMd5(editPassword.text.trim()),
        editEmail.text.trim(),
        editPassword.text.trim(),
        editPost.text.trim(), (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      GlobalFunction().closeView();
      clearTextField();
      consultListOperator();
      return null;
    });
  }

  /// Get list operator
  consultListOperator() async {
    await Future.delayed(const Duration(milliseconds: 300));
    apiInterface.responseListOperator((code, data) {
      addListOperator(data);
      return null;
    });
  }

  /// Add new operator
  addListOperator(ResponseOperator responseOperator) {
    if (listOperator!.isNotEmpty) listOperator!.clear();
    listOperator!.addAll(responseOperator.lP!);
    if (listOperator!.isNotEmpty) {
      _contList = false;
    } else {
      _contList = true;
    }
    notifyListeners();
  }

  /// Clear text fied
  clearTextField() {
    editName.clear();
    editLastName.clear();
    editDNI.clear();
    editPhone.clear();
    editEmail.clear();
    editPassword.clear();
    editPost.clear();
    notifyListeners();
  }

  /// Edit operator
  addDataOperator(User user) {
    editName.text = user.name!;
    editLastName.text = user.lastName!;
    editDNI.text = user.dni!;
    editPhone.text = user.phone!;
    editEmail.text = user.email!;
    editPost.text = user.post!;
    editPassword.text = user.password!;
    idUser = user.idUser;
    Navigator.of(GlobalFunction.contextGlobal.currentContext!)
        .pushNamed(PageOperator.route, arguments: {'type': 2});
    notifyListeners();
  }

  /// Delete operator
  deleteOperator(String idOperator, bool state) {
    apiInterface.responseDeleteOperator(idOperator, state, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      deleteOperatorList(idOperator);
      return null;
    });
  }

  /// Delete operator list
  deleteOperatorList(String idUserOperator) {
    listOperator!.removeWhere((element) => element.idUser == idUserOperator);
    if (listOperator!.isEmpty) {
      _contList = true;
    }
    notifyListeners();
  }
}
