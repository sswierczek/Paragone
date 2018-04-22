import 'package:firebase_database/firebase_database.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockDataSnapshot extends Mock implements DataSnapshot {}

class MockTransactionResults extends Mock implements TransactionResult {}