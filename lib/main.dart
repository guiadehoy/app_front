import 'package:app_scanner/constants/app_theme.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/utils/remote_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginStore _loginStore = LoginStore();
  var _remoteConfigService = RemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(create: (_) => _loginStore),
        Provider<RemoteConfigService>(create: (_) => _remoteConfigService)
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            initialRoute: Routes.splash,
            routes: Routes.routes,
            theme: themeData,
          );
        },
      ),
    );
  }
}
