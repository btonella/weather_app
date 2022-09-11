abstract class OpenWeatherFailure implements Exception {
  String? get message;
  get data;
}

class OpenWeatherRequestError implements OpenWeatherFailure {
  @override
  final String? message;
  @override
  final dynamic data;
  OpenWeatherRequestError({this.message, this.data});
}

class OpenWeatherUnauthorizedError implements OpenWeatherFailure {
  @override
  final String? message;
  @override
  final dynamic data;
  OpenWeatherUnauthorizedError({this.message, this.data});
}

class OpenWeatherForbiddenError implements OpenWeatherFailure {
  @override
  final String? message;
  @override
  final dynamic data;
  OpenWeatherForbiddenError({this.message, this.data});
}

class OpenWeatherInternalError implements OpenWeatherFailure {
  @override
  final String? message;
  @override
  final dynamic data;
  OpenWeatherInternalError({this.message, this.data});
}

class OpenWeatherUnkownError implements OpenWeatherFailure {
  @override
  final String? message;
  @override
  final dynamic data;
  OpenWeatherUnkownError({this.message, this.data});
}
