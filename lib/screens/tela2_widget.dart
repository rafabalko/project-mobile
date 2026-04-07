import 'package:flutter/material.dart';

class Tela2Widget extends StatelessWidget {
  const Tela2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela 2 - Navegação')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
                      Icons.dataset_outlined,
                      size: 80,
                      color: Colors.blue
            ),
            const SizedBox(height: 20),
            const Text('Entrada de Dados',
                       style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
