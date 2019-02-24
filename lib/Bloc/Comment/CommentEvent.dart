
abstract class CommentEvent{}

class FechCommentEvent extends CommentEvent{
  int userId;
  FechCommentEvent({this.userId});
}

