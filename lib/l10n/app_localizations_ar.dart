// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get cart => 'السلة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get search => 'ابحث عن مشروبك المفضل...';

  @override
  String get addToCart => 'أضف للسلة';

  @override
  String get goToCart => 'اذهب للسلة';

  @override
  String get orderNow => 'اطلب الآن';

  @override
  String get checkout => 'إتمام الطلب';

  @override
  String get total => 'الإجمالي';

  @override
  String get subtotal => 'المجموع';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get orderNotes => 'ملاحظات الطلب';

  @override
  String get specialInstructions => 'أي طلبات خاصة؟ مثال: سكر أقل...';

  @override
  String get placeOrder => 'تأكيد الطلب';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get limitedOffer => 'عرض محدود';

  @override
  String get noProductsFound => 'لا توجد منتجات';

  @override
  String get filterByCategory => 'تصفية حسب القسم';

  @override
  String get applyFilter => 'تطبيق الفلتر';

  @override
  String get all => 'الكل';

  @override
  String get name => 'الاسم';

  @override
  String get enterName => 'أدخل اسمك';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get enterPhone => 'أدخل رقم هاتفك';

  @override
  String get address => 'عنوان التوصيل';

  @override
  String get enterAddress => 'أدخل عنوان التوصيل';

  @override
  String get minimum => 'صغير';

  @override
  String get medium => 'وسط';

  @override
  String get single => 'مفرد';

  @override
  String get doubleSize => 'مضاعف';

  @override
  String get size => 'الحجم';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get specialDeal => 'عرض خاص';

  @override
  String get rating => 'التقييم';

  @override
  String get reviews => 'تقييم';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get switchToArabic => 'عربي';

  @override
  String get switchToEnglish => 'English';

  @override
  String helloUser(String name) {
    return 'أهلاً، $name!';
  }

  @override
  String get continueWithGoogle => 'المتابعة بحساب Google';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get productNotFound => 'المنتج غير موجود';

  @override
  String get itemAdded => 'تمت إضافة المنتج للسلة';

  @override
  String get orderPlaced => 'تم تأكيد طلبك بنجاح!';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get invalidPhone => 'أدخل رقم هاتف صحيح';

  @override
  String minCharacters(int count) {
    return 'يجب إدخال $count أحرف على الأقل';
  }

  @override
  String get onboardingTitle => 'قهوة رائعة جداً، براعم التذوق لديك ستحبها.';

  @override
  String get onboardingSubtitle =>
      'أفضل الحبوب، أجود أنواع التحميص، النكهة القوية.';

  @override
  String get welcome => 'أهلاً،';

  @override
  String get user => 'المستخدم';

  @override
  String get signOutConfirmation => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'حسناً';

  @override
  String get orderItems => 'عناصر الطلب';
}
