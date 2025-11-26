# دليل حل المشاكل الشامل - Study Organizer

**الهدف**: توثيق جميع الأخطاء الشائعة والنادرة وحلولها  
**آخر تحديث**: [التاريخ الحالي]  
**الإصدار**: 1.0.0

---

## 📋 فهرس الأخطاء

### الأخطاء الشائعة (Common Errors)
1. Flutter SDK not found
2. Gradle build failed
3. Compilation failed
4. Java not found
5. Android SDK not found
6. Permission denied
7. Out of memory
8. Dependency conflicts

### الأخطاء النادرة (Rare Errors)
1. NDK version mismatch
2. Kotlin version conflict
3. AndroidX incompatibility
4. Firebase initialization error
5. Hive box not found
6. ProGuard obfuscation error
7. Multidex error
8. Manifest merge conflict

---

## 🔴 الأخطاء الشائعة وحلولها

### 1. Flutter SDK not found

#### الأعراض
```
Error: Flutter SDK not found. Define location with flutter.sdk in the local.properties file.
```

#### الأسباب
- Flutter SDK غير مثبت
- مسار Flutter SDK غير صحيح
- ملف `local.properties` مفقود

#### الحلول

**الحل 1: التحقق من تثبيت Flutter**
```bash
flutter --version
```

**الحل 2: تحديث local.properties**
```bash
# على Windows
flutter config --android-sdk "C:\Android\sdk"
flutter config --android-studio-dir "C:\Program Files\Android\Android Studio"

# على Mac/Linux
flutter config --android-sdk ~/Android/sdk
flutter config --android-studio-dir ~/Android/Studio
```

**الحل 3: إنشاء local.properties يدويًا**
```properties
# android/local.properties
flutter.sdk=/path/to/flutter
flutter.buildMode=release
flutter.versionName=1.0.0
flutter.versionCode=1
```

**الحل 4: إعادة تثبيت Flutter**
```bash
# حذف Flutter القديم
rm -rf ~/flutter

# تحميل Flutter جديد
git clone https://github.com/flutter/flutter.git -b stable ~/flutter

# إضافة Flutter إلى PATH
export PATH="$PATH:$HOME/flutter/bin"
```

---

### 2. Gradle build failed

#### الأعراض
```
FAILURE: Build failed with an exception.
* What went wrong:
Execution failed for task ':app:compileDebugKotlin'.
```

#### الأسباب
- مشاكل في الاعتماديات
- إصدار Gradle غير متوافق
- ذاكرة غير كافية

#### الحلول

**الحل 1: تنظيف البناء**
```bash
flutter clean
flutter pub get
flutter build apk --release
```

**الحل 2: زيادة ذاكرة JVM**
```properties
# android/gradle.properties
org.gradle.jvmargs=-Xmx2048M
```

**الحل 3: تحديث Gradle**
```gradle
# android/build.gradle
classpath 'com.android.tools.build:gradle:7.4.0'
```

**الحل 4: حذف مجلد .gradle**
```bash
rm -rf ~/.gradle
flutter clean
flutter pub get
```

**الحل 5: تحديث المكتبات**
```bash
flutter pub upgrade
flutter pub get
```

---

### 3. Compilation failed

#### الأعراض
```
Error: Compilation failed for task ':app:compileReleaseKotlin'.
```

#### الأسباب
- أخطاء في الكود
- عدم توافق المكتبات
- مشاكل في الاستيراد

#### الحلول

**الحل 1: فحص الأخطاء**
```bash
flutter analyze
```

**الحل 2: إصلاح الأخطاء تلقائياً**
```bash
dart fix --apply
```

**الحل 3: تنظيف والبناء من جديد**
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter build apk --release
```

**الحل 4: فحص استيرادات الملفات**
```bash
# تأكد من أن جميع الملفات المستوردة موجودة
grep -r "import" lib/ | grep -v "package:"
```

---

### 4. Java not found

#### الأعراض
```
Error: JAVA_HOME is not set and no 'java' command could be found in your PATH.
```

#### الأسباب
- Java غير مثبت
- JAVA_HOME غير معرّف
- Java ليس في PATH

#### الحلول

**الحل 1: التحقق من تثبيت Java**
```bash
java -version
javac -version
```

**الحل 2: تثبيت Java**
```bash
# على Ubuntu/Debian
sudo apt-get install openjdk-11-jdk

# على macOS
brew install openjdk@11

# على Windows
# حمّل من https://www.oracle.com/java/technologies/downloads/
```

**الحل 3: تعيين JAVA_HOME**
```bash
# على Linux/Mac
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# على Windows
setx JAVA_HOME "C:\Program Files\Java\jdk-11"
```

**الحل 4: التحقق من JAVA_HOME**
```bash
echo $JAVA_HOME
java -version
```

---

### 5. Android SDK not found

#### الأعراض
```
Error: Android SDK not found.
```

#### الأسباب
- Android SDK غير مثبت
- مسار SDK غير صحيح
- SDK tools مفقودة

#### الحلول

**الحل 1: التحقق من تثبيت Android SDK**
```bash
flutter doctor -v
```

**الحل 2: تثبيت Android SDK**
```bash
# على macOS
brew install android-sdk

# على Linux
# حمّل من https://developer.android.com/studio

# على Windows
# استخدم Android Studio
```

**الحل 3: تعيين ANDROID_SDK_ROOT**
```bash
# على Linux/Mac
export ANDROID_SDK_ROOT=~/Android/sdk
export PATH=$ANDROID_SDK_ROOT/tools:$PATH

# على Windows
setx ANDROID_SDK_ROOT "C:\Android\sdk"
```

**الحل 4: تثبيت SDK components**
```bash
sdkmanager "platforms;android-34"
sdkmanager "build-tools;34.0.0"
sdkmanager "platform-tools"
```

---

### 6. Permission denied

#### الأعراض
```
Error: Permission denied: ./gradlew
```

#### الأسباب
- ملف gradlew بدون صلاحيات تنفيذ
- مشاكل في الأذونات

#### الحلول

**الحل 1: إضافة صلاحيات التنفيذ**
```bash
chmod +x android/gradlew
chmod +x android/gradlew.bat
```

**الحل 2: التحقق من الأذونات**
```bash
ls -la android/gradlew
```

**الحل 3: إعادة تعيين الأذونات**
```bash
chmod 755 android/gradlew
chmod 755 android/gradlew.bat
```

---

### 7. Out of memory

#### الأعراض
```
Error: java.lang.OutOfMemoryError: Java heap space
```

#### الأسباب
- ذاكرة JVM غير كافية
- مشاكل في الذاكرة

#### الحلول

**الحل 1: زيادة ذاكرة JVM**
```properties
# android/gradle.properties
org.gradle.jvmargs=-Xmx4096M
```

**الحل 2: تقليل حجم البناء**
```bash
flutter build apk --release --split-per-abi
```

**الحل 3: إغلاق البرامج الأخرى**
```bash
# أغلق المحررات والبرامج الثقيلة
# وحرر ذاكرة النظام
```

**الحل 4: استخدام Gradle daemon**
```properties
# android/gradle.properties
org.gradle.daemon=true
org.gradle.parallel=true
```

---

### 8. Dependency conflicts

#### الأعراض
```
Error: Conflict in dependency versions
```

#### الأسباب
- تضارب في إصدارات المكتبات
- عدم توافق المكتبات

#### الحلول

**الحل 1: فحص الاعتماديات**
```bash
flutter pub outdated
flutter pub deps
```

**الحل 2: حل التضارب**
```bash
flutter pub upgrade
flutter pub get
```

**الحل 3: تحديد إصدارات محددة**
```yaml
# pubspec.yaml
dependencies:
  package_name: ^1.0.0  # استخدم ^ للتوافق
```

**الحل 4: استخدام dependency_overrides**
```yaml
# pubspec.yaml
dependency_overrides:
  package_name: ^1.0.0
```

---

## 🟠 الأخطاء النادرة وحلولها

### 1. NDK version mismatch

#### الأعراض
```
Error: NDK version mismatch
```

#### الحلول

**الحل 1: تحديث NDK**
```properties
# android/gradle.properties
android.ndkVersion=25.2.9519653
```

**الحل 2: تثبيت NDK الصحيح**
```bash
sdkmanager "ndk;25.2.9519653"
```

---

### 2. Kotlin version conflict

#### الأعراض
```
Error: Kotlin version conflict
```

#### الحلول

**الحل 1: تحديث Kotlin**
```gradle
# android/build.gradle
ext.kotlin_version = '1.8.10'
```

**الحل 2: تحديث Gradle**
```gradle
classpath 'com.android.tools.build:gradle:7.4.0'
```

---

### 3. AndroidX incompatibility

#### الأعراض
```
Error: AndroidX incompatibility
```

#### الحلول

**الحل 1: تفعيل AndroidX**
```properties
# android/gradle.properties
android.useAndroidX=true
android.enableJetifier=true
```

**الحل 2: تحديث المكتبات**
```bash
flutter pub upgrade
```

---

### 4. Firebase initialization error

#### الأعراض
```
Error: Firebase initialization failed
```

#### الحلول

**الحل 1: التحقق من google-services.json**
```bash
# تأكد من وجود الملف
ls -la android/app/google-services.json
```

**الحل 2: إضافة Firebase**
```gradle
# android/build.gradle
classpath 'com.google.gms:google-services:4.3.15'

# android/app/build.gradle
apply plugin: 'com.google.gms.google-services'
```

---

### 5. Hive box not found

#### الأعراض
```
Error: Hive box not found
```

#### الحلول

**الحل 1: تهيئة Hive**
```dart
await Hive.initFlutter();
await Hive.openBox('boxName');
```

**الحل 2: حذف بيانات Hive**
```bash
# على المحاكي
adb shell rm -rf /data/data/com.study_organizer.study_organizer/
```

---

### 6. ProGuard obfuscation error

#### الأعراض
```
Error: ProGuard obfuscation failed
```

#### الحلول

**الحل 1: تحديث ProGuard rules**
```pro
# android/app/proguard-rules.pro
-keep class com.study_organizer.** { *; }
-keep class com.google.firebase.** { *; }
```

**الحل 2: تعطيل ProGuard**
```gradle
# android/app/build.gradle
release {
    minifyEnabled false
}
```

---

### 7. Multidex error

#### الأعراض
```
Error: Method count exceeds 65536
```

#### الحلول

**الحل 1: تفعيل MultiDex**
```gradle
# android/app/build.gradle
defaultConfig {
    multiDexEnabled true
}
```

**الحل 2: إضافة MultiDex**
```gradle
dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

---

### 8. Manifest merge conflict

#### الأعراض
```
Error: Manifest merge failed
```

#### الحلول

**الحل 1: فحص AndroidManifest.xml**
```bash
# تأكد من عدم تكرار الأذونات
grep -n "uses-permission" android/app/src/main/AndroidManifest.xml
```

**الحل 2: إصلاح التضارب**
```xml
<!-- احذف الأذونات المكررة -->
<!-- تأكد من عدم وجود أنشطة مكررة -->
```

---

## 🟢 نصائح الوقاية

### 1. الحفاظ على التوافق

```bash
# تحقق بانتظام من التوافق
flutter doctor
flutter analyze
flutter pub outdated
```

### 2. استخدام إصدارات مستقرة

```yaml
# pubspec.yaml
dependencies:
  package: ^1.0.0  # استخدم ^ للتوافق
```

### 3. الاختبار المنتظم

```bash
# اختبر على أجهزة مختلفة
flutter test
flutter drive
```

### 4. النسخ الاحتياطية

```bash
# احفظ نسخة من pubspec.lock
git add pubspec.lock
git commit -m "Update dependencies"
```

---

## 📊 جدول الحلول السريعة

| الخطأ | الأمر السريع | الحل البديل |
|------|----------|----------|
| Flutter SDK | `flutter config --android-sdk` | إعادة تثبيت |
| Gradle failed | `flutter clean && flutter pub get` | حذف .gradle |
| Compilation | `flutter analyze` | `dart fix --apply` |
| Java not found | `export JAVA_HOME=...` | تثبيت Java |
| Android SDK | `flutter doctor -v` | تثبيت SDK |
| Permission | `chmod +x android/gradlew` | إعادة تعيين |
| Out of memory | `org.gradle.jvmargs=-Xmx4096M` | تقليل البناء |
| Dependencies | `flutter pub upgrade` | `pub outdated` |

---

## 🔧 أدوات التشخيص

### 1. Flutter Doctor

```bash
flutter doctor -v
```

**يوضح**:
- حالة Flutter
- حالة Android Studio
- حالة Xcode
- الأجهزة المتصلة

### 2. Flutter Analyze

```bash
flutter analyze
```

**يوضح**:
- أخطاء الكود
- التحذيرات
- مشاكل الأسلوب

### 3. Pub Outdated

```bash
flutter pub outdated
```

**يوضح**:
- المكتبات القديمة
- الإصدارات الجديدة
- التوافق

### 4. Gradle Debug

```bash
./gradlew build --debug
```

**يوضح**:
- تفاصيل البناء
- الأخطاء المفصلة

---

## 📞 الدعم والمساعدة

### الموارد المفيدة

- [Flutter Documentation](https://flutter.dev/docs)
- [Android Developer Guide](https://developer.android.com/guide)
- [Gradle Documentation](https://gradle.org/guides)
- [Stack Overflow - Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Community](https://flutter.dev/community)

### الأوامر المفيدة

```bash
# عرض المساعدة
flutter build apk --help

# عرض معلومات مفصلة
flutter doctor -v

# فحص الأخطاء
flutter analyze

# تحديث المكتبات
flutter pub upgrade

# البحث عن الأجهزة
adb devices
```

---

## ✅ قائمة التحقق

قبل الإبلاغ عن خطأ:

- [ ] قرأت رسالة الخطأ بعناية
- [ ] جربت الحلول الأساسية
- [ ] قمت بـ `flutter clean`
- [ ] قمت بـ `flutter pub get`
- [ ] قمت بـ `flutter doctor`
- [ ] قمت بـ `flutter analyze`
- [ ] تحققت من الإنترنت
- [ ] أعدت تشغيل المحرر

---

## 🎯 الخلاصة

معظم الأخطاء يمكن حلها بـ:

1. **`flutter clean`** - تنظيف البناء
2. **`flutter pub get`** - الحصول على الاعتماديات
3. **`flutter analyze`** - فحص الأخطاء
4. **`flutter doctor`** - فحص النظام

إذا استمرت المشكلة، راجع الأقسام أعلاه للحصول على حلول مفصلة.

---

**آخر تحديث**: [التاريخ الحالي]  
**الإصدار**: 1.0.0  
**الحالة**: ✅ شامل
