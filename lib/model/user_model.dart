class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;

  UserModel({
    this.id,
    this.firstName,
    this.mobileNumber,
    this.email,
    this.lastName,

    //this.isGuest
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['user_id'].toString();
    firstName = json['user_firstname'];
    lastName = json['user_lastname'];
    email = json['user_email'];
    mobileNumber = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    data['user_firstname'] = firstName;
    data['user_lastname'] = lastName;
    data['user_email'] = email;
    data['user_phone'] = mobileNumber;

    return data;
  }
}
