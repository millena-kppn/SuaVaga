import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const EstacionamentoApp());
}

class EstacionamentoApp extends StatelessWidget {
  const EstacionamentoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Estacionamento',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
