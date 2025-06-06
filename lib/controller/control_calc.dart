import 'package:flutter/material.dart';

class CalculatorController {
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController massaController = TextEditingController();

  String? resultado;
  String? categoria = '';

  String getTimeGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Bom dia';
    } else if (hour >= 12 && hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  void calcularIMC(VoidCallback setStateCallback) {
    final altura = double.tryParse(alturaController.text.replaceAll(',', '.'));
    final massa = double.tryParse(massaController.text.replaceAll(',', '.'));
    if (altura == null || massa == null || altura <= 0 || massa <= 0) {
      resultado = 'Por favor, insira valores válidos para altura e massa.';
      setStateCallback();
      return;
    }
    final alturaM = altura / 100;
    final imc = massa / (alturaM * alturaM);
    categoria =
        imc < 16
            ? 'Magreza Grave'
            : imc >= 16 && imc < 16.9
            ? 'Magreza Moderada'
            : imc >= 17 && imc < 18.5
            ? 'Magreza Leve'
            : imc >= 18.6 && imc < 24.9
            ? 'Peso Ideal'
            : imc >= 25 && imc < 29.9
            ? 'Sobrepeso'
            : imc >= 30 && imc < 34.9
            ? 'Obesidade Grau I'
            : imc >= 35 && imc < 39.9
            ? 'Obesidade Grau II (severa)'
            : 'Obesidade Grau III (mórbida)';

    resultado =
        'Seu IMMC é ${imc.toStringAsFixed(2)}, está na categoria: $categoria';
    setStateCallback();

    alturaController.clear();
    massaController.clear();
  }

  void limparCampos(VoidCallback setStateCallback) {
    alturaController.clear();
    massaController.clear();
    resultado = null;
    categoria = '';
    setStateCallback();
  }
}
