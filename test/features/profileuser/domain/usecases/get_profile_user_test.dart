import 'package:cinema_club/features/profileuser/domain/entities/profile_user_Entitiy.dart';
import 'package:cinema_club/features/profileuser/domain/repositories/profile_user_repositories.dart';
import 'package:cinema_club/features/profileuser/domain/usecases/get_profile_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileUserRepositories>()])
void main() {
  late MockProfileUserRepositories mockProfileUserRepositories;
  late GetProfileUser user;

  setUp(() {
    mockProfileUserRepositories = MockProfileUserRepositories();
    user = GetProfileUser(repositories: mockProfileUserRepositories);
  });
  const tProfileUser = ProfileUserEntitiy(
      name: "example", email: "example@gmail.com", photo: "");

  test('should return Profile User from the repository', () async {
    when(mockProfileUserRepositories.getProfileUser())
        .thenAnswer((_) async => const Right(tProfileUser));
    final result = await user.getProfileUser();
    expect(result, const Right(tProfileUser));
    verify(mockProfileUserRepositories.getProfileUser());
    verifyNoMoreInteractions(mockProfileUserRepositories);
  });
}
