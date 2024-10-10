import 'package:cinema_club/features/authentication/domain/entities/user_entity.dart';
import 'package:cinema_club/features/authentication/domain/repositories/user_repository.dart';
import 'package:cinema_club/features/authentication/domain/usecases/store_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'store_user_data_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late StoreUserData storeUserData;
  setUp(() {
    mockUserRepository = MockUserRepository();
    storeUserData = StoreUserData(repository: mockUserRepository);
  });
  const tUserEntity = UserEntity(
      uid: "10",
      name: "ahmed",
      email: "test@gmail.com",
      phone: "01068288311",
      photo: "",
      emailVerified: false);
  test('should return void  from the repository', () async {
    when(mockUserRepository.storeUserData(any))
        .thenAnswer((_) async => const Right(null));
    final result = await storeUserData.storeUserData(tUserEntity);
    expect(result, const Right(null));
    verify(mockUserRepository.storeUserData(any));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
