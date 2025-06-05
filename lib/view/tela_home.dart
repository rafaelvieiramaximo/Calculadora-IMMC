import 'dart:async';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:calculadora_immc/style/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _timeString;
  late String _dateString;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateDateTime();
      }
    });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _timeString = DateFormat('HH:mm:ss').format(now);
      _dateString = DateFormat('dd/MM/yyyy').format(now);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Home.png", fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_timeString, style: AppTextStyles.clockText),
                const SizedBox(height: 10),
                Text(
                  _dateString,
                  style: AppTextStyles.clockText.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 45,
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mediumAqua,
                        minimumSize: const Size(160, 45),
                      ),
                      onPressed: () {
                        // Substitua pela rota da tela de login
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text('Entrar', style: AppTextStyles.buttonText),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mediumAqua,
                        minimumSize: const Size(160, 45),
                      ),
                      onPressed: () {
                        // Substitua pela rota da tela de cadastro
                        Navigator.of(context).pushNamed('/cadastro');
                      },
                      child: Text('Cadastrar', style: AppTextStyles.buttonText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
