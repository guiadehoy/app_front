import 'dart:io';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/models/event_list.dart';
import 'package:app_scanner/models/event_response.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/ui/detail_event_screen.dart';
import 'package:app_scanner/ui/no_connection.dart';
import 'package:app_scanner/utils/api_client.dart';
import 'package:app_scanner/utils/utils.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LoginStore _loginStore;
  late Client _client = Client();
  late EventList eventList = new EventList(events: []);
  late bool loading = true;

  @override
  void initState() {
    setState(() {
      this.loading = false;
    });
    super.initState();
    // initPlatformState();
    fetchEventsCheckConnection();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'null';
    }
    if (!mounted) return;

    _loginStore.setDeviceId(deviceId!);
    print(_loginStore.devideId);
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Eventos del día",
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 20.0,
              letterSpacing: -0.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  _buildloguotAlert();
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light),
      body: body(),
    );
  }

  Widget listAndTitle() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ListView.builder(
              itemCount: eventList.events.length,
              itemBuilder: (context, index) {
                return CardEvent(
                  loginStore: _loginStore,
                  event: eventList.events[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return loading
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: listAndTitle(),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Future<void> fetchEventsCheckConnection() async {
    setState(() {
      loading = false;
    });

    Future<bool> status = Utils.internetConnectivity();

    bool _permissionStatus = await status;
    print('Ejecuntando permisos$_permissionStatus');

    if (!_permissionStatus) {
      print("Entrando a no conexión");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoConnectionScreen(),
        ),
      );
      setState(() {
        this.loading = true;
      });
    } else {
      print('Ejecuntando permisos ejecutando$_permissionStatus');
      fetchEvents();
    }
  }

  Future<EventList> fetchEvents() async {
    try {
      final response = await _client.init().get('/scanner/events/user');

      var eventListData = EventList.fromJson(response.data);
      setState(() {
        this.eventList = eventListData;
      });

      setState(() {
        loading = true;
      });

      return eventListData;
    } on DioError catch (ex) {
      setState(() {
        this.loading = true;
      });

      String errorMessage = Utils.manageError(ex);
      throw new Exception(errorMessage);
    }
  }

  _buildloguotAlert() async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(
                  "Advertencia",
                  style: TextStyle(fontSize: 16.0),
                ),
                content: Text(
                  "¿Estas seguro que quieres cerrar sesión?",
                  style: TextStyle(fontSize: 16.0),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "Cancelar",
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "Aceptar",
                    ),
                    onPressed: () {
                      _loginStore.logout();
                      Navigator.of(context).pushNamed(Routes.login);
                    },
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(
                  "Advertencia",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                content: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "¿Estas seguro que quieres cerrar sesión?",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButtonWidget(
                    buttonText: "Aceptar",
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      _loginStore.logout();
                      Navigator.of(context).pushNamed(Routes.login);
                    },
                  ),
                ],
              );
      },
    );
  }
}

class CardEvent extends StatelessWidget {
  const CardEvent({
    Key? key,
    required this.event,
    required this.loginStore,
  }) : super(key: key);

  final EventResponse event;
  final LoginStore loginStore;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: ListTile(
        onTap: () {
          loginStore.setEventSelected(event);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailEventScreen(
                openQr: false,
              ),
            ),
          );
        },
        title: Text(
          event.name,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20.0,
            letterSpacing: -0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Image.asset(
                      Assets.clockIcon,
                      width: 16.0,
                      height: 16.0,
                    ),
                  ),
                  Text(
                    event.hourLabel,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Image.asset(
                      Assets.ticketIcon,
                      width: 16.0,
                      height: 16.0,
                    ),
                  ),
                  Text(
                    event.scannedQrLabel,
                  )
                ],
              ),
            ],
          ),
        ),
        leading: Container(
          child: SizedBox(
            height: 72.0,
            width: 72.0,
            child: Image.network(
              event.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
