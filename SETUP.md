# دليل إعداد وتشغيل Study Organizer

## المتطلبات الأساسية

### 1. تثبيت Flutter

#### على Windows
1. قم بتحميل Flutter SDK من [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. استخرج الملف إلى مجلد (مثل `C:\flutter`)
3. أضف مسار Flutter إلى متغيرات البيئة (PATH)
4. افتح Command Prompt وتحقق من التثبيت:
```bash
flutter --version
```

#### على macOS
```bash
# باستخدام Homebrew
brew install flutter

# أو تحميل يدوي من flutter.dev
```

#### على Linux
```bash
# تحميل Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable

# إضافة Flutter إلى PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. تثبيت Android Studio (لتطوير Android)

1. قم بتحميل Android Studio من [developer.android.com](https://developer.android.com/studio)
2. ثبت Android SDK و Android Emulator
3. قم بتشغيل الأوامر التالية:
```bash
flutter doctor --android-licenses
# اقبل جميع الرخص بكتابة 'y'
```

### 3. تثبيت Xcode (لتطوير iOS على macOS)

```bash
xcode-select --install
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## خطوات الإعداد

### 1. استنساخ المشروع
```bash
git clone <repository-url>
cd flutter_study_organizer
```

### 2. التحقق من البيئة
```bash
flutter doctor
```

يجب أن تظهر رسالة تشير إلى أن جميع الأدوات مثبتة بشكل صحيح.

### 3. تثبيت الاعتماديات
```bash
flutter pub get
```

### 4. توليد الملفات المطلوبة
```bash
flutter pub run build_runner build
```

## التشغيل

### تشغيل على محاكي Android
```bash
# تشغيل المحاكي أولاً
flutter emulators --launch <emulator-name>

# ثم تشغيل التطبيق
flutter run
```

### تشغيل على جهاز Android حقيقي
```bash
# تفعيل وضع المطور على الجهاز
# ثم توصيل الجهاز عبر USB

flutter devices  # للتحقق من الأجهزة المتصلة
flutter run
```

### تشغيل على محاكي iOS
```bash
# على macOS فقط
flutter run
```

### تشغيل على جهاز iOS حقيقي
```bash
# يتطلب حساب Apple Developer
flutter run -d <device-id>
```

## التطوير

### بنية المشروع
```
lib/
├── main.dart              # نقطة الدخول
├── config/               # الإعدادات
├── models/              # نماذج البيانات
├── providers/           # إدارة الحالة
├── screens/             # الشاشات
└── widgets/             # المكونات المشتركة
```

### إضافة مكتبة جديدة
```bash
flutter pub add package_name
```

### تحديث المكتبات
```bash
flutter pub upgrade
```

## البناء للإصدار

### بناء APK
```bash
flutter build apk --release
# سيتم حفظ الملف في: build/app/outputs/flutter-apk/app-release.apk
```

### بناء App Bundle
```bash
flutter build appbundle --release
# سيتم حفظ الملف في: build/app/outputs/bundle/release/app-release.aab
```

### بناء iOS
```bash
flutter build ios --release
# سيتم حفظ الملف في: build/ios/iphoneos/Runner.app
```

## الاختبار

### تشغيل الاختبارات
```bash
flutter test
```

### اختبار محدد
```bash
flutter test test/widget_test.dart
```

## استكشاف الأخطاء

### مسح ذاكرة التخزين المؤقتة
```bash
flutter clean
flutter pub get
```

### إعادة بناء الملفات المولدة
```bash
flutter pub run build_runner clean
flutter pub run build_runner build
```

### تفعيل وضع Verbose للتصحيح
```bash
flutter run -v
```

## إعدادات إضافية

### Firebase (اختياري)
1. أنشئ مشروع على [Firebase Console](https://console.firebase.google.com)
2. أضف تطبيق Flutter
3. حمل ملفات الإعدادات:
   - `google-services.json` للـ Android
   - `GoogleService-Info.plist` للـ iOS
4. ضع الملفات في المسارات الصحيحة

### Google Sign-In
1. فعّل Google Sign-In في Firebase
2. أضف بيانات الاعتماد في الإعدادات

### Stripe (للدفع)
1. أنشئ حساب Stripe
2. أضف مفتاح Stripe في الإعدادات

## المزيد من المعلومات

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase for Flutter](https://firebase.flutter.dev/)

## الدعم

إذا واجهت مشاكل:
1. تحقق من أن جميع المتطلبات مثبتة بشكل صحيح
2. جرب `flutter clean` و `flutter pub get`
3. افتح Issue في المشروع
4. تواصل مع فريق الدعم
