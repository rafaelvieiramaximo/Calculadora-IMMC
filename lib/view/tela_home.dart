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

  @override
  void initState() {
    super.initState();
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
    _startClock();
  }

  void _startClock() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _timeString = _formatTime(DateTime.now());
          _dateString = _formatDate(DateTime.now());
        });
        _startClock();
      }
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
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
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mediumAqua,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: Text('Segunda Tela', style: AppTextStyles.buttonText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
