# دليل بناء APK - Study Organizer

هذا الدليل يشرح كيفية بناء ملف APK للتطبيق على جهازك المحلي.

## المتطلبات

قبل البدء، تأكد من:
1. تثبيت Flutter SDK
2. تثبيت Android SDK
3. تثبيت Java Development Kit (JDK 11+)
4. تثبيت Git

## الخطوات

### 1. استنساخ المشروع

```bash
git clone https://github.com/Ksa518n/flutter-study-organizer.git
cd flutter-study-organizer
```

### 2. تثبيت الاعتماديات

```bash
flutter pub get
```

### 3. بناء APK (Debug)

```bash
flutter build apk --debug
```

سيتم حفظ الملف في:
```
build/app/outputs/flutter-apk/app-debug.apk
```

### 4. بناء APK (Release)

```bash
flutter build apk --release
```

سيتم حفظ الملف في:
```
build/app/outputs/flutter-apk/app-release.apk
```

### 5. بناء APK مع تقسيم حسب ABI

لتقليل حجم الملف:

```bash
flutter build apk --release --split-per-abi
```

سيتم إنشاء ملفات منفصلة لكل معمارية:
- `app-armeabi-v7a-release.apk` (للأجهزة القديمة)
- `app-arm64-v8a-release.apk` (للأجهزة الحديثة)
- `app-x86_64-release.apk` (لمحاكيات x86)

### 6. بناء App Bundle (لـ Google Play)

```bash
flutter build appbundle --release
```

سيتم حفظ الملف في:
```
build/app/outputs/bundle/release/app-release.aab
```

## التثبيت على جهاز

### تثبيت APK على جهاز متصل

```bash
# تثبيت APK Debug
flutter install

# أو تثبيت APK محدد يدويًا
adb install build/app/outputs/flutter-apk/app-release.apk
```

### التحقق من الأجهزة المتصلة

```bash
flutter devices
```

## استكشاف الأخطاء

### مسح ذاكرة التخزين المؤقتة

إذا واجهت مشاكل في البناء:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

### عرض تفاصيل البناء

```bash
flutter build apk --release -v
```

### التحقق من حجم APK

```bash
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

## نصائح للتحسين

### تقليل حجم APK

1. **استخدام Split APKs**:
```bash
flutter build apk --release --split-per-abi
```

2. **تفعيل Shrinking**:
تأكد من تفعيل ProGuard/R8 في `android/app/build.gradle`

3. **استخدام App Bundle**:
```bash
flutter build appbundle --release
```

### تحسين الأداء

1. **Release Mode**:
استخدم دائماً `--release` للإصدارات النهائية

2. **Profiling**:
```bash
flutter build apk --release --profile
```

## نشر على Google Play

### المتطلبات

1. حساب Google Play Developer
2. ملف App Bundle (`app-release.aab`)
3. شهادة التوقيع

### الخطوات

1. اذهب إلى [Google Play Console](https://play.google.com/console)
2. أنشئ تطبيق جديد
3. أكمل معلومات التطبيق
4. رفع App Bundle
5. أكمل عملية الإرسال

## توقيع APK

### إنشاء مفتاح التوقيع

```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

### توقيع APK يدويًا

```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore ~/key.jks \
  build/app/outputs/flutter-apk/app-release-unsigned.apk key
```

## المراجع

- [Flutter Build Documentation](https://flutter.dev/docs/deployment/android)
- [Google Play Console](https://play.google.com/console)
- [Android Developer Guide](https://developer.android.com/guide)

## الدعم

إذا واجهت مشاكل:
1. تحقق من [Flutter Issues](https://github.com/flutter/flutter/issues)
2. اقرأ [Flutter FAQ](https://flutter.dev/docs/resources/faq)
3. افتح Issue في المشروع

---

آخر تحديث: [التاريخ الحالي]
