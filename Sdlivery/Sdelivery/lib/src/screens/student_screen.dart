import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../i18n/app_strings.dart';
import '../services/firebase_service.dart';
import '../models.dart';

class StudentScreen extends ConsumerWidget {
  static const route = '/student';
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = S.of(context);
    final session = ref.watch(sessionProvider)!;
    final svc = ref.watch(firebaseServiceProvider);

    return StreamBuilder<Map<String, TripStatus>>(
      stream: svc.watchClassStatuses(session.schoolId, session.classId),
      builder: (context, snap) {
        final map = snap.data ?? {};
        final mine = map[session.id];
        final isAr = t.isAr;
        return Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(t.studentPanel, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    title: Text('${t.status}: ${_label(t, mine?.status ?? 'pending')}'),
                    subtitle: Text('${t.updatedAt}: ${_date(mine?.updatedAt)}'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _label(S t, String key) {
    switch (key) {
      case 'arrived':
        return t.arrived;
      case 'late':
        return t.late;
      case 'home':
        return t.home;
      default:
        return t.pending;
    }
  }

  String _date(int? ts) {
    if (ts == null || ts == 0) return '-';
    return DateTime.fromMillisecondsSinceEpoch(ts).toLocal().toString();
  }
}
