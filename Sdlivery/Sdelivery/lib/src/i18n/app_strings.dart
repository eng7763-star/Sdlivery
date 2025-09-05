import 'package:flutter/widgets.dart';

class S {
  final Locale locale;
  S(this.locale);

  static S of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return S(locale);
  }

  bool get isAr => locale.languageCode == 'ar';

  String get appName => 'Sdelivery';

  String get roleDriver => isAr ? 'سائق/ولي أمر' : 'Driver/Guardian';
  String get roleStudent => isAr ? 'طالب' : 'Student';
  String get roleAdmin => isAr ? 'إدارة' : 'Admin';

  String get loginTitle => isAr ? 'تسجيل الدخول' : 'Login';
  String get name => isAr ? 'الاسم' : 'Name';
  String get school => isAr ? 'المدرسة' : 'School';
  String get className => isAr ? 'الفصل' : 'Class';
  String get student => isAr ? 'الطالب' : 'Student';
  String get continueLbl => isAr ? 'متابعة' : 'Continue';

  String get dashboard => isAr ? 'الرئيسية' : 'Dashboard';
  String get driverPanel => isAr ? 'واجهة السائق' : 'Driver Panel';
  String get studentPanel => isAr ? 'واجهة الطالب' : 'Student Panel';
  String get adminPanel => isAr ? 'لوحة الإدارة' : 'Admin Panel';

  String get arrived => isAr ? 'وصلت' : 'Arrived';
  String get late => isAr ? 'متأخر' : 'Late';
  String get home => isAr ? 'وصلت البيت' : 'Home';
  String get pending => isAr ? 'بانتظار' : 'Pending';
  String get registerStudent => isAr ? 'تسجيل طالب' : 'Register Student';
  String get linkDriver => isAr ? 'ربط بالسائق' : 'Link to Driver';
  String get addSchoolClass => isAr ? 'إضافة مدرسة/فصل' : 'Add School/Class';
  String get save => isAr ? 'حفظ' : 'Save';
  String get status => isAr ? 'الحالة' : 'Status';
  String get updatedAt => isAr ? 'آخر تحديث' : 'Updated At';
}
