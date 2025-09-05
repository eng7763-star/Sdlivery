import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../i18n/app_strings.dart';
import '../providers.dart';
import 'driver_screen.dart';
import 'student_screen.dart';
import 'admin_screen.dart';

class DashboardScreen extends ConsumerWidget {
  static const route = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = S.of(context);
    final session = ref.watch(sessionProvider);
    final isAr = t.isAr;

    Widget body;
    if (session?.role == 'driver') {
      body = const DriverScreen();
    } else if (session?.role == 'student') {
      body = const StudentScreen();
    } else {
      body = const AdminScreen();
    }

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(t.dashboard)),
        body: body,
      ),
    );
  }
}
