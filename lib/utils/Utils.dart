import 'dart:convert';
import 'dart:io';

import 'package:app_scanner/ui/no_connection.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Utils {
  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  static Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static checkConnection(BuildContext context) async {
    Future<bool> status = internetConnectivity();

    bool _permissionStatus = await status;
    if (!_permissionStatus) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoConnectionScreen()),
      );
    }
  }

  static String manageError(DioError ex) {
    String errorMessage =
        "Ocurrion un error al  conectarse al servidor de Guía De Hoy, intentelo de nuevo más tarde.";

    var response = ex.response;
    if (response != null) {
      errorMessage = json.decode(ex.response.toString())["message"];
    }

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
    return errorMessage;
  }
}
