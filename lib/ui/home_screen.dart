import 'package:app_scanner/routes.dart';
import 'package:app_scanner/ui/datail_event_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
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
          "Listado de eventos",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration(milliseconds: 0),
                  () {
                    Navigator.of(context).pushNamed(Routes.login);
                  },
                );
              },
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
}
