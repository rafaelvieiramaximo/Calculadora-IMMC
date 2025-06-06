import 'package:flutter/material.dart';
import 'package:calculadora_immc/style/style.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cadastro', style: AppTextStyles.register),
          const SizedBox(height: 16),
          // Adicione aqui os campos do formulário de cadastro
          TextField(decoration: InputDecoration(labelText: 'Email')),
          TextField(
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica de cadastro
                  Navigator.of(context).pop();
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
