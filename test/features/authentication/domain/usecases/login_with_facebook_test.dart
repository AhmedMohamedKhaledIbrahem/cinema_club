import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/login_with_facebook.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_with_facebook_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late LoginWithFacebook loginUsecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginUsecase = LoginWithFacebook(repository: mockUserRepository);
  });

  const tUserEntity = UserEntity(
    uid: "10",
    name: "ahmed",
    email: "test@gmail.com",
    phone: "01068288311",
    photo: "",
    emailVerified: false,
  );

  test('should return the User from the repository', () async {
    when(mockUserRepository.loginWithFacebook())
        .thenAnswer((_) async => const Right(tUserEntity));
    final result = await loginUsecase.loginWithFacebook();
    expect(result, const Right(tUserEntity));
    verify(mockUserRepository.loginWithFacebook());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
