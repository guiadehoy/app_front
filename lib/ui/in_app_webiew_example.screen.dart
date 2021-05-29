import 'dart:collection';
import 'dart:io';

import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppWebViewExampleScreen extends StatefulWidget {
  final String url;

  InAppWebViewExampleScreen({required this.url});

  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool authUser = false;
  String name = '';
  String email = '';
  String image = '';
  String profile = 'https://www.gravatar.com/avatar?d=mp';

  late LoginStore _loginStore;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    Utils.checkConnection(context);
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  savePropInPreferences(InAppWebViewController controller, key, type) async {
    var value = await controller.webStorage.localStorage.getItem(key: key);

    final SharedPreferences preferences = await this._prefs;
    if (value != null) {
      if (type == "string") {
        await preferences.setString(key, value);
      }

      if (type == "bool") {
        await preferences.setBool(key, value);
      }

      if (type == "int") {
        await preferences.setInt(key, value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: Observer(
        builder: (_) => Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(
                  _loginStore.email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                accountName: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Observer(
                    builder: (_) => Text(
                      _loginStore.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: new NetworkImage(_loginStore.profile),
                ),
              ),
              ListTile(
                title: Text('Inicio'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.home);
                },
              ),
              ListTile(
                title: Text('Comida'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.food);
                },
              ),
              (this.authUser == false)
                  ? ListTile(
                      title: Text('Iniciar sesión'),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                    )
                  : ListTile(
                      title: Text('Cerrar sesión'),
                      onTap: () async {
                        Future<SharedPreferences> _prefs =
                            SharedPreferences.getInstance();
                        final SharedPreferences preferences = await _prefs;

                        if (webViewController != null) {
                          await webViewController!.webStorage.localStorage
                              .removeItem(key: "auth_token");

                          preferences.remove("auth_token");
                        }
                        logout();
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                    ),
            ],
          ),
        ),
      ),
      onDrawerChanged: (isOpen) async {
        if (isOpen) {
          await saveDataForDrawer();
        }
      },
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialUserScripts: UnmodifiableListView<UserScript>([]),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) async {
                      await controller.webStorage.localStorage
                          .setItem(key: "pwa", value: "true");

                      savePreferenceFromController(controller);
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT,
                      );
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      return await shouldOverrideUrlLoadingWebview(
                          navigationAction);
                    },
                    onLoadStop: (controller, url) async {
                      savePreferenceFromController(controller);

                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = this.url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },
                  ),
                ),
                Align(alignment: Alignment.center, child: _buildProgressBar()),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildProgressBar() {
    if (progress != 1.0) {
      return CircularProgressIndicator();
    }
    return Container();
  }

  Future<NavigationActionPolicy> shouldOverrideUrlLoadingWebview(
      NavigationAction navigationAction) async {
    var uri = navigationAction.request.url!;

    if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
        .contains(uri.scheme)) {
      if (await canLaunch(url)) {
        // Launch the App
        await launch(
          url,
        );
        // and cancel the request
        return NavigationActionPolicy.CANCEL;
      }
    }

    return NavigationActionPolicy.ALLOW;
  }

  void logout() {
    _loginStore.setEmail("juanpereze@example.do");
    _loginStore.setName("Juan Perez");
    _loginStore.setProfile("https://www.gravatar.com/avatar?d=mp");
    _loginStore.setLogged(false);
  }

  Future saveDataForDrawer() async {
    final SharedPreferences preferences = await this._prefs;

    var token = preferences.getString("auth_token");
    var firstName = preferences.getString("name");
    var email = preferences.getString("email");
    var profileImage = preferences.getString("profile");

    if (token != null) {
      setState(() {
        this.authUser = true;
      });

      _loginStore.setEmail(email ?? '');
      _loginStore.setName(firstName ?? '');
      _loginStore.setProfile(profileImage ?? '');
      _loginStore.setLogged(true);
    } else {
      setState(() {
        logout();
        this.authUser = false;
      });
    }
  }

  void savePreferenceFromController(InAppWebViewController controller) {
    savePropInPreferences(controller, "auth_token", "string");
    savePropInPreferences(controller, "last_name", "string");
    savePropInPreferences(controller, "gender", "string");
    savePropInPreferences(controller, "refresh_token", "string");
    savePropInPreferences(controller, "first_name", "string");
    savePropInPreferences(controller, "is_first_login", "bool");
    savePropInPreferences(controller, "name", "string");
    savePropInPreferences(controller, "email", "string");
    savePropInPreferences(controller, "profile", "string");
    saveDataForDrawer();
  }
}
