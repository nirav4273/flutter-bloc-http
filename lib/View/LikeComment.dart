import 'package:flutter/material.dart';
import '../Bloc/LikeComment/LikeCommentBloc.dart';
import '../Model/Comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LikeCommentWidget extends StatelessWidget{

  final LikeCommentBloc likeCommentBloc;
  LikeCommentWidget({this.likeCommentBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked Comments"),
      ),
      body: BlocBuilder(
          bloc: likeCommentBloc,
          builder: (context,state){
            List<Comment> comments = state;
            if(comments.length > 0){
              return ListView.builder(
                  itemBuilder:(context,index){
                    return  ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(comments[index].title),
                      subtitle: Text(comments[index].body),
                      trailing: InkResponse(
                        onTap: (){
                          likeCommentBloc.dispatch(DiLikeComment(comment: comments[index]));
                        },
                        child: Icon(Icons.thumb_down),
                      ),

                    );
                  },
                itemCount: comments.length,
              );
            }else{
              return Center(
                child: Text("NO comment likes"),
              );
            }
          }
      ),
    );
  }
}