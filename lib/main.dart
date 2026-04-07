import 'package:aula1_hello_flutter/screens/login_page_widget.dart';
import 'package:aula1_hello_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

// flutter run -d web-server

void main() async {
  // garante que somente após a inicialização (correta) do Flutter, outros métodos serão chamados
  WidgetsFlutterBinding.ensureInitialized();

  // instanciação de classe de serviço de autorização (auth)
  final authService = AuthService();
  // chamada de método que verifica se é necessário carregar usuários padrões (default)
  await authService.initDefaultUsers();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula 2 - Navegação',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: LoginPageWidget(),
    );
  }
}
