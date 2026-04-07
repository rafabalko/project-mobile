// /services/auth_service.dart

import 'dart:convert';

import 'package:aula1_hello_flutter/models/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

// flutter run -d web-server

// shared preferences

class AuthService {
  // constante da chave (shared preferences) para usuários registrados
  static const String _USERS_KEY = 'registered_users';
  // último usuário (username) autenticado com sucesso
  static const String _REMEMBERED_USER_KEY = 'remembered_user';
  // timestamp (data/hora) do último armazenamento de usuário autenticado
  static const String _REMEMBER_TIMESTAMP_KEY = 'remember_timestamp';

  Future<void> initDefaultUsers() async {
    // recuperação objeto que gerencia SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // recuperação (String) dos dados de usuários registrados
    final usersData = prefs.getString(_USERS_KEY);
    // não há usuários registrados
    if (usersData == null) {
      final usersList = [
        UserDTO(username: 'admin', password: 'admin'),
        UserDTO(username: 'user', password: 'user'),
        UserDTO(username: 'rafael', password: '123'),
      ];

      // List<UserDTO> = transformar (map) List<Json> = List<Map<String, dynamic>>
      final usersJson = usersList.map((user) => user.toJson()).toList();
      await prefs.setString(_USERS_KEY, jsonEncode(usersJson));
    }
  }

  Future<bool> authenticate(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_USERS_KEY);
    if (usersJson != null) {
      final List<dynamic> usersList = jsonDecode(usersJson);
      // map = transformar / converter
      final List<UserDTO> users = usersList
          .map((u) => UserDTO.fromJson(u))
          .toList();
      return users.any((u) => u.username == username && u.password == password);
    }
    return false;
  }

  Future<void> saveRememberedUser(String username, bool remember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_REMEMBERED_USER_KEY);
    await prefs.remove(_REMEMBER_TIMESTAMP_KEY);
    if (remember) {
      await prefs.setString(_REMEMBERED_USER_KEY, username);
      await prefs.setInt(
        _REMEMBER_TIMESTAMP_KEY,
        DateTime.now().millisecondsSinceEpoch,
      );
    }
  }

  Future<String?> getRememberedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_REMEMBERED_USER_KEY);
    final timestamp = prefs.getInt(_REMEMBER_TIMESTAMP_KEY);
    if (username != null && timestamp != null) {
      // representação em milisegundos da data/hora atual (int)
      final now = DateTime.now().millisecondsSinceEpoch;
      final fiveMinutes = 5 * 60 * 1000; // 300000 milis = 5 min
      if (now - timestamp <= fiveMinutes) {
        // ainda válido
        return username;
      }
      await prefs.remove(_REMEMBERED_USER_KEY);
      await prefs.remove(_REMEMBER_TIMESTAMP_KEY);
    }
    return null;
  }
}
