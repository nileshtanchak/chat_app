class LoginModel {
  final bool? success;
  final UserData? userData;
  final String? message;

  LoginModel({
    this.success,
    this.userData,
    this.message,
  });

  LoginModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        userData = (json['userData'] as Map<String, dynamic>?) != null
            ? UserData.fromJson(json['userData'] as Map<String, dynamic>)
            : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() =>
      {'success': success, 'userData': userData?.toJson(), 'message': message};
}

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;
  final int? v;

  UserData({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.v,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        password = json['password'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'createdAt': createdAt,
        '__v': v
      };
}
