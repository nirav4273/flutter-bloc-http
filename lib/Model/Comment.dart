import 'package:http/http.dart' as http;
import 'dart:convert';

class Comment{
  String url = "https://jsonplaceholder.typicode.com/posts?userId=";

  int userId;
  int id;
  String title;
  String body;

  Comment({this.body,this.title,this.id,this.userId});

  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
      title: json['title'],
      id: json['id'],
      body: json['body'],
      userId: json['userId']
    );
  }


  Future<List<Comment>> fetchComment(int userId)async{
    try{
      final data = await http.get(url+userId.toString());
      List body = json.decode(data.body);
      return body.map((comment)=> Comment.fromJson(comment)).toList();

    }catch(e){
      throw Exception(e);
    }
  }
}