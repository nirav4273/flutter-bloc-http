import '../../Model/UserModel.dart';
// User state
abstract class UserState {}

class UserInitialize extends UserState {}

class UserFetching extends UserState {}

class UserFetched extends UserState {
  List<User> users;

  UserFetched({this.users});
}

class UserEmpty extends UserState {
  List<User> users = [];

  UserEmpty({this.users});
}

class UserFetchError extends UserState {}
