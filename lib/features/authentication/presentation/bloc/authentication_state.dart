part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSignUp extends AuthenticationState {
  final UserEntity user;
  const AuthenticationSignUp({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationLogin extends AuthenticationState {
  final UserEntity user;
  const AuthenticationLogin({required this.user});
  @override
  List<Object> get props => [user];
}

class EmailVerificationSent extends AuthenticationState {
  final String message;

  const EmailVerificationSent({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateSendEmailVerification extends AuthenticationState {
  final String message;

  const UpdateSendEmailVerification({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationDataStored extends AuthenticationState {}

class AuthenticationResetPassword extends AuthenticationState {}

class AuthenticationLogout extends AuthenticationState {}

class AuthenticationEmailNotVerified extends AuthenticationState {
  final String message;

  const AuthenticationEmailNotVerified({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
