class UserPetsModel {
  int? id;
  int? userId;
  String? nickName;
  int? breedId;
  int? gender; //  1 表示雄性，0 表示雌性
  int? sterilized; //  0 表示未绝育，1 表示已绝育
  String? birthday;
  String? arrivedDay;
  double? weight; // 假设体重是浮点数
  String? tips; // 添加 tips 字段

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
    this.tips, // 添加构造函数参数
  });

  UserPetsModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    nickName = json['nickName'];
    breedId = int.tryParse(json['breedId']?.toString() ?? '');
    gender = json['gender'];
    sterilized = json['sterilized'];
    birthday = json['birthday'];
    arrivedDay = json['arrivedDay'];
    weight = json['weight']?.toDouble();
    tips = json['tips']; // 处理 tips
  }

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
      'tips': tips, // 添加 tips 字段到 JSON
    };
  }

  @override
  String toString() {
    return 'UserPetsModel{id: $id, userId: $userId, nickName: $nickName, breedId: $breedId, gender: $gender, sterilized: $sterilized, birthday: $birthday, arrivedDay: $arrivedDay, weight: $weight, tips: $tips}';
  }
}
