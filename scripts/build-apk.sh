#!/bin/bash

# دليل بناء APK - Study Organizer
# هذا السكريبت يقوم ببناء APK للتطبيق

set -e

echo "=========================================="
echo "Study Organizer - APK Build Script"
echo "=========================================="
echo ""

# التحقق من Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت. يرجى تثبيت Flutter أولاً."
    exit 1
fi

echo "✅ Flutter مثبت"
echo ""

# الحصول على الاعتماديات
echo "📦 تثبيت الاعتماديات..."
flutter pub get
echo "✅ تم تثبيت الاعتماديات"
echo ""

# مسح البناء السابق
echo "🧹 مسح البناء السابق..."
flutter clean
echo "✅ تم مسح البناء السابق"
echo ""

# بناء APK Debug
echo "🔨 بناء APK Debug..."
flutter build apk --debug
echo "✅ تم بناء APK Debug"
echo ""

# بناء APK Release
echo "🔨 بناء APK Release..."
flutter build apk --release
echo "✅ تم بناء APK Release"
echo ""

# بناء APK مع تقسيم حسب ABI
echo "🔨 بناء APK مع تقسيم حسب ABI..."
flutter build apk --release --split-per-abi
echo "✅ تم بناء APK مع تقسيم حسب ABI"
echo ""

# عرض حجم الملفات
echo "📊 حجم الملفات المبنية:"
echo ""
echo "Debug APK:"
ls -lh build/app/outputs/flutter-apk/app-debug.apk 2>/dev/null || echo "  لم يتم العثور على الملف"
echo ""
echo "Release APK:"
ls -lh build/app/outputs/flutter-apk/app-release.apk 2>/dev/null || echo "  لم يتم العثور على الملف"
echo ""
echo "Split APKs:"
ls -lh build/app/outputs/flutter-apk/app-*-release.apk 2>/dev/null || echo "  لم يتم العثور على الملفات"
echo ""

echo "=========================================="
echo "✅ تم بناء APK بنجاح!"
echo "=========================================="
echo ""
echo "📁 الملفات المبنية موجودة في:"
echo "   build/app/outputs/flutter-apk/"
echo ""
