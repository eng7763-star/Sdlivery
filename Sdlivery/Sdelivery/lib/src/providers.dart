import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/firebase_service.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) => FirebaseService());

class Session {
  final String role; // driver|student|admin
  final String name;
  final String schoolId;
  final String classId;
  final String id; // driverId or studentId
  Session({required this.role, required this.name, required this.schoolId, required this.classId, required this.id});
}

final sessionProvider = StateProvider<Session?>((ref) => null);
