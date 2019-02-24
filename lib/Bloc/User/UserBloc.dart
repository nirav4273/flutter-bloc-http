import 'package:bloc/bloc.dart';
import '../../Model/UserModel.dart';
import 'UserEvent.dart';
import 'UserState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  // TODO: implement initialState
  UserState get initialState => UserInitialize();

  @override
  Stream<UserState> mapEventToState(
      UserState currentState, UserEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchUser) {
      yield UserFetching();
      try {
        User u = User();
        List<User> users = await u.fetchData();
        if (users.length > 0) {
          yield UserFetched(users: users);
        } else {
          yield UserEmpty();
        }
      } catch (e) {
        yield UserFetchError();
      }
    }
  }
}
