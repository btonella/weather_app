import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  final double? speed;
  final int? deg;
  final double? gust;

  const Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  @override
  List<Object?> get props => [];

  static Wind fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: map['speed'],
      deg: map['deg'],
      gust: map['gust'],
    );
  }
}
