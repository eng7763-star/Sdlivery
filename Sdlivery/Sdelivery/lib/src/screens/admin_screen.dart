import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../i18n/app_strings.dart';
import '../services/firebase_service.dart';
import '../models.dart';

class AdminScreen extends ConsumerWidget {
  static const route = '/admin';
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = S.of(context);
    final session = ref.watch(sessionProvider)!;
    final svc = ref.watch(firebaseServiceProvider);
    final isAr = t.isAr;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: StreamBuilder<Map<String, TripStatus>>(
        stream: svc.watchClassStatuses(session.schoolId, session.classId),
        builder: (context, snap) {
          final map = snap.data ?? {};
          final entries = map.entries.toList()
            ..sort((a, b) => (b.value.updatedAt).compareTo(a.value.updatedAt));

          return Scaffold(
            appBar: AppBar(title: Text(t.adminPanel)),
            body: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final e = entries[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(e.key),
                    subtitle: Text('${t.status}: ${_label(t, e.value.status)}\n${t.updatedAt}: ${_date(e.value.updatedAt)}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          );
        },
      ),
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
