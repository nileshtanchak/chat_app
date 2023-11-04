class ResponseModel {
  final String? data;
  final String? statusCode;
  final Map<String, String>? headers;
  final String? error;

  ResponseModel({this.data, this.statusCode, this.headers, this.error});
}

class RegisterModel {
  final bool? success;
  final User? user;
  final String? message;

  RegisterModel({
    this.success,
    this.user,
    this.message,
  });

  RegisterModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() =>
      {'success': success, 'user': user?.toJson(), 'message': message};
}

class User {
  final String? name;
  final String? email;
  final String? id;
  final String? createdAt;
  final int? v;

  User({
    this.name,
    this.email,
    this.id,
    this.createdAt,
    this.v,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        email = json['email'] as String?,
        id = json['_id'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        '_id': id,
        'createdAt': createdAt,
        '__v': v
      };
}
