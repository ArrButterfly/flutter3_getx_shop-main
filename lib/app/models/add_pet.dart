class AddPetModel {
  int fromUserId; // 当前用户 ID，必填
  int breedId; // 品种 ID，必填
  String? nickName; // 宠物昵称
  int? gender; // 宠物性别, 0 为弟弟，1 为妹妹
  int? sterilized; // 是否绝育, 0 为未绝育，1 为已绝育
  String? birthday; // 生日
  String? arrivedDay; // 收养/抵达日
  String? weight; // 体重
  String? color; // 花色

  AddPetModel({
    required this.fromUserId,
    required this.breedId,
    this.nickName,
    this.gender,
    this.sterilized,
    this.birthday,
    this.arrivedDay,
    this.weight,
    this.color,
  });

  AddPetModel.fromJson(Map<String, dynamic> json)
      : fromUserId = json['fromUserId'],
        breedId = json['breedId'],
        nickName = json['nickName'],
        gender = json['gender'],
        sterilized = json['sterilized'],
        birthday = json['birthday'],
        arrivedDay = json['arrivedDay'],
        weight = json['weight'],
        color = json['color'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fromUserId'] = fromUserId;
    _data['breedId'] = breedId;
    _data['nickName'] = nickName;
    _data['gender'] = gender;
    _data['sterilized'] = sterilized;
    _data['birthday'] = birthday;
    _data['arrivedDay'] = arrivedDay;
    _data['weight'] = weight;
    _data['color'] = color;
    return _data;
  }
}
