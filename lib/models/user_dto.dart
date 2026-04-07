// /models/user_dto.dart
// DTO = Data Transfer Object
// dto , pojo , bean, vo = design pattern (padrões de projeto)

class UserDTO {
  // final = imutabilidade (conceito | boa prática)
  final String username;
  final String password;

  // user = UserDTO(username: '', password: '')
  UserDTO({required this.username, required this.password});

  // método de classe UserDTO que retorna uma representação de JSON dos atributos
  // Map<String, dynamic> = estrutura de dados do tipo Mapa (chave , valor)
  Map<String, dynamic> toJson() => {'username': username, 'password': password};

  // factory = fábrica = padrão de projeto utilizado para construção (instanciação) de objetos
  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      UserDTO(username: json['username'], password: json['password']);
}
