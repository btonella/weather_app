import 'package:equatable/equatable.dart';

class Clouds extends Equatable {
  final int all;

  const Clouds({required this.all});

  @override
  List<Object?> get props => [];

  static Clouds fromMap(Map<String, dynamic> map) {
    return Clouds(
      all: map['all'],
    );
  }
}
