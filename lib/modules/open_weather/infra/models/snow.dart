import 'package:equatable/equatable.dart';

class Snow extends Equatable {
  final double? last1h;
  final double? last3h;

  const Snow({
    this.last1h,
    this.last3h,
  });

  @override
  List<Object?> get props => [];

  static Snow fromMap(Map<String, dynamic> map) {
    return Snow(
      last1h: map['1h'],
      last3h: map['3h'],
    );
  }
}
