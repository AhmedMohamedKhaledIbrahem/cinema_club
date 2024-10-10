// Mocks generated by Mockito 5.4.4 from annotations
// in cinema_club/test/features/authentication/domain/usecases/login_with_google_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cinema_club/core/errors/failures.dart' as _i5;
import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart'
    as _i6;
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
            _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
                _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>> loginWithGoogle() =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithGoogle,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
            _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #loginWithGoogle,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
                _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #loginWithGoogle,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>> loginWithFacebook() =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithFacebook,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
            _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #loginWithFacebook,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
                _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #loginWithFacebook,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, void>> sendEmailVerification() =>
      (super.noSuchMethod(
        Invocation.method(
          #sendEmailVerification,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, void>>.value(
            _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #sendEmailVerification,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, void>>.value(
                _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #sendEmailVerification,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, void>> resetPassword(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [email],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, void>>.value(
            _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #resetPassword,
            [email],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, void>>.value(
                _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #resetPassword,
            [email],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>> signUp(
    _i6.UserEntity? user,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [
            user,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
            _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #signUp,
            [
              user,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>.value(
                _FakeEither_0<_i5.Failures, _i6.UserEntity>(
          this,
          Invocation.method(
            #signUp,
            [
              user,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, _i6.UserEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, void>> storeUserData(
          _i6.UserEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeUserData,
          [user],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, void>>.value(
            _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #storeUserData,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, void>>.value(
                _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #storeUserData,
            [user],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, void>> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, void>>.value(
            _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #signOut,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, void>>.value(
                _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #signOut,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failures, void>> updateSendVerificationState() =>
      (super.noSuchMethod(
        Invocation.method(
          #updateSendVerificationState,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failures, void>>.value(
            _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #updateSendVerificationState,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failures, void>>.value(
                _FakeEither_0<_i5.Failures, void>(
          this,
          Invocation.method(
            #updateSendVerificationState,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failures, void>>);
}
