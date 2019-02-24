import '../../Model/Comment.dart';
import 'package:bloc/bloc.dart';
import 'CommentEvent.dart';
import 'CommentState.dart';

class CommentBloc extends Bloc<CommentEvent,CommentState>{
  @override
  // TODO: implement initialState
  CommentState get initialState => CommentIntialize();

  @override
  Stream<CommentState> mapEventToState(CommentState currentState, CommentEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FechCommentEvent){
      yield CommentFetching();
      try{
        Comment comment = Comment();
        List<Comment> comments =  await comment.fetchComment(event.userId);
        if(comments.length > 0){
          yield CommentFetched(comments: comments);
        }else{
          yield CommentEmpty();
        }
      }catch(e){
        yield CommentError();
      }
    }
  }
}

