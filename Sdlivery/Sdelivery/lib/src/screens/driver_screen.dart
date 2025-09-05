import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../i18n/app_strings.dart';
import '../services/firebase_service.dart';

class DriverScreen extends ConsumerWidget {
  static const route = '/driver';
  const DriverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = S.of(context);
    final session = ref.watch(sessionProvider)!;

    Future<void> setStatus(String status) async {
      final svc = ref.read(firebaseServiceProvider);
      await svc.updateStudentStatus(
        schoolId: session.schoolId,
        classId: session.classId,
        studentId: session.name,
        driverId: session.id,
        status: status,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.driverPanel, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => setStatus('arrived'),
            child: Text(t.arrived),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => setStatus('late'),
            child: Text(t.late),
          ),
          const SizedBox(height: 8),
          FilledButton.outlined(
            onPressed: () => setStatus('home'),
            child: Text(t.home),
          ),
        ],
      ),
    );
  }
}
