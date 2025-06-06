import 'package:calculadora_immc/view/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_immc/view/tela_home.dart';
import 'package:calculadora_immc/style/style.dart';
import 'package:calculadora_immc/view/tela_cadastro.dart';

void main() {
  runApp(const CalculatorIMC());
}

class CalculatorIMC extends StatelessWidget {
  const CalculatorIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.main,
          primary: AppColor.main,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.bginput,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.main,
            foregroundColor: AppColor.bginput,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/cadastro': (context) => const CadastroScreen(),
      },
    );
  }
}
