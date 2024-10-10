import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/signout.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'sign_out_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late Signout signOut;
  setUp(() {
    mockUserRepository = MockUserRepository();
    signOut = Signout(repository: mockUserRepository);
  });

  test('should return void from the repository', () async {
    when(mockUserRepository.signOut())
        .thenAnswer((_) async => const Right(null));
    final result = await signOut.signOut();
    expect(result, const Right(null));
    verify(mockUserRepository.signOut());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
