import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

abstract class Repository {
  Future<Repository> configure();

  Future<int> incrementCounter();

  Future<int> getCounter();

  cleanUp();

  factory Repository() => FirebaseRepository(new FirebaseDatabase());
}

class FirebaseRepository implements Repository {
  FirebaseDatabase _database;
  DatabaseReference _counterRef;

  @visibleForTesting
  FirebaseRepository(this._database);

  @override
  Future<Repository> configure() async {
    await _database.setPersistenceEnabled(true);
    return this;
  }

  @override
  Future<int> incrementCounter() async {
    var transactionHandler = (MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    };
    var transactionResult = await _counterRef.runTransaction(transactionHandler);
    return transactionResult.dataSnapshot.value;
  }

  // FIXME Implement real time updates
  @override
  Future<int> getCounter() async {
    var value = 0;
    _counterRef = _database.reference().child('counter');
    await _counterRef
        .once()
        .then((DataSnapshot snapshot) => value = snapshot.value);
    return value;
  }

  @override
  void cleanUp() {
    // nothing for now
  }
}
