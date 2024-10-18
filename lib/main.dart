import 'package:flutter/material.dart';
import 'package:untitled/theme/app_theme.dart';
import 'package:untitled/ui/keuangan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow Keuangan App',
      theme: AppTheme.rainbowTheme,
      home: const KeuanganPage(),
    );
  }
}
