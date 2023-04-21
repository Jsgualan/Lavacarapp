class User {
  String? dni;
  String? email;
  String? lastName;
  String? name;
  String? phone;
  String? post;
  String? idUser;
  String? password;
  int? rol;

  User(
      {this.dni,
      this.email,
      this.lastName,
      this.name,
      this.phone,
      this.post,
      this.idUser,
      this.password,
      this.rol});

  @override
  String toString() {
    return 'User{dni: $dni, email: $email, lastName: $lastName, name: $name, phone: $phone, post: $post, idUser: $idUser, password: $password, rol: $rol}';
  }

  factory User.fromMap(Map<String, dynamic> json) => User(
      dni: json['dni'],
      email: json['email'],
      lastName: json["last_name"],
      name: json["name"],
      phone: json["phone"],
      post: json["post"],
      idUser: json['id'],
      password: json['password'],
      rol: json["rol"]);

  Map<String, dynamic> toMap() => {
        "dni": dni,
        "email": email,
        "last_name": lastName,
        "name": name,
        "phone": phone,
        "post": post,
        "id": idUser,
        "password": password,
        "rol": rol,
      };
}
