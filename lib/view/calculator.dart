import 'package:flutter/material.dart';
import 'package:calculadora_immc/style/style.dart';
import 'package:calculadora_immc/controller/control_calc.dart';
import 'package:calculadora_immc/database.dart';

class CalculatorPage extends StatefulWidget {
  final String email;

  const CalculatorPage({super.key, required this.email});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorController _controller = CalculatorController();
  final DataBaseHelper _database = DataBaseHelper();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await _database.getName(widget.email);
    setState(() {
      _userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ShapeTrack'),
          backgroundColor: AppColor.appBar,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 48,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            children: [
              Text(
                '${_controller.getTimeGreeting()} ${_userName ?? ''}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.main,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.restart_alt_outlined,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                    onPressed:
                        () => _controller.limparCampos(() => setState(() {})),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Icon(
                Icons.calculate_rounded,
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 80),
              TextField(
                controller: _controller.alturaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  prefixIcon: Icon(Icons.height),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller.massaController,
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
                  onPressed:
                      () => _controller.calcularIMC(() => setState(() {})),
                  child: const Text('Calcular IMC'),
                ),
              ),
              if (_controller.resultado != null) ...[
                const SizedBox(height: 24),
                Text(
                  _controller.resultado!,
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
              const SizedBox(height: 30),
              if (_controller.resultado != null &&
                  _controller.categoria != null &&
                  _controller.categoria!.isNotEmpty) ...[
                _controller.icones(_controller.categoria),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
