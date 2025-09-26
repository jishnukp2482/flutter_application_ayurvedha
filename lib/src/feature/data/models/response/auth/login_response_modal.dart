class LoginResponseModel {
  final bool status;
  final String message;
  final String token;
  final bool? isSuperuser;
  final UserDetails? userDetails;

  LoginResponseModel({
    required this.status,
    required this.message,
    this.token = "",
    this.isSuperuser,
    this.userDetails,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      isSuperuser: json['is_superuser'] ?? false,
      userDetails: json['user_details'] != null
          ? UserDetails.fromJson(json['user_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
      'is_superuser': isSuperuser,
      'user_details': userDetails,
    };
  }
}

class UserDetails {
  final int id;
  final String? lastLogin;
  final String name;
  final String phone;
  final String address;
  final String mail;
  final String username;
  final String password;
  final String passwordText;
  final int admin;
  final bool isAdmin;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String? branch;

  UserDetails({
    required this.id,
    this.lastLogin,
    required this.name,
    required this.phone,
    required this.address,
    required this.mail,
    required this.username,
    required this.password,
    required this.passwordText,
    required this.admin,
    required this.isAdmin,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.branch,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      lastLogin: json['last_login'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      mail: json['mail'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      passwordText: json['password_text'] ?? '',
      admin: json['admin'] ?? 0,
      isAdmin: json['is_admin'] ?? false,
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_login': lastLogin,
      'name': name,
      'phone': phone,
      'address': address,
      'mail': mail,
      'username': username,
      'password': password,
      'password_text': passwordText,
      'admin': admin,
      'is_admin': isAdmin,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'branch': branch,
    };
  }
}
