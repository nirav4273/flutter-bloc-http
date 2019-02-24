import 'package:bloc/bloc.dart';
import '../../Model/Comment.dart';
import '../Toast.dart';

class LikeCommentBloc extends Bloc<LikeCommentEvent,List<Comment>>{
  List<Comment> comments = [];

  @override
  // TODO: implement initialState
  List<Comment> get initialState => comments;

  @override
  Stream<List<Comment>> mapEventToState(List<Comment> currentState, LikeCommentEvent event) async*{
    // TODO: implement mapEventToState
    if(event is LikeComment){
      bool isExist = comments.contains(event.comment);
      print(isExist);
      if(!isExist){
        comments.add(event.comment);
      }else{
        print("Allred THERE");
      }
      yield currentState = comments;
    }else if(event is DiLikeComment){
      print("Called DISLIKE ${comments.length}");
      comments.removeWhere((c) => c.id == event.comment.id);
      print("AFTER REMOVE ${comments.length}");
      yield currentState = [];
      yield currentState = comments;
    }
  }
}




abstract class LikeCommentEvent{}

class LikeComment extends LikeCommentEvent{
  final Comment comment;
  LikeComment({this.comment});
}

class DiLikeComment extends LikeCommentEvent{
  final Comment comment;
  DiLikeComment({this.comment});
}

