import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/signup.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late SignUp signUp;

  setUp(() {
    mockUserRepository = MockUserRepository();
    signUp = SignUp(repository: mockUserRepository);
  });
  const tUserEntity = UserEntity(
      uid: "10",
      name: "ahmed",
      email: "test@gmail.com",
      phone: "01068288311",
      photo: "",
      emailVerified: false);
  const tPassword = "123456";

  test('should return User from the repository', () async {
    when(mockUserRepository.signUp(any, any))
        .thenAnswer((_) async => const Right(tUserEntity));
    final result = await signUp.signUp(tUserEntity, tPassword);
    expect(result, const Right(tUserEntity));
    verify(mockUserRepository.signUp(any, any));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
