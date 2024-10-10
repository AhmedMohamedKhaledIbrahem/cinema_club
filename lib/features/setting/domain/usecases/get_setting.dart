import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/repositories/setting_repository.dart';
import 'package:dartz/dartz.dart';

class GetSetting {
  final SettingRepository repository;
  GetSetting({required this.repository});
  Future<Either<Failures, SettingEntity>> getSetting() async {
    return await repository.getSetting();
  }
}
