// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

const DEFAULT_TIMEOUT_TIME = Duration(seconds: 30);
const int DEFAULT_QTD_TRIES = 1;
const STATUS_CODE_SUCCESS = [200, 201, 204];

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

class Api {
  final String defaultExtraConditions = '&lang=pt&units=metric&appid=470a7084354066b4f217c2948c261101';

  Api();

  Future<dynamic> getApi(String url) async {
    var json = await tryToMakeRequest(RequestMethod.GET, url);
    return json;
  }

  Future<dynamic> postApi(String url, Map<String, dynamic> data) async {
    var json = await tryToMakeRequest(RequestMethod.POST, url, body: data);
    return json;
  }

  Future<dynamic> putApi(String url, Map<String, dynamic> data) async {
    var json = await tryToMakeRequest(RequestMethod.PUT, url, body: data);
    return json;
  }

  Future<dynamic> deleteApi(String url, Map<String, dynamic> data) async {
    var json = await tryToMakeRequest(RequestMethod.DELETE, url, body: data);
    return json;
  }

  static Future<dynamic> tryToMakeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    Response? resp;
    for (var i = 0; i < DEFAULT_QTD_TRIES; i++) {
      try {
        resp = await makeRequest(method, url, headers: headers, body: body).timeout(DEFAULT_TIMEOUT_TIME);
        if (!STATUS_CODE_SUCCESS.contains(resp.statusCode)) {
          log(resp.statusCode.toString());
          log(resp.statusMessage.toString());
          break;
        } else {
          break;
        }
      } on TimeoutException catch (_) {
        // A timeout occurred.
        resp = _onTimeout();
      } on SocketException catch (_) {
        // Other exception
        _onInternetFailed();
      }
      if (resp != null) break;
    }

    if (resp == null) return null;
    try {
      return resp;
    } catch (e) {
      return null;
    }
  }

  static Future<Response> makeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    log('$method - $url');
    headers ??= getDefaultHeaders();
    Dio client = Modular.get<Dio>();
    Response resp;
    try {
      switch (method) {
        case RequestMethod.GET:
          resp = await client.get(url, options: Options(headers: headers));
          break;
        case RequestMethod.POST:
          resp = await client.post(url, options: Options(headers: headers), data: body);
          break;
        case RequestMethod.DELETE:
          resp = await client.delete(url, options: Options(headers: headers));
          break;
        case RequestMethod.PUT:
          resp = await client.put(url, options: Options(headers: headers), data: body);
          break;
        default:
          throw const SocketException('METHOD NOT SUPPORTED');
      }
    } on DioError catch (e) {
      String message = '';
      var data = {};
      if (e.response != null) {
        data = e.response!.data is String
            ? e.response!.data.isNotEmpty
                ? {"message": e.response!.data}
                : {}
            : e.response!.data ?? {};
        switch (e.response?.statusCode) {
          case 400:
            message = e.response?.statusMessage ?? 'Erro inesperado';
            break;
          case 401:
            message = e.response?.statusMessage ?? 'Sem autorização';
            break;
          case 404:
            message = e.response?.statusMessage ?? 'Não encontrado';
            break;
          case 408:
            message = e.response?.statusMessage ?? 'Timeout';
            break;
          case 409:
            message = e.response?.statusMessage ?? 'Conflict';
            break;
          case 500:
            message = e.response?.statusMessage ?? 'Erro interno';
            break;
          case 503:
            message = e.response?.statusMessage ?? 'Serviço indisponível';
            break;
          case 504:
            message = e.response?.statusMessage ?? 'Gateway Timeout';
            break;
          default:
            message = e.response?.statusMessage ?? 'Erro desconhecido';
            break;
        }
      } else {
        message = 'Erro desconhecido';
      }
      resp = Response(
        statusMessage: message,
        statusCode: e.response?.statusCode,
        data: data,
        headers: e.response?.headers,
        requestOptions: RequestOptions(path: ''),
      );
      sendLogError(resp);
    }
    return resp;
  }

  static sendLogError(Response resp) {
    // TODO: add send log error
  }

  static Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': "application/json; charset=utf-8",
      'accept': 'application/json, text/plain, */*',
    };
  }

  static _onTimeout() {
    log('TIMEOUT!');
    return Response(
      statusMessage: 'Timeout',
      statusCode: 408,
      requestOptions: RequestOptions(path: ''),
    );
  }

  static _onInternetFailed() {
    log("CONNECTION FAILED!");
  }
}
