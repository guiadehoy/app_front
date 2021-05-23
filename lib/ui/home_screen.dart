import 'dart:io';

import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/ui/detail_event_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LoginStore _loginStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  final titles = [
    "Evento 1",
    "Evento 2",
    "Evento 3",
    "Evento 1",
    "Evento 2",
    "Evento 3" "Evento 1",
    "Evento 2",
    "Evento 3" "Evento 1",
    "Evento 2",
    "Evento 3" "Evento 1",
    "Evento 2",
    "Evento 3" "Evento 1",
    "Evento 2",
    "Evento 3"
  ];
  final subtitles = [
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
    "25 de abril 06:00 am",
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Lista de eventos',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => _buildloguotAlert(),
              child: Icon(
                Icons.logout,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
            itemCount: titles.length,
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
                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                  ),
                ),
              );
            }),
      ),
    );
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
