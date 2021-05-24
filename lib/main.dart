import 'package:app_scanner/constants/app_theme.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'constants/strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginStore _loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<LoginStore>(create: (_) => _loginStore)],
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
