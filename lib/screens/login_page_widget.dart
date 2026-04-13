import 'package:aula1_hello_flutter/screens/home_page_widget.dart';
import 'package:aula1_hello_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isLoading = true;
  bool _rememberMe = false;
  bool isPasswordVisible = true;

  Future<void> _checkRememberedUser() async {
    await Future.delayed(Duration(seconds: 2));
    final rememberedUser = await _authService.getRememberedUser();
    //houve usuário autenticado e persistido e não expirado (5min)
    if (rememberedUser != null) {
      _usuarioController.text = rememberedUser; //atribuição do usuario no form
      setState(() {
        _rememberMe = true; //marca o checkbox de lembrar-me
      });
    }
    setState(() {
      _isLoading = false; //oculta o indicador de carregamento
    });
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final _usuarioValue = _usuarioController.text;
      final _senhaValue = _senhaController.text;

      final isValid = await _authService.authenticate(
        _usuarioValue,
        _senhaValue,
      );

      if (isValid) {
        await _authService.saveRememberedUser(_usuarioValue, _rememberMe);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePageWidget()),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkRememberedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autenticação')),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Carregando...', style: TextStyle(fontSize: 20)),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsGeometry.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Olá, visitante',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usuarioController,
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe o usuário';
                          } else if (value.length < 3) {
                            return 'O usuário deve possuir 3 ou mais caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _senhaController,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe a senha';
                          } else if (value.length < 4) {
                            return 'A senha deve possuir 4 ou mais caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        title: Text('Lembrar-me'),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
