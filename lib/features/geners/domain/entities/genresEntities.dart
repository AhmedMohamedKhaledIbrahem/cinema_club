import 'package:equatable/equatable.dart';

class GenresEntities extends Equatable {
  final int id;
  final String name;
  const GenresEntities({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
