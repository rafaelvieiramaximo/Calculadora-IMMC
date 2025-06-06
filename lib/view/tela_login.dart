// ignore_for_file: camel_case_types

import 'package:calculadora_immc/database.dart';
import 'package:calculadora_immc/view/calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_immc/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  loginScreenState createState() => loginScreenState();
}

class loginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final databaseHelper = DataBaseHelper();

  void login() async {
    if (formKey.currentState!.validate()) {
      final user = await databaseHelper.getUser(emailController.text);
      if (user != null && user['password'] == passwordController.text) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculatorPage(email: user['email']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou senha incorretos.')),
        );
      }
    }
  }

  void limpaCampos() {
    emailController.clear();
    passwordController.clear();
  }

  void printAllUsers() async {
    final users = await databaseHelper.getAllUsers();
    for (var user in users) {
      if (kDebugMode) {
        print('Email: ${user['email']}, Password: ${user['password']}');
      }
    }
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
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Login',
                  style: AppTextStyles.titler.copyWith(
                    color: AppColor.main,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 80),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu email.';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return 'Por favor, insira um email válido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha.';
                          } else if (value.length < 8) {
                            return 'A senha deve ter pelo menos 8 caracteres.';
                          } else if (!RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                          ).hasMatch(value)) {
                            return 'A senha deve conter pelo menos uma letra, um número.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Wrap(
                        spacing: 16.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: login,
                            child: const Text('Entrar'),
                          ),
                          ElevatedButton(
                            onPressed: limpaCampos,
                            child: const Text('Limpar Campos'),
                          ),
                          ElevatedButton(
                            onPressed: printAllUsers,
                            child: const Text('Listar Usuários'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/cadastro');
                        },
                        child: Text(
                          'Não tem conta? Cadastre-se aqui',
                          style: TextStyle(
                            color: AppColor.main,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
