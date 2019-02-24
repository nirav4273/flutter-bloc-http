import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/User/UserBloc.dart';
import '../Bloc/User/UserEvent.dart';
import '../Bloc/User/UserState.dart';
import '../Model/UserModel.dart';
import 'Comment.dart';
import '../Bloc/Comment/CommentBloc.dart';
import '../Bloc/LikeComment/LikeCommentBloc.dart';
import '../Model/Comment.dart';
import 'LikeComment.dart';

class UserWidget extends StatefulWidget {
  final UserBloc userBloc;
  final LikeCommentBloc likeCommentBloc;

  UserWidget({this.userBloc, this.likeCommentBloc});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserState();
  }
}

class UserState extends State<UserWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final LikeCommentBloc likeCommentBloc = LikeCommentBloc();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
        actions: <Widget>[
          LikeCountWidget(
            likeCommentBloc: widget.likeCommentBloc,
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder(
            bloc: widget.userBloc,
            builder: (context, state) {
              if (state is UserInitialize) {
                BlocProvider.of<UserBloc>(context).dispatch(FetchUser());
              } else if (state is UserFetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserFetched) {
                UserFetched fetched = state as UserFetched;
                List<User> users = fetched.users;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListWidget(user: users[index],likeCommentBloc: widget.likeCommentBloc,);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: users.length,
                );
              } else if (state is UserEmpty) {
                return Center(
                  child: Text("ZERO"),
                );
              }
              return Center(
                child: Text("OTHERS"),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("PRESSED");
//          widget.likeCommentBloc.dispatch(LikeComment());
          widget.userBloc.dispatch(FetchUser());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  final User user;
  final LikeCommentBloc likeCommentBloc;
  ListWidget({this.user,this.likeCommentBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BlocProvider(
              bloc: CommentBloc(), child: CommentWidget(user: user,likeCommentBloc: likeCommentBloc,));
        }));
      },
      contentPadding: EdgeInsets.all(10.0),
      title: Text(user.email),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(user.username), Text(user.company.name)],
      ),
    );
  }
}

class LikeCountWidget extends StatelessWidget {
  final LikeCommentBloc likeCommentBloc;

  LikeCountWidget({this.likeCommentBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  BlocBuilder(
        bloc: likeCommentBloc,
        builder: (context, state) {
          List<Comment> comments = state;
         return InkResponse(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>LikeCommentWidget(likeCommentBloc: likeCommentBloc,)));
           },
           child: Container(
             alignment: Alignment.center,
             padding: EdgeInsets.only(right: 20.0),
             child: Text(comments.length.toString()),
           )
         );
        }
    );
  }
}
