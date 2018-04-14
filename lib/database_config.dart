import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class FirebaseConfig {
  final String url;
  final String apiKey;
  final String appIdIos;
  final String appIdAndroid;
  final String gcmSenderId;

  FirebaseConfig(this.url, this.apiKey, this.appIdIos, this.appIdAndroid,
      this.gcmSenderId);
}

class FirebaseConfigJsonFile {
  Future<FirebaseConfig> load() async {
    String jsonString =
        await rootBundle.loadString('assets/config/firebase_config.json');
    Map jsonConfig = json.decode(jsonString);
    return FirebaseConfig(
        jsonConfig['databaseUrl'],
        jsonConfig['apiKey'],
        jsonConfig['appIdIos'],
        jsonConfig['apIdAndroid'],
        jsonConfig['gcnSenderId']);
  }
}
