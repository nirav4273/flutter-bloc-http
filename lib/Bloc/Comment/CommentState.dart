import '../../Model/Comment.dart';

abstract class CommentState{}

class CommentIntialize extends CommentState{}
class CommentFetching extends CommentState{}
class CommentFetched extends CommentState{
  List<Comment> comments;
  CommentFetched({this.comments}):assert(comments != null);
}
class CommentEmpty extends CommentState{
}
class CommentError extends CommentState{}