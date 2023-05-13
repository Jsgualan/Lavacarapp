

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/repositories/api_rest.dart';
import 'ui/page/page_calendar.dart';
import 'ui/page/page_contact.dart';
import 'ui/page/page_detail_reserve.dart';
import 'ui/page/page_list_operator.dart';
import 'ui/page/page_log_in.dart';
import 'ui/page/page_map.dart';
import 'ui/page/page_notification.dart';
import 'ui/page/page_operator.dart';
import 'ui/page/page_principal.dart';
import 'ui/page/page_register_reserve.dart';
import 'ui/page/page_register_user.dart';
import 'ui/page/page_service.dart';
import 'ui/page/page_splash.dart';
import 'ui/provider/providerMap.dart';
import 'ui/provider/provider_log_in.dart';
import 'ui/provider/provider_operator.dart';
import 'ui/provider/provider_principal.dart';
import 'ui/provider/provider_reserve.dart';
import 'ui/provider/provider_service.dart';
import 'ui/provider/provider_splash.dart';
import 'ui/provider/provider_user.dart';
import 'ui/util/global_function.dart';
import 'ui/util/global_label.dart';
import 'ui/util/global_notification.dart';
import 'ui/util/style_scroll.dart';
import 'package:timezone/data/latest.dart' as tz;

/// Notification background
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await GlobalNotification().setupFlutterNotifications();
  GlobalNotification().showFlutterNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb){
    await Firebase.initializeApp();
  }else{
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBXRHZmj7gWB86W_mjLkM4B71kVyy24anM",
            authDomain: "lavacar-ac83f.firebaseapp.com",
            projectId: "lavacar-ac83f",
            storageBucket: "lavacar-ac83f.appspot.com",
            messagingSenderId: "491398396053",
            appId: "1:491398396053:web:5f8dd44c7262e25945439c",
            measurementId: "G-1FKPZN66S6"));
  }

  tz.initializeTimeZones();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await GlobalNotification().setupFlutterNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSplash()),
        ChangeNotifierProvider(create: (_) => ProviderLogIn(ApiRest())),
        ChangeNotifierProvider(create: (_) => ProviderPrincipal(ApiRest())),
        ChangeNotifierProvider(create: (_) => ProviderReserve(ApiRest())),
        ChangeNotifierProvider(create: (_) => ProviderOperator(ApiRest())),
        ChangeNotifierProvider(create: (_) => ProviderUser(ApiRest())),
        ChangeNotifierProvider(create: (_) => ProviderMap()),
        ChangeNotifierProvider(create: (_) => ProviderService(ApiRest())),
      ],
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
          navigatorKey: GlobalFunction.contextGlobal,
          debugShowCheckedModeBanner: false,
          title: GlobalLabel.appName,
          scrollBehavior: StyleScroll(),
          home: PageSplash(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.dark)),
          routes: <String, WidgetBuilder>{
            PageSplash.route: (_) => PageSplash(),
            PageLogIn.route: (_) => PageLogIn(),
            PagePrincipal.route: (_) => PagePrincipal(),
            PageRegisterReserve.route: (_) => PageRegisterReserve(),
            PageOperator.route: (_) => PageOperator(),
            PageListOperator.route: (_) => PageListOperator(),
            PageRegisterUser.route: (_) => PageRegisterUser(),
            PageDetailReserve.route: (_) => PageDetailReserve(),
            PageNotification.route: (_) => PageNotification(),
            PageCalendar.route: (_) => PageCalendar(),
            PageMap.route: (_) => PageMap(),
            PageService.route: (_) => PageService(),
            PageContact.route: (_) => PageContact(),
          }),
    );
  }
}
