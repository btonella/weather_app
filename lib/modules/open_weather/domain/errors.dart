abstract class OpenWeatherFailure implements Exception {
  String? get message;
  get data;
}

class OpenWeatherRequestError implements OpenWeatherFailure {
  @override
  String? message;
  @override
  dynamic data;
  OpenWeatherRequestError({this.message, this.data});
}

class OpenWeatherUnauthorizedError implements OpenWeatherFailure {
  @override
  String? message;
  @override
  dynamic data;
  OpenWeatherUnauthorizedError({this.message, this.data});
}

class OpenWeatherForbiddenError implements OpenWeatherFailure {
  @override
  String? message;
  @override
  dynamic data;
  OpenWeatherForbiddenError({this.message, this.data});
}

class OpenWeatherInternalError implements OpenWeatherFailure {
  @override
  String? message;
  @override
  dynamic data;
  OpenWeatherInternalError({this.message, this.data});
}

class OpenWeatherUnkownError implements OpenWeatherFailure {
  @override
  String? message;
  @override
  dynamic data;
  OpenWeatherUnkownError({this.message, this.data});
}
