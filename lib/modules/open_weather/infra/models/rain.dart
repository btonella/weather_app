import 'package:equatable/equatable.dart';

class Rain extends Equatable {
  final double? last1h;
  final double? last3h;

  const Rain({
    this.last1h,
    this.last3h,
  });

  @override
  List<Object?> get props => [];

  static Rain fromMap(Map<String, dynamic> map) {
    return Rain(
      last1h: map['1h'],
      last3h: map['3h'],
    );
  }
}
