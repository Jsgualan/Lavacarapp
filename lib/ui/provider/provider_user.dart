import 'package:flutter/cupertino.dart';
import 'package:lavacar/ui/util/global_widget.dart';

import '../../domain/repositories/api_interface.dart';
import '../util/global_function.dart';

class ProviderUser with ChangeNotifier {
  ApiInterface apiInterface;
  TextEditingController editName = TextEditingController();
  TextEditingController editLastName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editPassword = TextEditingController();

  ProviderUser(this.apiInterface);

  /// Save user
  saveUser() {
    if (editName.text.isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu nombre');
    }
    if (editLastName.text.isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu apellido');
    }
    if (editEmail.text.isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu correo electrónico');
    }
    if (editPassword.text.isEmpty) {
      return GlobalFunction().messageAlert('Ingresa tu correo electrónico');
    }
    if (editPassword.text.length < 5) {
      return GlobalFunction()
          .messageAlert('La contraseña debe contener al menos 5 caracters');
    }

    apiInterface.responseSaveUser(editEmail.text.trim(), editName.text.trim(),
        editLastName.text.trim(), editPassword.text.trim(), 2, (code, data) {
      if (code != 1) return;
      clearTextField();
      GlobalFunction().messageAlert(data);
      GlobalFunction().closeView();
      return null;
    });
  }

  /// Clear textFiel
  clearTextField() {
    editName.clear();
    editLastName.clear();
    editEmail.clear();
    editPassword.clear();
    notifyListeners();
  }
}
