class FromUserModel {
  String? id;
  String? email;
  String? phone;
  String? nickName;
  String? firstName;
  String? lastName;
  String? avatar;
  int? customerType;
  bool? followed;

  FromUserModel({
    this.id,
    this.email,
    this.phone,
    this.nickName,
    this.firstName,
    this.lastName,
    this.avatar,
    this.customerType,
    this.followed,
  });

  // 从 JSON 构造 UserMmwModel
  FromUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    nickName = json['nickName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    customerType = json['customerType'];
    followed = json['followed'];
  }

  // 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'nickName': nickName,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'customerType': customerType,
      'followed': followed,
    };
  }

  @override
  String toString() {
    return 'FromUserModel{id: $id, email: $email, phone: $phone, nickName: $nickName, firstName: $firstName, lastName: $lastName, avatar: $avatar, customerType: $customerType, followed: $followed}';
  }
}
