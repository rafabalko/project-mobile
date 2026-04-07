import 'package:flutter/material.dart';

class Tela1Widget extends StatelessWidget {
  const Tela1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela 1 - Navegação')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
                      Icons.list_outlined,
                      size: 80,
                      color: Colors.blue
            ),
            const SizedBox(height: 20),
            const Text('Listagem de Dados',
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
