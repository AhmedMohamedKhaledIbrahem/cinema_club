import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/reset_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late ResetPassword resetPassword;

  setUp(() {
    mockUserRepository = MockUserRepository();
    resetPassword = ResetPassword(repository: mockUserRepository);
  });

  const tEmail = "test@gmail.com";

  test('should return the void from the repository', () async {
    when(mockUserRepository.resetPassword(any))
        .thenAnswer((_) async => const Right(null));
    final result = await resetPassword.resetPassword(tEmail);
    expect(result, const Right(null));
    verify(mockUserRepository.resetPassword(any));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
