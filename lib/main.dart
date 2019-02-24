import 'package:flutter_demo_json/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_json/Bloc/User/UserBloc.dart';
import 'Bloc/User/UserEvent.dart';
import 'Bloc/User/UserState.dart';
import 'View/User.dart';
import 'Bloc/LikeComment/LikeCommentBloc.dart';

void main() {
  final UserBloc userBloc = UserBloc();
  final LikeCommentBloc likeCommentBloc = LikeCommentBloc();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "JSON DECODE",
    home: BlocProvider(
        bloc: userBloc,
        child: BlocProvider(
            bloc: likeCommentBloc,
            child: Main(
              userBloc: userBloc,
              likeCommentBloc: likeCommentBloc,
            )
        )
    ),
  ));
}

class Main extends StatelessWidget {

  final UserBloc userBloc;
  final LikeCommentBloc likeCommentBloc;

  Main({this.userBloc,this.likeCommentBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return UserWidget(userBloc: userBloc,likeCommentBloc: likeCommentBloc,);
  }
}
