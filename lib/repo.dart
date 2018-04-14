import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:paragone/database_config.dart';

class Repository {
  FirebaseApp _app;
  FirebaseDatabase _database;

  DatabaseReference _counterRef;

  Future<Repository> configure() async {
    var firebaseConfig = await FirebaseConfigJsonFile().load();
    _app = await FirebaseApp.configure(
      name: 'Paragone',
      options: _options(firebaseConfig),
    );
    _database = new FirebaseDatabase(app: _app);
    await _database.setPersistenceEnabled(true);
    return this;
  }

  FirebaseOptions _options(FirebaseConfig firebaseConfig) {
    if (Platform.isIOS) {
      return new FirebaseOptions(
        googleAppID: firebaseConfig.appIdIos,
        gcmSenderID: firebaseConfig.gcmSenderId,
        apiKey: firebaseConfig.apiKey,
        databaseURL: firebaseConfig.url,
      );
    } else {
      return new FirebaseOptions(
        googleAppID: firebaseConfig.appIdAndroid,
        apiKey: firebaseConfig.apiKey,
        databaseURL: firebaseConfig.url,
      );
    }
  }

  Future<int> incrementCounter() async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
    return transactionResult.dataSnapshot.value;
  }

  // FIXME Implement real time updates
  Future<int> getCounter() async {
    var value = 0;
    _counterRef = _database.reference().child('counter');
    await _counterRef
        .once()
        .then((DataSnapshot snapshot) => value = snapshot.value);
    return value;
  }

  void cleanUp() {
    // nothing for now
  }
}
