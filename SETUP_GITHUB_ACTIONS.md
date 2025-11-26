# دليل إعداد GitHub Actions يدويًا

بسبب قيود الأذونات، يجب إنشاء ملفات GitHub Actions يدويًا عبر GitHub Web Interface.

---

## 📋 الخطوات

### 1. إنشاء مجلد .github/workflows

#### عبر GitHub Web Interface

```
1. اذهب إلى Repository
2. انقر على "Add file" → "Create new file"
3. أدخل المسار: .github/workflows/build-release-apk.yml
4. انسخ المحتوى من الأسفل
5. انقر على "Commit changes"
```

#### أو عبر GitHub CLI

```bash
gh repo edit --enable-workflows
```

---

## 2️⃣ ملف Workflow 1: build-release-apk.yml

انسخ هذا المحتوى إلى `.github/workflows/build-release-apk.yml`:

```yaml
name: Build Release APK

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

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '11'
          cache: gradle
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          cache: true
          cache-key: flutter-${{ hashFiles('**/pubspec.lock') }}
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Analyze code
        run: flutter analyze
        continue-on-error: true
      
      - name: Run tests
        run: flutter test
        continue-on-error: true
      
      - name: Build APK (Debug)
        run: flutter build apk --debug
        continue-on-error: true
      
      - name: Build APK (Release)
        run: flutter build apk --release
      
      - name: Build App Bundle
        run: flutter build appbundle --release
        continue-on-error: true
      
      - name: Build APK (Split per ABI)
        run: flutter build apk --split-per-abi --release
        continue-on-error: true
      
      - name: Upload APK artifacts
        uses: actions/upload-artifact@v3
        with:
          name: apk-artifacts
          path: |
            build/app/outputs/flutter-app.apk
            build/app/outputs/flutter-app-*-release.apk
          retention-days: 30
      
      - name: Upload App Bundle
        uses: actions/upload-artifact@v3
        with:
          name: app-bundle
          path: build/app/outputs/bundle/release/app-release.aab
          retention-days: 30
        continue-on-error: true
      
      - name: Get APK size
        run: |
          echo "=== APK Sizes ===" >> $GITHUB_STEP_SUMMARY
          ls -lh build/app/outputs/*.apk >> $GITHUB_STEP_SUMMARY || true
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "=== App Bundle Size ===" >> $GITHUB_STEP_SUMMARY
          ls -lh build/app/outputs/bundle/release/*.aab >> $GITHUB_STEP_SUMMARY || true
      
      - name: Create Release
        if: startsWith(github.ref, 'refs/tags/v')
        uses: softprops/action-gh-release@v1
        with:
          files: |
            build/app/outputs/flutter-app.apk
            build/app/outputs/flutter-app-*-release.apk
            build/app/outputs/bundle/release/app-release.aab
          draft: false
          prerelease: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Notify on failure
        if: failure()
        run: |
          echo "❌ Build failed!"
          echo "Check the logs above for details."
        continue-on-error: true
```

---

## 3️⃣ ملف Workflow 2: analyze-and-test.yml

انسخ هذا المحتوى إلى `.github/workflows/analyze-and-test.yml`:

```yaml
name: Analyze & Test

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

jobs:
  analyze:
    runs-on: ubuntu-latest
    name: Analyze Code
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          cache: true
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run flutter analyze
        run: flutter analyze
      
      - name: Check formatting
        run: dart format --set-exit-if-changed lib/
        continue-on-error: true
      
      - name: Run linter
        run: flutter analyze --no-pub
        continue-on-error: true

  test:
    runs-on: ubuntu-latest
    name: Unit Tests
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          cache: true
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run tests
        run: flutter test --coverage
        continue-on-error: true
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
        continue-on-error: true

  build-debug:
    runs-on: ubuntu-latest
    name: Build Debug APK
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '11'
          cache: gradle
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
          cache: true
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build Debug APK
        run: flutter build apk --debug
      
      - name: Upload Debug APK
        uses: actions/upload-artifact@v3
        with:
          name: debug-apk
          path: build/app/outputs/flutter-app-debug.apk
          retention-days: 7
```

---

## 4️⃣ التحقق من الإعداد

بعد إنشاء الملفات:

```
1. اذهب إلى Repository → Actions
2. يجب أن ترى الـ Workflows الجديدة
3. انقر على Workflow لعرض الـ Runs
```

---

## 5️⃣ تشغيل Workflow

### الطريقة 1: Push تلقائي

```bash
git push origin master
# سيتم تشغيل Workflow تلقائياً
```

### الطريقة 2: إنشاء Tag

```bash
git tag v1.0.0
git push origin v1.0.0
# سيتم بناء APK وإنشاء Release
```

### الطريقة 3: تشغيل يدوي

```
1. اذهب إلى Actions
2. اختر Workflow
3. انقر على "Run workflow"
4. اختر الفرع
5. انقر على "Run workflow"
```

---

## 6️⃣ مراقبة البناء

### عرض حالة البناء

```
Actions → اختر الـ Workflow → اعرض آخر Run
```

### تحميل الملفات

```
Actions → آخر Run ناجح → Artifacts → حمّل الملفات
```

---

## 7️⃣ معالجة الأخطاء

### خطأ: "Workflow file is invalid"

**الحل**:
- تأكد من صيغة YAML صحيحة
- استخدم [YAML Validator](https://www.yamllint.com/)

### خطأ: "Flutter SDK not found"

**الحل**:
- Workflow يعيّن Flutter تلقائياً
- لا تقلق، سيعمل

### خطأ: "Build failed"

**الحل**:
- اعرض السجل
- ابحث عن الأخطاء
- أصلح محلياً

---

## 8️⃣ الأوامر المفيدة

### عبر GitHub CLI

```bash
# عرض الـ Workflows
gh workflow list

# تشغيل Workflow
gh workflow run build-release-apk.yml

# عرض الـ Runs
gh run list

# تحميل Artifacts
gh run download <run-id>
```

---

## 9️⃣ نصائح مهمة

✅ **استخدم Tags** للإصدارات الرسمية  
✅ **راقب الـ Actions** بانتظام  
✅ **احفظ الملفات** من Artifacts  
✅ **اختبر محلياً** قبل الـ Push  
✅ **اقرأ السجلات** عند الأخطاء  

---

## 🔟 الخلاصة

بعد إنشاء ملفات Workflow:

1. ✅ سيتم بناء APK تلقائياً عند الـ Push
2. ✅ سيتم بناء APK عند إنشاء Tag
3. ✅ سيتم رفع الملفات كـ Artifacts
4. ✅ سيتم إنشاء Release على GitHub

---

**آخر تحديث**: [التاريخ الحالي]  
**الحالة**: ✅ جاهز للاستخدام
