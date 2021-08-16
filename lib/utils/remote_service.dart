import 'package:app_scanner/utils/preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _BOOLEAN_VALUE = 'sample_bool_value';
const String _INT_VALUE = 'sample_int_value';
const String _STRING_VALUE = 'url_backend';

class RemoteConfigService {
  final RemoteConfig? _remoteConfig;
  RemoteConfigService({RemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    _BOOLEAN_VALUE: false,
    _INT_VALUE: 01,
    _STRING_VALUE: "https://app.dev.guiadehoy.com/jijoles"
  };

  static RemoteConfigService? _instance;
  static Future<RemoteConfigService?> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: RemoteConfig.instance,
      );
    }

    _instance!._remoteConfig!.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(minutes: 1),
    ));

    return _instance;
  }

  bool get getBoolValue => _remoteConfig!.getBool(_BOOLEAN_VALUE);
  int get getIntValue => _remoteConfig!.getInt(_INT_VALUE);
  String get getStringValue => _remoteConfig!.getString(_STRING_VALUE);

  Future initialize() async {
    try {
      await _remoteConfig!.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (e) {
      print("Rmeote Config fetch throttled: $e");
      print("Unable to fetch remote config. Default value will be used");
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig!.fetch();
    await _remoteConfig!.fetchAndActivate();
    _remoteConfig!.getAll();
  }
}
