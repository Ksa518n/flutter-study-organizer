import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_organizer/config/constants.dart';

/// فئة مساعدة لتحميل واستخدام الأصول (الأيقونات والصور)
class AssetHelper {
  /// تحميل أيقونة SVG
  static Widget loadSvgIcon(
    String assetPath, {
    double width = 24,
    double height = 24,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  /// تحميل صورة PNG
  static Widget loadImage(
    String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? backgroundColor,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: backgroundColor ?? Colors.grey[300],
          child: const Center(
            child: Icon(Icons.broken_image),
          ),
        );
      },
    );
  }

  /// تحميل صورة من الإنترنت
  static Widget loadNetworkImage(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String? placeholder,
  }) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.broken_image),
          ),
        );
      },
    );
  }

  /// تحميل صورة خلفية
  static BoxDecoration backgroundImage(String assetPath) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(assetPath),
        fit: BoxFit.cover,
      ),
    );
  }

  /// الحصول على أيقونة الميزة
  static Widget getFeatureIcon(String featureName, {double size = 24}) {
    final iconPath = _getIconPath(featureName);
    return loadSvgIcon(
      iconPath,
      width: size,
      height: size,
    );
  }

  /// الحصول على مسار الأيقونة بناءً على اسم الميزة
  static String _getIconPath(String featureName) {
    switch (featureName.toLowerCase()) {
      case 'home':
        return AppConstants.homeIcon;
      case 'subjects':
        return AppConstants.subjectsIcon;
      case 'tasks':
        return AppConstants.tasksIcon;
      case 'files':
        return AppConstants.filesIcon;
      case 'stats':
        return AppConstants.statsIcon;
      case 'settings':
        return AppConstants.settingsIcon;
      case 'support':
        return AppConstants.supportIcon;
      case 'admin':
        return AppConstants.adminIcon;
      case 'logo':
        return AppConstants.appLogo;
      default:
        return AppConstants.appLogo;
    }
  }

  /// إنشاء زر مع أيقونة
  static Widget iconButton(
    String iconPath, {
    required VoidCallback onPressed,
    double iconSize = 24,
    Color? iconColor,
    double padding = 8,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: loadSvgIcon(
            iconPath,
            width: iconSize,
            height: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  /// إنشاء بطاقة مع أيقونة وعنوان
  static Widget featureCard(
    String iconPath,
    String title, {
    String? subtitle,
    required VoidCallback onTap,
    double iconSize = 48,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadSvgIcon(
                iconPath,
                width: iconSize,
                height: iconSize,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// تحميل صورة مع معالجة الأخطاء
  static Future<ImageProvider> getImageProvider(String assetPath) async {
    try {
      return AssetImage(assetPath);
    } catch (e) {
      // في حالة الفشل، استخدم صورة افتراضية
      return AssetImage(AppConstants.appLogo);
    }
  }

  /// التحقق من وجود ملف أصل
  static Future<bool> assetExists(String assetPath) async {
    try {
      await AssetImage(assetPath).resolve(ImageConfiguration.empty);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// الحصول على حجم الصورة
  static Future<Size> getImageSize(String assetPath) async {
    final image = await _getImage(assetPath);
    return Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );
  }

  /// تحميل الصورة الفعلية
  static Future<ImageInfo> _getImage(String assetPath) async {
    final imageProvider = AssetImage(assetPath);
    final completer = Completer<ImageInfo>();
    imageProvider.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((image, synchronousCall) {
        completer.complete(image);
      }),
    );
    return completer.future;
  }
}

/// فئة مساعدة للخطوط
class FontHelper {
  /// الحصول على عائلة الخط
  static String getFontFamily(FontType fontType) {
    switch (fontType) {
      case FontType.poppins:
        return AppConstants.fontPoppins;
      case FontType.roboto:
        return AppConstants.fontRoboto;
      case FontType.cairo:
        return AppConstants.fontCairo;
    }
  }

  /// إنشاء نمط نص مخصص
  static TextStyle customTextStyle({
    required FontType fontFamily,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double? letterSpacing,
    double? lineHeight,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontFamily: getFontFamily(fontFamily),
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: lineHeight,
      decoration: decoration,
    );
  }
}

/// أنواع الخطوط المتاحة
enum FontType {
  poppins,
  roboto,
  cairo,
}

/// فئة مساعدة للألوان
class ColorHelper {
  /// الحصول على لون من الثابت
  static Color getColor(int colorValue) {
    return Color(colorValue);
  }

  /// إنشاء تدرج لوني
  static LinearGradient createGradient({
    required List<Color> colors,
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );
  }

  /// الحصول على لون شفاف
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
