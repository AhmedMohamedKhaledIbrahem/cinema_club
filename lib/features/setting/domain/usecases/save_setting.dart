import 'package:cinema_club/core/errors/failures.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/domain/repositories/setting_repository.dart';
import 'package:dartz/dartz.dart';

class SaveSetting {
  final SettingRepository repository;
  SaveSetting({required this.repository});
  Future<Either<Failures, void>> saveSetting(SettingEntity settings) async {
    return await repository.saveSetting(settings);
  }
}
