class UserModel {
  String? user_id;
  String? user_name;
  String? email;
  String? password; 

  UserModel(
    this.user_id,  
    this.user_name,
    this.email, 
    this.password, 
  );

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'user_name':user_name,
      'email': email,
      'password': password
    };
  }

  UserModel.fromMap(Map<String, dynamic> userModel) {
    user_id = userModel['user_id'];
    user_name= userModel['user_name'];
    email = userModel['email'];
    password = userModel['password'];
  }
}
