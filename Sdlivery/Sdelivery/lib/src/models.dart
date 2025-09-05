class Driver {
  final String id;
  final String name;
  final String schoolId;
  final String classId;
  final Map<String, bool> students; // studentId -> true

  Driver({
    required this.id,
    required this.name,
    required this.schoolId,
    required this.classId,
    this.students = const {},
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'schoolId': schoolId,
        'classId': classId,
        'students': students,
      };

  factory Driver.fromMap(String id, Map data) => Driver(
        id: id,
        name: data['name'] ?? '',
        schoolId: data['schoolId'] ?? '',
        classId: data['classId'] ?? '',
        students: (data['students'] as Map?)?.cast<String, bool>() ?? {},
      );
}

class Student {
  final String id;
  final String name;
  final String schoolId;
  final String classId;
  final String driverId;

  Student({
    required this.id,
    required this.name,
    required this.schoolId,
    required this.classId,
    required this.driverId,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'schoolId': schoolId,
        'classId': classId,
        'driverId': driverId,
      };

  factory Student.fromMap(String id, Map data) => Student(
        id: id,
        name: data['name'] ?? '',
        schoolId: data['schoolId'] ?? '',
        classId: data['classId'] ?? '',
        driverId: data['driverId'] ?? '',
      );
}

class TripStatus {
  final String status; // arrived|late|home|pending
  final int updatedAt;
  final String by; // driverId

  TripStatus({required this.status, required this.updatedAt, required this.by});

  Map<String, dynamic> toMap() => {
        'status': status,
        'updatedAt': updatedAt,
        'by': by,
      };

  factory TripStatus.fromMap(Map data) => TripStatus(
        status: data['status'] ?? 'pending',
        updatedAt: data['updatedAt'] ?? 0,
        by: data['by'] ?? '',
      );
}
