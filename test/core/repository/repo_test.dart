import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:paragone/core/repository/repo.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_firebase.dart';

void main() {
  var firebase = MockFirebaseDatabase();
  var databaseRef = MockDatabaseReference();
  var data = MockDataSnapshot();
  var dataIncremented = MockDataSnapshot();
  var transactionResult = MockTransactionResults();
  var repository = FirebaseRepository(firebase);

  setUpAll(() {
    when(firebase.reference()).thenReturn(databaseRef);

    when(databaseRef.child('counter')).thenReturn(databaseRef);
    when(databaseRef.once()).thenReturn(Future(() => data));
    when(data.value).thenReturn(1);
    when(dataIncremented.value).thenReturn(2);

    // TODO Somehow run the transaction handler to actually run incrementation
    when(transactionResult.dataSnapshot).thenReturn(dataIncremented);
    when(databaseRef.runTransaction(typed(any)))
        .thenAnswer((_) => Future(() => transactionResult));
  });

  test('should return counter', () async {
    var counter = await repository.getCounter();

    expect(counter, equals(1));
  });

  test('should increment counter', () async {
    await repository.getCounter();
    var counterIncremented = await repository.incrementCounter();

    expect(counterIncremented, equals(2));
  });

  test('should set persistance enabled on configure', () async {
    await repository.configure();

    verify(firebase.setPersistenceEnabled(true));
  });
}
