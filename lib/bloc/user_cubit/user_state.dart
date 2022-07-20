part of 'user_cubit.dart';

@immutable
class UserState extends Equatable {
  final User? user;

  const UserState({this.user});
  UserState copyWith({
    User? user,
  }) =>
      UserState(
        user: user ?? this.user,
      );
  @override
  List<Object?> get props => [user];
}
