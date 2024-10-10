import 'package:cinema_club/core/errors/Cache_Faliure.dart';
import 'package:cinema_club/core/errors/cache_exception.dart';
import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/setting/data/datasources/setting_local_data_source.dart';
import 'package:cinema_club/features/setting/data/models/setting_model.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/repositories/setting_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepositoryImpl implements SettingRepository {
  final SettingLocalDataSource localDataSource;
  SettingsRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failures, SettingEntity>> getSetting() async {
    try {
      final setting = await localDataSource.getSetting();
      return Right(setting);
    } on CacheException {
      return Left(CacheFaliure());
    }
  }

  @override
  Future<Either<Failures, void>> saveSetting(SettingEntity settings) async {
    try {
      final settingModel = SettingModel(
          isDarkMode: settings.isDarkMode, languageCode: settings.languageCode);
      await localDataSource.saveSetting(settingModel);
      return const Right(null);
    } on CacheException {
      return Left(CacheFaliure());
    }
  }
}
