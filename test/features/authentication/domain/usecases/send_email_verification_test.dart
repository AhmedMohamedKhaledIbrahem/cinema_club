import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/send_email_verification.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_email_verification_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late SendEmailVerification sendEmailVerification;

  setUp(() {
    mockUserRepository = MockUserRepository();
    sendEmailVerification =
        SendEmailVerification(repository: mockUserRepository);
  });

  test('should return the void from the repository', () async {
    when(mockUserRepository.sendEmailVerification())
        .thenAnswer((_) async => const Right(null));
    final result = await sendEmailVerification.sendEmailVerification();
    expect(result, const Right(null));
    verify(mockUserRepository.sendEmailVerification());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
