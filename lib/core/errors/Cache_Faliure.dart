import 'package:cinema_club/core/errors/failures.dart';

class CacheFaliure extends Failures {
  final String message;
  const CacheFaliure([this.message = 'Cache Faliure']);
}
