import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/repositories/setting_repository.dart';
import 'package:cinema_club/features/setting/domain/usecases/get_setting.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_setting_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingRepository>()])
void main() {
  late MockSettingRepository mockSettingRepository;
  late GetSetting getSetting;

  setUp(() {
    mockSettingRepository = MockSettingRepository();
    getSetting = GetSetting(repository: mockSettingRepository);
  });

  const tSettingEntity =
      SettingEntity(isDarkMode: false, languageCode: "languageCode");

  test('should return Setting  from the repository', () async {
    when(mockSettingRepository.getSetting())
        .thenAnswer((_) async => const Right(tSettingEntity));
    final result = await getSetting.getSetting();
    expect(result, const Right(tSettingEntity));
    verify(mockSettingRepository.getSetting());
    verifyNoMoreInteractions(mockSettingRepository);
  });
}
