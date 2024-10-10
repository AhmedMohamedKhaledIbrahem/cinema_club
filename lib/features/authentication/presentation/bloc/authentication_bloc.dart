import 'package:bloc/bloc.dart';
import 'package:cinema_club/core/errors/connection_faliure.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/core/errors/server_faliure.dart';
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/usecases/login.dart';
import 'package:cinema_club/features/authentication/domain/usecases/login_with_facebook.dart';
import 'package:cinema_club/features/authentication/domain/usecases/login_with_google.dart';
import 'package:cinema_club/features/authentication/domain/usecases/reset_password.dart';
import 'package:cinema_club/features/authentication/domain/usecases/send_email_verification.dart';
import 'package:cinema_club/features/authentication/domain/usecases/signout.dart';
import 'package:cinema_club/features/authentication/domain/usecases/signup.dart';
import 'package:cinema_club/features/authentication/domain/usecases/store_user_data.dart';
import 'package:cinema_club/features/authentication/domain/usecases/update_send_verificationState.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login loginWithEmail;
  final LoginWithGoogle loginWithGoogle;
  final LoginWithFacebook loginWithFacebook;
  final SignUp signUp;
  final SendEmailVerification verification;
  final ResetPassword resetPassword;
  final Signout logout;
  final StoreUserData storeUserData;
  final UpdateSendVerificationstate updateSendEmailVerification;

  AuthenticationBloc({
    required this.loginWithEmail,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
    required this.signUp,
    required this.verification,
    required this.resetPassword,
    required this.updateSendEmailVerification,
    required this.logout,
    required this.storeUserData,
  }) : super(AuthenticationInitial()) {
    on<LoginWithEmailEvent>(_onLogin);
    on<LoginWithGoogleEvent>(_onGoogleLogin);
    on<LoginWithFacebookEvent>(_onFacebookLogin);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SendEmailVerificationEvent>(_onSendEmailVerification);
    on<StoreUserDataEvent>(_onStoreUserData);
    on<UpdateSendEmailVerificationEvent>(_onUpdateSendEmailVerificationEvent);
  }

  _onLogin(LoginWithEmailEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherLoginWithEmail =
        await loginWithEmail.login(event.email, event.password);
    eitherLoginWithEmail.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (user) {
        if (user.emailVerified) {
          emit(AuthenticationLogin(user: user));
          add(UpdateSendEmailVerificationEvent());
        } else {
          add(SendEmailVerificationEvent());
        }
      },
    );
  }

  _onGoogleLogin(
      LoginWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherLoginWithGoogle = await loginWithGoogle.loginWithGoogle();
    eitherLoginWithGoogle.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (user) {
        emit(AuthenticationLogin(user: user));
        add(StoreUserDataEvent(userEntity: user));
      },
    );
  }

  _onFacebookLogin(
      LoginWithFacebookEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherLoginWithFacebook = await loginWithFacebook.loginWithFacebook();
    eitherLoginWithFacebook.fold(
        (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
        (user) {
      emit(AuthenticationLogin(user: user));
      add(StoreUserDataEvent(userEntity: user));
    });
  }

  _onSignUp(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherSignUp = await signUp.signUp(event.userEntity, event.password);
    eitherSignUp.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (user) {
        emit(AuthenticationSignUp(user: user));
        add(StoreUserDataEvent(userEntity: user));
      },
    );
  }

  _onStoreUserData(
      StoreUserDataEvent event, Emitter<AuthenticationState> emit) async {
    //emit(AuthenticationLoading());
    final eiterStoreUserData =
        await storeUserData.storeUserData(event.userEntity);
    eiterStoreUserData.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (_) => emit(AuthenticationDataStored()), // Emit a success state
    );
  }

  _onLogout(LogoutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherLogout = await logout.signOut();
    eitherLogout.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (_) => emit(AuthenticationLogout()),
    );
  }

  _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherResetPassword = await resetPassword.resetPassword(event.email);
    eitherResetPassword.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (_) => emit(AuthenticationResetPassword()),
    );
  }

  _onSendEmailVerification(SendEmailVerificationEvent event,
      Emitter<AuthenticationState> emit) async {
    final eitherSendEmailVerification =
        await verification.sendEmailVerification();
    eitherSendEmailVerification.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (_) => emit(
        const EmailVerificationSent(
          message: 'Verification email sent! Please check your inbox.',
        ),
      ),
    );
  }

  _onUpdateSendEmailVerificationEvent(UpdateSendEmailVerificationEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final eitherUpdateSendEmailVerification =
        await updateSendEmailVerification.updateSendVerificationState();

    eitherUpdateSendEmailVerification.fold(
        (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
        (_) {
      emit(
        const UpdateSendEmailVerification(
          message: 'Your email has been verified',
        ),
      );
    });
  }

  String _mapFailureToMessage(Failures failure) {
    if (failure is ServerFaliure) {
      return failure.message;
    } else if (failure is ConnectionFaliure) {
      return failure.message;
    } else {
      return 'Unexpected Error';
    }
  }
}
