import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

abstract class Repository {
  Future<Repository> configure();

  Future<int> incrementCounter();

  Future<int> getCounter();

  cleanUp();

  factory Repository() => _FirebaseRepository();
}

class _FirebaseRepository implements Repository {
  FirebaseDatabase _database;
  DatabaseReference _counterRef;

  @override
  Future<Repository> configure() async {
    _database = new FirebaseDatabase();
    await _database.setPersistenceEnabled(true);
    return this;
  }

  @override
  Future<int> incrementCounter() async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
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
