class User {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'username': username,
      'name': 'Peter Clarke',
      'lastLogin': "23 March 2020 03:34 PM",
      'email': 'x7uytx@mundanecode.com'
  }
  */
  String userId = '';
  String username = '';
  String name = '';
  String lastLogin = '';
  String email = '';

  User(this.userId, this.username, this.name, this.lastLogin, this.email);

  // create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    name = json['name'];
    lastLogin = json['lastLogin'];
    email = json['email'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['name'] = name;
    data['lastLogin'] = lastLogin;
    data['email'] = email;
    return data;
  }
}