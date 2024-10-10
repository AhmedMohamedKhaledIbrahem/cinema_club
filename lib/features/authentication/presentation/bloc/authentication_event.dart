part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailEvent extends AuthenticationEvent {
  final String email;
  final String password;
  const LoginWithEmailEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LoginWithGoogleEvent extends AuthenticationEvent {}

class LoginWithFacebookEvent extends AuthenticationEvent {}

class SignUpEvent extends AuthenticationEvent {
  final UserEntity userEntity;
  final String password;
  const SignUpEvent({required this.userEntity, required this.password});
  @override
  List<Object> get props => [userEntity, password];
}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class LogoutEvent extends AuthenticationEvent {}

class SendEmailVerificationEvent extends AuthenticationEvent {}

class UpdateSendEmailVerificationEvent extends AuthenticationEvent {}

class StoreUserDataEvent extends AuthenticationEvent {
  final UserEntity userEntity;
  const StoreUserDataEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}
