import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late Login loginUsecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginUsecase = Login(repository: mockUserRepository);
  });

  const tUserEntity = UserEntity(
    uid: "10",
    name: "ahmed",
    email: "test@gmail.com",
    phone: "01068288311",
    photo: "",
    emailVerified: false,
  );
  const tEmail = "test@gmail.com";
  const tPassword = "123456";

  test('should return the User from the repository', () async {
    when(mockUserRepository.login(any, any))
        .thenAnswer((_) async => const Right(tUserEntity));
    final result = await loginUsecase.login(tEmail, tPassword);
    expect(result, const Right(tUserEntity));
    verify(mockUserRepository.login(any, any));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
