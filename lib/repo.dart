import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Repository {
  FirebaseDatabase _database;

  DatabaseReference _counterRef;

  Future<Repository> configure() async {
    _database = new FirebaseDatabase();
    await _database.setPersistenceEnabled(true);
    return this;
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
