import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:crud_flutter_api/views/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/theme_controller.dart';

void main() {
  Get.put(ThemeController());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'CRUD de Produtos',
          debugShowCheckedModeBanner: false,
          themeMode: themeController.themeMode.value,

          /// 🎨 Tema Claro
          theme: _buildTheme(Brightness.light),

          /// 🌙 Tema Escuro
          darkTheme: _buildTheme(Brightness.dark),

          home: ProductListPage(),
        );
      },
    );
  }

  /// 🎨 Método para criar temas claros e escuros
  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final primaryColor = isDark ? const Color(0xFF2A2A3C) : const Color(0xFF512DA8);
    final secondaryColor = isDark ? const Color(0xFF2A2A3C) : const Color(0xFF7E57C2);
    final backgroundColor = isDark ? const Color(0xFF1E1E2C) : const Color(0xFFF5F5F5);
    final surfaceColor = isDark ? const Color(0xFF2A2A3C) : Colors.white;
    final onPrimary = isDark ? Colors.black : Colors.white;
    final onBackground = isDark ? Colors.white70 : Colors.black87;
    final onSurface = isDark ? Colors.white70 : Colors.black87;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: onPrimary,
        secondary: secondaryColor,
        onSecondary: onPrimary,
        error: isDark ? Colors.red.shade400 : Colors.red.shade700,
        onError: isDark ? Colors.black : Colors.white,
        background: backgroundColor,
        onBackground: onBackground,
        surface: surfaceColor,
        onSurface: onSurface,
      ),
      scaffoldBackgroundColor: backgroundColor,

      /// 🧠 AppBar refinado
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        centerTitle: true,
        elevation: 3,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),

      /// 🃏 Cards
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
      ),

      /// 🔤 Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: onSurface.withOpacity(0.6)),
      ),

      /// 🔘 Botões elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      /// ⚙️ FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
