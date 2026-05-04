import 'package:aula1_hello_flutter/screens/login_page_widget.dart';
import 'package:aula1_hello_flutter/screens/tela1_widget.dart';
import 'package:aula1_hello_flutter/screens/tela2_widget.dart';
import 'package:aula1_hello_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final _authService = AuthService();

  Future<void> _handleLogout() async {
    await _authService.saveRememberedUser('', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPageWidget()),
      );
    }
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text('Deseja sair da aplicação?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout();
              },
              child: Text(
                'Confirmar',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: Icon(Icons.cast_for_education),
      applicationName: 'Aula 2 - Navegação',
      applicationVersion: '1.0.0',
      applicationLegalese: 'Todos os diretos reservados',
      children: [
        SizedBox(height: 10),
        Text(
          'ADS FEMA 2026',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.check_box_outlined, color: Colors.green),
            SizedBox(width: 4),
            Text('Uso do Navigator'),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade700, Colors.blue.shade400],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.blue),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Guilherme de Cleva Farto',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('guilherme.farto@gmail.com'),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.looks_one, color: Colors.blue.shade700),
                    ),
                    title: Text('Tela 1'),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade600,
                    ),
                    onTap: () {
                      // encerrar (fechar) o menu lateral
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Tela1Widget()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.looks_two, color: Colors.blue.shade700),
                    ),
                    title: Text('Tela 2'),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade600,
                    ),
                    onTap: () {
                      // encerrar (fechar) o menu lateral
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Tela2Widget()),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.info, color: Colors.white),
                    ),
                    title: Text('Sobre'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showAboutDialog(context);
                    },
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.logout, color: Colors.white),
                    ),
                    title: Text('Sair...'),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade600, width: 1.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outlined,
                        size: 14,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Versão 1.0.0',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Aula 2',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-vindo à Home!', style: TextStyle(fontSize: 28)),
      ),
    );
  }
}
