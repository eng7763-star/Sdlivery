import 'package:firebase_database/firebase_database.dart';
import '../models.dart';

class FirebaseService {
  final db = FirebaseDatabase.instance.ref('sdelivery');

  Future<void> addSchool(String schoolId, String name) async {
    await db.child('schools/$schoolId').set({'name': name});
  }

  Future<void> addClass(String schoolId, String classId, String name) async {
    await db.child('schools/$schoolId/classes/$classId').set(name);
  }

  Future<void> registerDriver(Driver d) async {
    await db.child('drivers/${d.id}').set(d.toMap());
  }

  Future<void> registerStudent(Student s) async {
    await db.child('students/${s.id}').set(s.toMap());
    await db
        .child('trips/${s.schoolId}/${s.classId}/${s.id}')
        .set(TripStatus(status: 'pending', updatedAt: DateTime.now().millisecondsSinceEpoch, by: '').toMap());
  }

  Stream<Map<String, TripStatus>> watchClassStatuses(String schoolId, String classId) {
    final ref = db.child('trips/$schoolId/$classId');
    return ref.onValue.map((event) {
      final data = event.snapshot.value as Map?;
      final out = <String, TripStatus>{};
      if (data != null) {
        data.forEach((k, v) {
          out[k] = TripStatus.fromMap((v as Map));
        });
      }
      return out;
    });
  }

  Future<void> updateStudentStatus({
    required String schoolId,
    required String classId,
    required String studentId,
    required String driverId,
    required String status, // arrived|late|home
  }) async {
    final ref = db.child('trips/$schoolId/$classId/$studentId');
    await ref.update({
      'status': status,
      'updatedAt': ServerValue.timestamp,
      'by': driverId,
    });
  }
}
