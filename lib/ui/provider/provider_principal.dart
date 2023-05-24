import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lavacar/ui/provider/provider_log_in.dart';
import 'package:lavacar/ui/util/global_notification.dart';

import '../../data/model/response_notification.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/hour.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/api_interface.dart';
import '../page/page_list_operator.dart';
import '../page/page_log_in.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_preference.dart';
import 'provider_reserve.dart';

class ProviderPrincipal with ChangeNotifier {
  ApiInterface apiInterface;
  User? _user = User();
  List<Booking>? listNotification = [];
  List<Booking>? listReserve = [];
  List<Booking>? listTemp = [];
  int? _countPending = 0;
  int? _countFinish = 0;
  Booking? _selectedBooking;
  Booking? _bookingWaitOperator;
  DateTime? _dateTimeSelected;
  bool? _contListNotification = false;
  late FirebaseMessaging messaging;
  String? initialMessage;
  bool _resolved = false;

  bool get contListNotification => _contListNotification!;

  set contListNotification(bool value) {
    _contListNotification = value;
  }

  /// Constructor
  ProviderPrincipal(this.apiInterface);

  DateTime get dateTimeSelected => _dateTimeSelected!;

  set dateTimeSelected(DateTime value) {
    _dateTimeSelected = value;
  }

  Booking get bookingWaitOperator => _bookingWaitOperator!;

  set bookingWaitOperator(Booking value) {
    _bookingWaitOperator = value;
  }

  User get user => _user!;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  Booking get selectedBooking => _selectedBooking!;

  set selectedBooking(Booking value) {
    _selectedBooking = value;
    notifyListeners();
  }

  int get countFinish => _countFinish!;

  set countFinish(int value) {
    _countFinish = value;
    notifyListeners();
  }

  int get countPending => _countPending!;

  set countPending(int value) {
    _countPending = value;
    notifyListeners();
  }

  /// Add list scheduled
  addReserve(
      ProviderReserve providerReserve, String date, DateTime dateTime) async {
    await Future.delayed(const Duration(milliseconds: 200));
    getReserve(providerReserve, date, dateTime);
  }

  /// Get statistics
  statistics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _countPending = 0;
    _countFinish = 0;
    for (Booking booking in listReserve!) {
      if (booking.state == 2) {
        _countPending = _countPending! + 1;
      } else if (booking.state == 3) {
        _countFinish = _countFinish! + 1;
      }
    }

    notifyListeners();
  }

  /// Selected booking
  bookingActive(Booking booking) {
    _selectedBooking = booking;
    notifyListeners();
  }

  /// Get reserve
  getReserve(ProviderReserve providerReserve, String date, DateTime dateTime) {
    apiInterface.responseNotification(date, (code, data) {
      if (code != 1) {
        listNotification!.clear();
        listReserve!.clear();
        listTemp!.clear();
        _countFinish = 0;
        _countPending = 0;
        providerReserve.getReserve(this, date, dateTime.weekday);
        _contListNotification = true;
      } else {
        addListReserve(providerReserve, data, date, dateTime);
      }
      return null;
    });
  }

  /// Reset list hour
  resetListHour(ProviderReserve providerReserve) {
    for (Hour hour in providerReserve.listResult!) {
      hour.state = 1;
      notifyListeners();
    }
  }

  /// Add reserve to list
  /// 1: Pending Accept
  /// 2: Pending start
  /// 3: Finish
  /// 4: Decline
  /// 5: Delete
  addListReserve(
      ProviderReserve providerReserve,
      ResponseNotification responseNotification,
      String date,
      DateTime dateTime) {
    if (listNotification!.isNotEmpty) listNotification!.clear();
    if (listReserve!.isNotEmpty) listReserve!.clear();
    for (Booking booking in responseNotification.lR!) {
      if (booking.state == 1) {
        listNotification!.add(booking);
      } else if (user.rol == 1) {
        if (booking.state == 2 || booking.state == 3) {
          listReserve!.add(booking);
        }
      } else if (user.rol == 2) {
        if ((booking.state == 2 && user.idUser == booking.idUser) ||
            (booking.state == 3 && user.idUser == booking.idUser)) {
          listReserve!.add(booking);
        }
      } else {
        if ((booking.state == 2 && user.idUser == booking.idOperator) ||
            (booking.state == 3 && user.idUser == booking.idOperator)) {
          listReserve!.add(booking);
        }
      }
    }

    if (listNotification!.isNotEmpty) {
      _contListNotification = false;
    } else {
      _contListNotification = true;
    }
    listTemp!.clear();
    listTemp!.addAll(listNotification!);
    listTemp!.addAll(listReserve!);
    statistics();
    providerReserve.getReserve(this, date, dateTime.weekday);
    notifyListeners();
  }

  /// Decline reserve
  declineNotification(String idReserve) {
    apiInterface.responseDeclineNotification(idReserve, 4, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      listNotification!
          .removeWhere((element) => element.idReserve! == idReserve);
      if (listNotification!.isEmpty) {
        _contListNotification = true;
      }
      notifyListeners();
      return null;
    });
  }

  /// Add operator to reserve
  addOperatorReserve(String idReserve, Booking booking) {
    _bookingWaitOperator = booking;
    Navigator.of(GlobalFunction.contextGlobal.currentContext!)
        .pushNamed(PageListOperator.route, arguments: {'type': 1});
  }

  /// Delete reserve
  deleteReserve(String idReserve) {
    apiInterface.responseDeclineNotification(idReserve, 5, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      GlobalFunction().closeView();
      listReserve!.removeWhere((element) => element.idReserve! == idReserve);
      statistics();
      notifyListeners();
      return null;
    });
    notifyListeners();
  }

  /// Decline reserve
  finishReserve(String idReserve, ProviderReserve providerReserve) {
    apiInterface.responseFinishReserve(idReserve, 3, (code, data) {
      if (code != 1) return;
      GlobalFunction().messageAlert(data);
      for (Booking booking in listReserve!) {
        if (booking.idReserve == idReserve) {
          booking.state = 3;
          break;
        }
      }
      GlobalFunction().closeView();
      addReserve(
          providerReserve,
          GlobalFunction().formatterDate.format(_dateTimeSelected!),
          _dateTimeSelected!);
      notifyListeners();
      return null;
    });
  }

  /// Log out
  logOut(ProviderLogIn providerLogIn) {
    GlobalFunction().messageConfirmation(GlobalLabel.textQuestionLogOut, () {
      GlobalPreference().setStateLogin(false);
      listReserve!.clear();
      listNotification!.clear();
      providerLogIn.googleSignIn!.isSignedIn().then((value) {
        providerLogIn.googleSignIn!.disconnect();
        providerLogIn.googleSignIn == null;
      });

      notifyListeners();
      Navigator.of(GlobalFunction.contextGlobal.currentContext!)
          .pushNamedAndRemoveUntil(PageLogIn.route, (route) => false);
    });
  }

  /// Notification push
  notificationPush(ProviderReserve providerReserve) async {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((token) {
      if (token!.isNotEmpty) {
        apiInterface.responseSaveToken(user.idUser!, token, (code, data) {
          return null;
        });
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      if (token.isNotEmpty) {
        apiInterface.responseSaveToken(user.idUser!, token, (code, data) {
          return null;
        });
      }
    }).onError((err) {
      if (kDebugMode) {
        print('Error token >>> $err');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      addReserve(
          providerReserve,
          GlobalFunction().formatterDate.format(GlobalFunction().dateNow),
          GlobalFunction().dateNow);
    });
  }

  /// Initial notification
// initialNotification(){
//   FirebaseMessaging.instance.getInitialMessage().then((value) {
//     _resolved = true;
//     initialMessage = value?.data.toString();
//   });
//
//   FirebaseMessaging.onMessage.listen(GlobalNotification().showFlutterNotification);
//
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print('A new onMessageOpenedApp event was published!');
//     // Navigator.pushNamed(
//     //   context,
//     //   '/message',
//     //   arguments: MessageArguments(message, true),
//     // );
//   });
// }
}
