/// ملف الثوابت والموارد الثابتة للتطبيق
/// يحتوي على جميع المسارات والثوابت المستخدمة في التطبيق

class AppConstants {
  // App Info
  static const String appName = 'Study Organizer';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'منصة متكاملة لتنظيم الدراسة وإدارة المهام';

  // Asset Paths
  static const String assetsPath = 'assets';
  static const String iconsPath = '$assetsPath/icons';
  static const String imagesPath = '$assetsPath/images';
  static const String animationsPath = '$assetsPath/animations';
  static const String fontsPath = '$assetsPath/fonts';

  // Icons
  static const String appLogo = '$iconsPath/app_logo.svg';
  static const String homeIcon = '$iconsPath/home_icon.svg';
  static const String subjectsIcon = '$iconsPath/subjects_icon.svg';
  static const String tasksIcon = '$iconsPath/tasks_icon.svg';
  static const String filesIcon = '$iconsPath/files_icon.svg';
  static const String statsIcon = '$iconsPath/stats_icon.svg';
  static const String settingsIcon = '$iconsPath/settings_icon.svg';
  static const String supportIcon = '$iconsPath/support_icon.svg';
  static const String adminIcon = '$iconsPath/admin_icon.svg';

  // Image Paths
  static const String backgroundsPath = '$imagesPath/backgrounds';
  static const String illustrationsPath = '$imagesPath/illustrations';
  static const String placeholdersPath = '$imagesPath/placeholders';

  // Background Images
  static const String loginBg = '$backgroundsPath/login_bg.png';
  static const String homeBg = '$backgroundsPath/home_bg.png';
  static const String dashboardBg = '$backgroundsPath/dashboard_bg.png';

  // Illustration Images
  static const String emptyState = '$illustrationsPath/empty_state.png';
  static const String errorState = '$illustrationsPath/error_state.png';
  static const String loadingState = '$illustrationsPath/loading_state.png';

  // Placeholder Images
  static const String userAvatar = '$placeholdersPath/user_avatar.png';
  static const String subjectCover = '$placeholdersPath/subject_cover.png';

  // Animations
  static const String loadingAnimation = '$animationsPath/loading.json';
  static const String successAnimation = '$animationsPath/success.json';
  static const String errorAnimation = '$animationsPath/error.json';
  static const String emptyStateAnimation = '$animationsPath/empty_state.json';

  // Font Families
  static const String fontPoppins = 'Poppins';
  static const String fontRoboto = 'Roboto';
  static const String fontCairo = 'Cairo';

  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String subjectsEndpoint = '/subjects';
  static const String tasksEndpoint = '/tasks';
  static const String filesEndpoint = '/files';
  static const String statsEndpoint = '/stats';

  // Firebase
  static const String firebaseProjectId = 'study-organizer-project';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';

  // Stripe
  static const String stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Pagination
  static const int pageSize = 20;
  static const int initialPage = 1;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Error Messages
  static const String errorNetworkConnection = 'خطأ في الاتصال بالإنترنت';
  static const String errorServerError = 'حدث خطأ في الخادم';
  static const String errorUnauthorized = 'غير مصرح بالوصول';
  static const String errorNotFound = 'لم يتم العثور على البيانات';
  static const String errorInvalidInput = 'بيانات غير صحيحة';
  static const String errorUnknown = 'حدث خطأ غير معروف';

  // Success Messages
  static const String successLogin = 'تم تسجيل الدخول بنجاح';
  static const String successLogout = 'تم تسجيل الخروج بنجاح';
  static const String successRegistration = 'تم التسجيل بنجاح';
  static const String successSave = 'تم الحفظ بنجاح';
  static const String successDelete = 'تم الحذف بنجاح';
  static const String successUpdate = 'تم التحديث بنجاح';

  // Dialog Messages
  static const String confirmDelete = 'هل أنت متأكد من الحذف؟';
  static const String confirmLogout = 'هل تريد تسجيل الخروج؟';

  // Empty States
  static const String noSubjects = 'لا توجد مواد';
  static const String noTasks = 'لا توجد مهام';
  static const String noFiles = 'لا توجد ملفات';
  static const String noNotes = 'لا توجد ملاحظات';

  // Regex Patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern = r'^[0-9]{10,15}$';
  static const String urlPattern =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';
}

/// ثوابت الألوان
class AppColorConstants {
  // Primary Colors
  static const int primaryColor = 0xFF6366F1; // Indigo
  static const int primaryDark = 0xFF4F46E5;
  static const int primaryLight = 0xFF818CF8;

  // Secondary Colors
  static const int secondaryColor = 0xFF8B5CF6; // Purple
  static const int secondaryDark = 0xFF7C3AED;
  static const int secondaryLight = 0xFFA78BFA;

  // Accent Colors
  static const int accentColor = 0xFF06B6D4; // Cyan
  static const int accentDark = 0xFF0891B2;
  static const int accentLight = 0xFF22D3EE;

  // Neutral Colors
  static const int white = 0xFFFFFFFF;
  static const int black = 0xFF000000;
  static const int gray50 = 0xFFF9FAFB;
  static const int gray100 = 0xFFF3F4F6;
  static const int gray200 = 0xFFE5E7EB;
  static const int gray300 = 0xFFD1D5DB;
  static const int gray400 = 0xFF9CA3AF;
  static const int gray500 = 0xFF6B7280;
  static const int gray600 = 0xFF4B5563;
  static const int gray700 = 0xFF374151;
  static const int gray800 = 0xFF1F2937;
  static const int gray900 = 0xFF111827;

  // Status Colors
  static const int successColor = 0xFF10B981;
  static const int warningColor = 0xFFF59E0B;
  static const int errorColor = 0xFFEF4444;
  static const int infoColor = 0xFF3B82F6;

  // Semantic Colors
  static const int lavender = 0xFFE9D5FF;
  static const int blueGray = 0xFF64748B;
}

/// ثوابت الأحجام والمسافات
class AppDimensionConstants {
  // Padding & Margin
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircle = 50.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  // Font Sizes
  static const double fontSmall = 12.0;
  static const double fontMedium = 14.0;
  static const double fontLarge = 16.0;
  static const double fontXLarge = 18.0;
  static const double fontXXLarge = 20.0;
  static const double fontTitle = 24.0;
  static const double fontHeading = 28.0;
  static const double fontDisplay = 32.0;

  // Button Sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightLarge = 56.0;

  // Card Elevation
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
}

/// ثوابت الوقت والمدة
class AppDurationConstants {
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationLong = Duration(milliseconds: 500);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration dialogDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  static const Duration throttleDelay = Duration(milliseconds: 1000);
}

/// ثوابت الحدود والقيود
class AppLimitConstants {
  static const int maxFileSize = 100 * 1024 * 1024; // 100 MB
  static const int maxImageSize = 10 * 1024 * 1024; // 10 MB
  static const int maxVideoSize = 500 * 1024 * 1024; // 500 MB
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxCommentLength = 1000;
  static const int maxRetries = 3;
}
