import 'package:flutter/material.dart';
import '../Bloc/Comment/CommentBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/UserModel.dart';
import '../Model/Comment.dart';
import '../Bloc/Comment/CommentEvent.dart';
import '../Bloc/Comment/CommentState.dart';
import '../Bloc/User/UserBloc.dart';
import '../Bloc/LikeComment/LikeCommentBloc.dart';


class CommentWidget extends StatefulWidget {
  final User user;
  final LikeCommentBloc likeCommentBloc;

  CommentWidget({this.user,this.likeCommentBloc});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommentState();
  }
}

class CommentState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${widget.user.email}"),
        ),
        body: BlocBuilder(
            bloc: BlocProvider.of<CommentBloc>(context),
            builder: (context, state) {
              if (state is CommentIntialize) {
                BlocProvider.of<CommentBloc>(context)
                    .dispatch(FechCommentEvent(userId: widget.user.id));
              } else if (state is CommentFetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CommentFetched) {
                List<Comment> comments = state.comments;
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return CommentListWidget(
                        likeCommentBloc: widget.likeCommentBloc,
                        comment: comments[index],
                      );
                    },
                    separatorBuilder: (conext, index) {
                      return Divider();
                    },
                    itemCount: comments.length);
              } else if (state is CommentError) {
                return Center(child: Text("ERROR"));
              }
              return Container();
            }));
  }
}

class CommentListWidget extends StatelessWidget {
  final Comment comment;
  final LikeCommentBloc likeCommentBloc;

  CommentListWidget({this.comment,this.likeCommentBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(

        contentPadding: EdgeInsets.all(10.0),
        title: Text(comment.title),
        subtitle: Text(comment.body),
        trailing: InkResponse(
          onTap: (){
            likeCommentBloc.dispatch(LikeComment(comment: comment));
          },
          child: Icon(Icons.thumb_up),
        )
    );
  }
}
