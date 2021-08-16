import 'dart:collection';
import 'dart:io';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/utils/remote_service.dart';
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

  late RemoteConfigService _remoteConfigService;

  initializeRemoteConfig() async {
    _remoteConfigService = (await RemoteConfigService.getInstance())!;
    setState(() {
      this.urlCompleted = _remoteConfigService.getStringValue + widget.url;
    });

    print(_remoteConfigService.getStringValue + widget.url);
  }

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
  String urlCompleted = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
    this.initializeRemoteConfig();
    Utils.checkConnection(context);

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

  getUrlWebpage() async {
    final SharedPreferences preferences = await this._prefs;
    setState(() {
      this.urlCompleted = preferences.getString("url")!;
    });
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xF0754395), //change your color here
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.home);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              Assets.logoFull,
              width: 120,
            ),
          ),
        ),
      ),
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
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: new NetworkImage(_loginStore.profile),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color(0xFF666666),
                ),
                title: Text(
                  'Inicio',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.home);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.food_bank,
                  color: Color(0xFF666666),
                ),
                title: Text(
                  'Comida',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.food);
                },
              ),
              this.authUser
                  ? ListTile(
                      leading: Icon(
                        Icons.history_toggle_off_sharp,
                        color: Color(0xFF666666),
                      ),
                      title: Text(
                        'Próximos eventos',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.next);
                      },
                    )
                  : Text(""),
              this.authUser
                  ? ListTile(
                      leading: Icon(
                        Icons.history,
                        color: Color(0xFF666666),
                      ),
                      title: Text(
                        'Historial de compras',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.history);
                      },
                    )
                  : Text(""),
              (this.authUser == false)
                  ? ListTile(
                      leading: Icon(
                        Icons.login,
                        color: Color(0xFF666666),
                      ),
                      title: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.login);
                      },
                    )
                  : ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Color(0xFF666666),
                      ),
                      title: Text(
                        'Cerrar sesión',
                        style: TextStyle(
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0),
                      ),
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
                        Navigator.pushNamed(context, Routes.login);
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
                  child: this.urlCompleted != ""
                      ? InAppWebView(
                          key: webViewKey,
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(this.urlCompleted)),
                          initialUserScripts:
                              UnmodifiableListView<UserScript>([]),
                          initialOptions: options,
                          pullToRefreshController: pullToRefreshController,
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                            controller.webStorage.localStorage
                                .setItem(key: "pwa", value: "true");
                            var value = controller.webStorage.localStorage
                                .getItem(key: "pwa");

                            print(value);
                          },
                          onLoadStart: (controller, url) async {
                            print(this.urlCompleted);
                            await controller.webStorage.localStorage
                                .setItem(key: "pwa", value: "true");

                            var value = await controller.webStorage.localStorage
                                .getItem(key: "pwa");

                            print(value);

                            savePreferenceFromController(controller);
                            setState(() {
                              this.url = url.toString();
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
                            });
                          },
                          onUpdateVisitedHistory:
                              (controller, url, androidIsReload) {
                            setState(() {
                              this.url = url.toString();
                            });
                          },
                          onConsoleMessage: (controller, consoleMessage) {
                            print(consoleMessage);
                          },
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
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
      _loginStore.setProfile("https://www.gravatar.com/avatar?d=mp");

      if (profileImage != null && profileImage.startsWith("http")) {
        _loginStore.setProfile(profileImage);
      } else {
        _loginStore.setProfile("https://www.gravatar.com/avatar?d=mp");
      }
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
