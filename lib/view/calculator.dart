import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  final String title;
  const CalculatorPage({super.key, required this.title});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _massaController = TextEditingController();
  String? _resultado;
  String? categoria = '';

  void _calcularIMC() {
    final altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    final massa = double.tryParse(_massaController.text.replaceAll(',', '.'));
    if (altura == null || massa == null || altura <= 0 || massa <= 0) {
      setState(() {
        _resultado = 'Por favor, insira valores válidos para altura e massa.';
      });
      return;
    }
    final imc = massa / (altura * altura);
    String categoria =
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

    setState(() {
      _resultado =
          'Seu IMMC é ${imc.toStringAsFixed(2)}, está na categoria: $categoria';
      this.categoria = categoria;
    });
  }

  void _limparCampos() {
    _alturaController.clear();
    _massaController.clear();
    setState(() {
      _resultado = null;
      categoria = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.restart_alt_outlined,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                  onPressed: _limparCampos,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Icon(
              Icons.calculate_rounded,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 100),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _massaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Massa (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calcularIMC,
                child: const Text('Calcular IMC'),
              ),
            ),
            if (_resultado != null) ...[
              const SizedBox(height: 24),
              Text(
                _resultado!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              const SizedBox(height: 24),
              Text(
                "Informe os dados!!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (categoria == 'Magreza Grave') ...[
              Icon(Icons.warning_amber_outlined, size: 40, color: Colors.red),
            ],
          ],
        ),
      ),
    );
  }
}
