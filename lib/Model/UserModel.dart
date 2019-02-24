import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  String name;
  int id;
  String username;
  String email;
  Company company;

  User({this.name, this.id, this.username, this.email, this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        company: Company.fromJson(json['company']));
  }

  String url = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> fetchData() async {
    try {
      final data = await http.get(url);
      if (data.statusCode == 200) {
        List results = json.decode(data.body);
        print(results);
        return results.map((user) => User.fromJson(user)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.bs, this.catchPhrase});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'], bs: json['bs'], catchPhrase: json['catchPhrase']);
  }
}
