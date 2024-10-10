import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRepository {
  Future<Either<Failures, SettingEntity>> getSetting();
  Future<Either<Failures, void>> saveSetting(SettingEntity settings);
}
