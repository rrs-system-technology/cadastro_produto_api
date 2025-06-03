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
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF512DA8),
              onPrimary: Colors.white,
              secondary: const Color(0xFF7E57C2),
              onSecondary: Colors.white,
              error: Colors.red.shade700,
              onError: Colors.white,
              background: const Color(0xFFF5F5F5),
              onBackground: Colors.black87,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF512DA8),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 3,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            cardTheme: CardTheme(
              color: Colors.white,
              elevation: 4,
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF512DA8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF512DA8),
              foregroundColor: Colors.white,
              elevation: 4,
            ),
          ),

          /// 🌙 Tema Escuro
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF9575CD),
              onPrimary: Colors.black,
              secondary: const Color(0xFFB39DDB),
              onSecondary: Colors.black,
              error: Colors.red.shade400,
              onError: Colors.black,
              background: const Color(0xFF1E1E2C),
              onBackground: Colors.white70,
              surface: const Color(0xFF2A2A3C),
              onSurface: Colors.white70,
            ),
            scaffoldBackgroundColor: const Color(0xFF1E1E2C),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2A2A3C),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 2,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            cardTheme: CardTheme(
              color: const Color(0xFF2A2A3C),
              elevation: 4,
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2A2A3C),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9575CD),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF9575CD),
              foregroundColor: Colors.black,
              elevation: 4,
            ),
          ),

          home: ProductListPage(),
        );
      },
    );
  }
}
