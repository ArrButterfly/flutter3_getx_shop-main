class UserMmwModel {
  String? id;
  String? email;
  String? phone;
  String? nickName;
  String? firstName;
  String? lastName;
  String? avatar;
  int? customerType;
  bool? followed;

  UserMmwModel({
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

  UserMmwModel.fromJson(Map<String, dynamic> json) {
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
}

//用户的宠物信息
class UserPetsModel {
  String? id;
  String? userId;
  String? nickName;
  String? breedId;
  int? gender; //  1 表示雄性，0 表示雌性
  int? sterilized; //  0 表示未绝育，1 表示已绝育
  String? birthday;
  String? arrivedDay;
  double? weight; // 假设体重是浮点数

  UserPetsModel({
    this.id,
    this.userId,
    this.nickName,
    this.breedId,
    this.gender,
    this.sterilized,
    this.birthday,
    this.arrivedDay,
    this.weight,
  });

  // 从 JSON 构造 UserPetsModel
  UserPetsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    nickName = json['nickName'];
    breedId = json['breedId'];
    gender = json['gender'];
    sterilized = json['sterilized'];
    birthday = json['birthday'];
    arrivedDay = json['arrivedDay'];
    weight = json['weight']?.toDouble(); // 确保将体重转换为 double
  }

  // 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'nickName': nickName,
      'breedId': breedId,
      'gender': gender,
      'sterilized': sterilized,
      'birthday': birthday,
      'arrivedDay': arrivedDay,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return 'UserPetsModel{id: $id, userId: $userId, nickName: $nickName, breedId: $breedId, gender: $gender, sterilized: $sterilized, birthday: $birthday, arrivedDay: $arrivedDay, weight: $weight}';
  }
}
