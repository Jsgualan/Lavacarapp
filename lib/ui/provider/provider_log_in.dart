import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/model/response_user.dart';
import '../../domain/repositories/api_interface.dart';
import '../page/page_principal.dart';
import '../page/page_register_user.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_preference.dart';
import '../util/global_widget.dart';
import 'provider_principal.dart';
import 'provider_user.dart';

class ProviderLogIn with ChangeNotifier {
  ApiInterface apiInterface;
  TextEditingController editEmail = TextEditingController();
  TextEditingController editPassword = TextEditingController();
  bool? _stateShowEditPassword = true;
  String? _version = '1.0.0';
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn? googleSignIn = GoogleSignIn();

  ProviderLogIn(this.apiInterface);

  String get version => _version!;

  set version(String value) {
    _version = value;
  }

  bool get stateShowEditPassword => _stateShowEditPassword!;

  set stateShowEditPassword(bool value) {
    _stateShowEditPassword = value;
    notifyListeners();
  }

  /// Show and Hide password
  showPassword() {
    if (!_stateShowEditPassword!) {
      _stateShowEditPassword = true;
    } else {
      _stateShowEditPassword = false;
    }
    notifyListeners();
  }

  /// Clean text field user and password
  cleanTextField() {
    editEmail.clear();
    editPassword.clear();
    notifyListeners();
  }

  /// Get version application
  getVersionApplication() async {
    await Future.delayed(const Duration(milliseconds: 300));
    GlobalPreference.getDataDispositive().then((data) {
      if (!kIsWeb) {
        version = '${GlobalLabel.textVersion} ${data!.version!}';
      }
    });
    notifyListeners();
  }

  /// LogIn
  logIn(ProviderPrincipal providerPrincipal) {
    if (editEmail.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWriteName);
    }
    if (editPassword.text.trim().isEmpty) {
      return GlobalFunction().messageAlert(GlobalLabel.textWritePassword);
    }

    apiInterface.responseLogIn(editEmail.text.trim(), editPassword.text.trim(),
        (code, data) {
      ResponseUser responseUser = data;
      if (code != 1) return GlobalFunction().messageAlert(responseUser.m!);
      GlobalPreference().setDataUser(responseUser.u!);
      GlobalPreference().setStateLogin(true);
      cleanTextField();
      providerPrincipal.user = responseUser.u!;
      Navigator.of(GlobalFunction.contextGlobal.currentContext!)
          .pushNamedAndRemoveUntil(PagePrincipal.route, (route) => false);
      return null;
    });
  }

  /// Get data user with login facebook
  Future loginFacebook(
      ProviderPrincipal providerPrincipal, ProviderUser providerUser) async {
    await FacebookAuth.instance.logOut();
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      FacebookAuth.instance.getUserData().then((userData) {
        apiInterface.responseCheckUser(userData['email'], (code, data) {
          if (code == 1) {
            GlobalFunction().hideProgress();
            ResponseUser responseUser = data;
            if (code != 1) {
              return GlobalFunction().messageAlert(responseUser.m!);
            }
            GlobalPreference().setDataUser(responseUser.u!);
            GlobalPreference().setStateLogin(true);
            providerPrincipal.user = responseUser.u!;
            Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                .pushNamedAndRemoveUntil(PagePrincipal.route, (route) => false);
          } else {
            GlobalFunction().hideProgress();
            providerUser.editEmail.text = userData['email'];
            GlobalWidget().animationNavigatorView(PageRegisterUser());
          }
          return null;
        });
      });
    } else if (result.status == LoginStatus.cancelled) {
      GlobalFunction().hideProgress();
      GlobalFunction().messageAlert(GlobalLabel.textCancelProcess);
    } else {
      GlobalFunction().hideProgress();
      GlobalFunction().messageAlert(GlobalLabel.textNotData);
    }
  }

  /// Get data user with login google
  loginGoogle(
      ProviderPrincipal providerPrincipal, ProviderUser providerUser) async {
    googleSignIn!.isSignedIn().then((value) {
      if (value) {
        googleSignIn!.disconnect();
      }
    });
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn!.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          apiInterface.responseCheckUser(userCredential.user!.email!,
              (code, data) {
            if (code == 1) {
              googleSignIn!.disconnect();
              GlobalFunction().hideProgress();
              ResponseUser responseUser = data;
              if (code != 1) {
                return GlobalFunction().messageAlert(responseUser.m!);
              }
              GlobalPreference().setDataUser(responseUser.u!);
              GlobalPreference().setStateLogin(true);
              providerPrincipal.user = responseUser.u!;
              Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                  .pushNamedAndRemoveUntil(
                      PagePrincipal.route, (route) => false);
            } else {
              googleSignIn!.disconnect();
              GlobalFunction().hideProgress();
              providerUser.editEmail.text = userCredential.user!.email!;
              GlobalWidget().animationNavigatorView(PageRegisterUser());
            }
            return null;
          });
        }
      } catch (e) {
        GlobalFunction().hideProgress();
        GlobalFunction().messageAlert(GlobalLabel.textNotData);
      }
    }
  }
}
