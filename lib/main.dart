import 'package:flutter/material.dart';

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
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.amber,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _massaController = TextEditingController();
  String? _resultado;

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
    });
  }

  void _limparCampos() {
    _alturaController.clear();
    _massaController.clear();
    setState(() {
      _resultado = null;
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                const SizedBox(height: 8),
                const Icon(
                  Icons.calculate_rounded,
                  size: 80,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 24),
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
                    child: const Text('Calcular IMMC'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
