# دليل GitHub Actions الشامل - Study Organizer

**الهدف**: توثيق شامل لـ GitHub Actions وكيفية بناء APK تلقائياً  
**آخر تحديث**: [التاريخ الحالي]  
**الإصدار**: 1.0.0

---

## 📋 فهرس المحتويات

1. مقدمة عن GitHub Actions
2. الـ Workflows المتاحة
3. كيفية الاستخدام
4. معالجة الأخطاء
5. نصائح وحيل

---

## 1️⃣ مقدمة عن GitHub Actions

### ما هو GitHub Actions؟

GitHub Actions هي منصة أتمتة CI/CD مدمجة في GitHub تسمح لك بـ:
- ✅ بناء التطبيق تلقائياً
- ✅ تشغيل الاختبارات
- ✅ تحليل الكود
- ✅ نشر الملفات
- ✅ إنشاء Releases

### المميزات

- ✅ **مجاني**: 2000 دقيقة شهرياً للـ Public Repositories
- ✅ **سهل**: لا يتطلب إعداد معقد
- ✅ **قوي**: يدعم جميع لغات البرمجة
- ✅ **موثوق**: يعمل على خوادم GitHub

---

## 2️⃣ الـ Workflows المتاحة

### Workflow 1: build-release-apk.yml

#### الغرض
بناء APK و App Bundle للإصدار النهائي

#### متى يتم التشغيل

```yaml
on:
  push:
    branches:
      - master
      - main
      - release/**
    tags:
      - 'v*'
  pull_request:
    branches:
      - master
      - main
  workflow_dispatch:
```

**التشغيل التلقائي**:
- ✅ عند الـ Push إلى `master` أو `main`
- ✅ عند الـ Push إلى فروع `release/**`
- ✅ عند إنشاء tag بصيغة `v*` (مثل `v1.0.0`)
- ✅ عند فتح Pull Request
- ✅ عند التشغيل اليدوي

#### الخطوات

```
1. Checkout code          → استرجاع الكود
2. Setup Java            → إعداد Java 11
3. Setup Flutter         → إعداد Flutter 3.13.0
4. Get dependencies      → الحصول على المكتبات
5. Analyze code          → تحليل الكود
6. Run tests             → تشغيل الاختبارات
7. Build APK (Debug)     → بناء APK Debug
8. Build APK (Release)   → بناء APK Release
9. Build App Bundle      → بناء App Bundle
10. Build APK (Split)    → بناء APKs منفصلة
11. Upload artifacts     → رفع الملفات
12. Create Release       → إنشاء Release
```

#### الملفات الناتجة

| الملف | الحجم | الاستخدام |
|------|-------|----------|
| `flutter-app.apk` | 40-60 MB | التثبيت المباشر |
| `flutter-app-arm64-v8a-release.apk` | 30-40 MB | أجهزة 64-bit |
| `flutter-app-armeabi-v7a-release.apk` | 25-35 MB | أجهزة 32-bit |
| `app-release.aab` | 30-50 MB | نشر على Play Store |

---

### Workflow 2: analyze-and-test.yml

#### الغرض
تحليل الكود وتشغيل الاختبارات

#### متى يتم التشغيل

```yaml
on:
  push:
    branches:
      - master
      - main
      - develop
  pull_request:
    branches:
      - master
      - main
      - develop
  workflow_dispatch:
```

#### الخطوات

```
Job 1: Analyze
  1. Checkout code
  2. Setup Flutter
  3. Get dependencies
  4. Run flutter analyze
  5. Check formatting
  6. Run linter

Job 2: Test
  1. Checkout code
  2. Setup Flutter
  3. Get dependencies
  4. Run tests with coverage
  5. Upload coverage

Job 3: Build Debug
  1. Checkout code
  2. Setup Java
  3. Setup Flutter
  4. Get dependencies
  5. Build Debug APK
  6. Upload Debug APK
```

---

## 3️⃣ كيفية الاستخدام

### الطريقة 1: بناء تلقائي عند الـ Push

```bash
# قم بإجراء تغييرات
git add .
git commit -m "Add new feature"

# ادفع إلى master
git push origin master

# سيتم بناء APK تلقائياً! ✅
```

**ماذا يحدث**:
1. GitHub Actions يكتشف الـ Push
2. يبدأ الـ Workflow
3. يبني APK
4. يرفع الملفات كـ Artifacts

### الطريقة 2: بناء عند إنشاء Release

```bash
# قم بإنشاء tag
git tag v1.0.0

# ادفع الـ tag
git push origin v1.0.0

# سيتم بناء APK وإنشاء Release! ✅
```

**ماذا يحدث**:
1. GitHub Actions يكتشف الـ tag
2. يبني APK و App Bundle
3. ينشئ Release على GitHub
4. يرفع الملفات إلى Release

### الطريقة 3: بناء يدوي

#### عبر GitHub Web Interface

```
1. اذهب إلى GitHub Repository
2. انقر على "Actions"
3. اختر الـ Workflow (مثل "Build Release APK")
4. انقر على "Run workflow"
5. اختر الفرع (master)
6. انقر على "Run workflow"
```

#### عبر GitHub CLI

```bash
# تثبيت GitHub CLI
brew install gh  # على macOS
# أو من https://cli.github.com

# تسجيل الدخول
gh auth login

# تشغيل الـ Workflow
gh workflow run build-release-apk.yml --ref master

# عرض حالة البناء
gh run list --repo Ksa518n/flutter-study-organizer
```

---

## 4️⃣ معالجة الأخطاء

### خطأ 1: "Flutter SDK not found"

**السبب**: GitHub Actions لم تجد Flutter

**الحل**: Workflow يعيّن Flutter تلقائياً (لا تقلق)

### خطأ 2: "Gradle build failed"

**السبب**: مشاكل في البناء

**الحل**:
1. تحقق من `pubspec.yaml`
2. تحقق من `android/build.gradle`
3. تحقق من الأخطاء في الكود

```bash
# اختبر محلياً
flutter clean
flutter pub get
flutter build apk --release
```

### خطأ 3: "Out of memory"

**السبب**: ذاكرة غير كافية

**الحل**: GitHub Actions توفر 7GB RAM (كافية)

إذا استمرت المشكلة:
```properties
# android/gradle.properties
org.gradle.jvmargs=-Xmx2048M
```

### خطأ 4: "Permission denied"

**السبب**: مشاكل في الأذونات

**الحل**: تأكد من:
```bash
chmod +x android/gradlew
chmod +x android/gradlew.bat
```

### خطأ 5: "Artifacts not found"

**السبب**: البناء فشل

**الحل**:
1. اعرض سجل البناء
2. ابحث عن الأخطاء
3. أصلح الأخطاء محلياً

---

## 5️⃣ مراقبة البناء

### عرض حالة البناء

#### عبر GitHub Web Interface

```
1. Repository → Actions
2. اختر الـ Workflow
3. اعرض آخر Run
4. اعرض التفاصيل
```

#### عبر GitHub CLI

```bash
# عرض جميع الـ Runs
gh run list --repo Ksa518n/flutter-study-organizer

# عرض تفاصيل Run معين
gh run view <run-id>

# عرض السجل
gh run view <run-id> --log
```

### تحميل الملفات

#### عبر GitHub Web Interface

```
1. Actions → آخر Run ناجح
2. انقر على "Artifacts"
3. حمّل الملفات
```

#### عبر GitHub CLI

```bash
# تحميل جميع الملفات
gh run download <run-id>

# تحميل ملف معين
gh run download <run-id> -n apk-artifacts
```

---

## 6️⃣ نصائح وحيل

### نصيحة 1: استخدم Tags للإصدارات

```bash
# إنشاء tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# دفع الـ tag
git push origin v1.0.0

# سيتم إنشاء Release تلقائياً
```

### نصيحة 2: استخدم Semantic Versioning

```
v1.0.0  → Major.Minor.Patch
v1.0.0-beta.1  → مع Pre-release
v1.0.0+build.1  → مع Build metadata
```

### نصيحة 3: راقب الـ Actions

```bash
# عرض الـ Workflows
gh workflow list --repo Ksa518n/flutter-study-organizer

# تفعيل/تعطيل Workflow
gh workflow enable build-release-apk.yml
gh workflow disable build-release-apk.yml
```

### نصيحة 4: استخدم Status Badge

أضف إلى `README.md`:

```markdown
[![Build Release APK](https://github.com/Ksa518n/flutter-study-organizer/actions/workflows/build-release-apk.yml/badge.svg)](https://github.com/Ksa518n/flutter-study-organizer/actions)
```

### نصيحة 5: احفظ الملفات

```bash
# تحميل جميع الـ Artifacts
for run in $(gh run list --repo Ksa518n/flutter-study-organizer --json databaseId -q '.[].databaseId'); do
  gh run download $run --repo Ksa518n/flutter-study-organizer
done
```

---

## 7️⃣ الملفات الناتجة

### بعد بناء ناجح

```
build/app/outputs/
├── flutter-app.apk                          # APK الرئيسي
├── flutter-app-arm64-v8a-release.apk       # 64-bit
├── flutter-app-armeabi-v7a-release.apk     # 32-bit
├── flutter-app-x86-release.apk              # x86
├── flutter-app-x86_64-release.apk           # x86_64
└── bundle/release/
    └── app-release.aab                      # App Bundle
```

### أحجام الملفات

| الملف | الحجم |
|------|-------|
| flutter-app.apk | 40-60 MB |
| arm64-v8a | 30-40 MB |
| armeabi-v7a | 25-35 MB |
| app-release.aab | 30-50 MB |

---

## 8️⃣ الأوامر المفيدة

### GitHub CLI

```bash
# عرض الـ Workflows
gh workflow list

# تشغيل Workflow
gh workflow run build-release-apk.yml

# عرض الـ Runs
gh run list

# عرض تفاصيل Run
gh run view <run-id>

# تحميل Artifacts
gh run download <run-id>

# عرض السجل
gh run view <run-id> --log
```

### Git

```bash
# إنشاء tag
git tag v1.0.0

# دفع الـ tag
git push origin v1.0.0

# عرض الـ tags
git tag -l

# حذف tag
git tag -d v1.0.0
git push origin --delete v1.0.0
```

---

## 9️⃣ قائمة التحقق

قبل الـ Push:

- [ ] قمت بـ `flutter analyze`
- [ ] قمت بـ `flutter test`
- [ ] قمت بـ `flutter build apk --release` محلياً
- [ ] لا توجد أخطاء في الكود
- [ ] `pubspec.yaml` محدّث
- [ ] `android/` كامل
- [ ] الإصدار محدّث

قبل إنشاء Release:

- [ ] الكود مختبر بالكامل
- [ ] الإصدار محدّث في `pubspec.yaml`
- [ ] Tag بصيغة صحيحة (`v1.0.0`)
- [ ] Release notes مكتوبة

---

## 🔟 الخلاصة

### الفوائد

✅ **أتمتة كاملة** - بناء تلقائي  
✅ **توفير الوقت** - لا حاجة لبناء يدوي  
✅ **موثوقية** - نفس البيئة دائماً  
✅ **تتبع** - سجل كامل للبناءات  
✅ **توزيع** - تحميل سهل للملفات  

### الخطوات السريعة

```bash
# 1. قم بإجراء تغييرات
git add .
git commit -m "Add feature"

# 2. ادفع إلى master
git push origin master

# 3. انتظر البناء (2-5 دقائق)

# 4. حمّل الملفات من GitHub Actions
```

### الموارد

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter GitHub Actions](https://github.com/subosito/flutter-action)
- [Upload Artifact Action](https://github.com/actions/upload-artifact)

---

**آخر تحديث**: [التاريخ الحالي]  
**الإصدار**: 1.0.0  
**الحالة**: ✅ جاهز للاستخدام
