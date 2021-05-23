import 'dart:convert';
import 'dart:io';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/models/event_list.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/ui/detail_event_screen.dart';
import 'package:app_scanner/utils/api_client.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LoginStore _loginStore;
  late Client _client = Client();
  late EventList eventList;
  late bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: body(),
    );
  }

  Widget listAndTitle() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Text(
                    "Eventos del día",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 20.0,
                      letterSpacing: -0.4,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  Assets.logoutIcon,
                  cacheHeight: 24,
                  cacheWidth: 24,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: eventList.events.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailEventScreen()),
                    );
                  },
                  title: Text(eventList.events[index].name),
                  subtitle: Text(eventList.events[index].hourLabel),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(eventList.events[index].image),
                  ),
                ),
              );
            },
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
        : CircularProgressIndicator.adaptive();
  }

  Future<EventList> fetchEvents() async {
    try {
      setState(() {
        loading = false;
      });

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
      String errorMessage = json.decode(ex.response.toString())["message"];
      setState(() {
        loading = true;
      });
      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            icon: Icon(Icons.error, color: Colors.redAccent),
            onPressed: cancel,
          ),
        ),
        title: (_) => Text('Error'),
        subtitle: (_) => Text(errorMessage),
        trailing: (cancel) => IconButton(
          icon: Icon(Icons.cancel),
          onPressed: cancel,
        ),
        onTap: () {},
        onLongPress: () {},
        enableSlideOff: true,
        contentPadding: EdgeInsets.all(0.0),
        onlyOne: true,
        animationDuration: Duration(milliseconds: 500),
        animationReverseDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 4),
      );

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
                title: Text("Advertencia"),
                content: Text(
                  "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                  style: TextStyle(fontSize: 16.0),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "Aceptar",
                    ),
                    onPressed: () {
                      _loginStore.logout();
                      Navigator.of(context).pushNamed(Routes.login);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "Cancelar",
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(
                  "Advertencia",
                  style: TextStyle(fontSize: 24),
                ),
                content: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Mensaje de cierre",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Aceptar"),
                    onPressed: () {
                      _loginStore.logout();
                      Navigator.of(context).pushNamed(Routes.login);
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
      },
    );
  }
}
