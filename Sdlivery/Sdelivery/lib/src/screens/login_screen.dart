import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../i18n/app_strings.dart';
import '../providers.dart';
import '../services/firebase_service.dart';
import '../models.dart';
import 'dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const route = '/';
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String role = 'driver';
  final nameCtrl = TextEditingController();
  final schoolCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final studentNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final isAr = t.isAr;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(t.loginTitle)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'driver', label: Text(t.roleDriver)),
                  ButtonSegment(value: 'student', label: Text(t.roleStudent)),
                  ButtonSegment(value: 'admin', label: Text(t.roleAdmin)),
                ],
                selected: {role},
                onSelectionChanged: (s) => setState(() => role = s.first),
              ),
              const SizedBox(height: 16),
              TextField(controller: nameCtrl, decoration: InputDecoration(labelText: t.name)),
              const SizedBox(height: 8),
              TextField(controller: schoolCtrl, decoration: InputDecoration(labelText: t.school)),
              const SizedBox(height: 8),
              TextField(controller: classCtrl, decoration: InputDecoration(labelText: t.className)),
              if (role == 'student') ...[
                const SizedBox(height: 8),
                TextField(controller: studentNameCtrl, decoration: InputDecoration(labelText: t.student)),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  final name = nameCtrl.text.trim();
                  final schoolId = schoolCtrl.text.trim().isEmpty ? 'school1' : schoolCtrl.text.trim();
                  final classId = classCtrl.text.trim().isEmpty ? 'classA' : classCtrl.text.trim();
                  if (name.isEmpty) return;

                  final svc = ref.read(firebaseServiceProvider);

                  if (role == 'driver') {
                    final driverId = name;
                    await svc.registerDriver(Driver(id: driverId, name: name, schoolId: schoolId, classId: classId));
                    ref.read(sessionProvider.notifier).state = Session(
                      role: 'driver', name: name, schoolId: schoolId, classId: classId, id: driverId,
                    );
                  } else if (role == 'student') {
                    final driverId = name;
                    final studentId = studentNameCtrl.text.trim().isEmpty ? '${name}_student' : studentNameCtrl.text.trim();
                    await svc.registerStudent(
                      Student(id: studentId, name: studentId, schoolId: schoolId, classId: classId, driverId: driverId),
                    );
                    ref.read(sessionProvider.notifier).state = Session(
                      role: 'student', name: studentId, schoolId: schoolId, classId: classId, id: studentId,
                    );
                  } else {
                    ref.read(sessionProvider.notifier).state = Session(
                      role: 'admin', name: name, schoolId: schoolId, classId: classId, id: name,
                    );
                  }

                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, DashboardScreen.route);
                },
                child: Text(S.of(context).continueLbl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
