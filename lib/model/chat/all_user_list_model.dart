class AllUserListModel {
  final List<Users>? users;
  final String? message;

  AllUserListModel({
    this.users,
    this.message,
  });

  AllUserListModel.fromJson(Map<String, dynamic> json)
      : users = (json['users'] as List?)
            ?.map((dynamic e) => Users.fromJson(e as Map<String, dynamic>))
            .toList(),
        message = json['message'] as String?;

  Map<String, dynamic> toJson() =>
      {'users': users?.map((e) => e.toJson()).toList(), 'message': message};
}

class Users {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;
  final int? v;

  Users({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.v,
  });

  Users.fromJson(Map<String, dynamic> json)
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
