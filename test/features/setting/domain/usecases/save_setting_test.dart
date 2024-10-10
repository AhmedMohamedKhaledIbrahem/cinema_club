import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/repositories/setting_repository.dart';
import 'package:cinema_club/features/setting/domain/usecases/save_setting.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_setting_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingRepository>()])
void main() {
  late MockSettingRepository mockSettingRepository;
  late SaveSetting user;

  setUp(() {
    mockSettingRepository = MockSettingRepository();
    user = SaveSetting(repository: mockSettingRepository);
  });
  const tSettingModel = SettingModel(isDarkMode: true, languageCode: 'en');
  SettingEntity tSettingEntitiy = tSettingModel;

  test('should return volid from the repository', () async {
    when(mockSettingRepository.saveSetting(any))
        .thenAnswer((_) async => const Right(null));
    final result = await user.saveSetting(tSettingEntitiy);
    expect(result, const Right(null));
    verify(mockSettingRepository.saveSetting(any));
    verifyNoMoreInteractions(mockSettingRepository);
  });
}
