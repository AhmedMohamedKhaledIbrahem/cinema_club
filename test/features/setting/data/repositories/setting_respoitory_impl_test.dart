import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/features/setting/data/datasources/setting_local_data_source.dart';
import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:cinema_club/features/setting/data/repositories/settings_repository_impl.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'setting_respoitory_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingLocalDataSource>()])
void main() {
  late MockSettingLocalDataSource mockSettingLocalDataSource;
  late SettingsRepositoryImpl repositoryImpl;
  setUp(() {
    mockSettingLocalDataSource = MockSettingLocalDataSource();
    repositoryImpl =
        SettingsRepositoryImpl(localDataSource: mockSettingLocalDataSource);
  });
  const tSettingModel = SettingModel(isDarkMode: true, languageCode: 'en');
  const SettingEntity tSettingEntity = tSettingModel;
  group('getSetting', () {
    test('should return setting when call the local data source is successful',
        () async {
      when(mockSettingLocalDataSource.getSetting())
          .thenAnswer((_) async => tSettingModel);
      final result = await repositoryImpl.getSetting();
      verify(mockSettingLocalDataSource.getSetting());
      expect(result, equals(const Right(tSettingEntity)));
    });

    test(
        'should return CacheFailure when call the local data source is unsucessful',
        () async {
      when(mockSettingLocalDataSource.getSetting()).thenThrow(CacheException());
      final result = await repositoryImpl.getSetting();
      verify(mockSettingLocalDataSource.getSetting());
      expect(result, equals(Left(CacheFaliure())));
    });
  });

  group('saveSetting', () {
    test('should save setting to the local data source is successful',
        () async {
      when(mockSettingLocalDataSource.saveSetting(any))
          .thenAnswer((_) async => Future.value());
      final result = await repositoryImpl.saveSetting(tSettingEntity);
      verify(mockSettingLocalDataSource.saveSetting(tSettingModel));
      expect(result, equals(const Right(null)));
    });

    test(
        'should return CacheFailure when call the local data source is unsucessful',
        () async {
      when(mockSettingLocalDataSource.saveSetting(any))
          .thenThrow(CacheException());
      final result = await repositoryImpl.saveSetting(tSettingEntity);
      verify(mockSettingLocalDataSource.saveSetting(tSettingModel));
      expect(result, equals(Left(CacheFaliure())));
    });
  });
}
