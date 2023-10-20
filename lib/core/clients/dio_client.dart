import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/core/utils/enums.dart';

import 'network_client.dart';

class DioClient extends NetworkClient<dynamic, DioParams> {
  static final DioClient _instance = DioClient._internal();
  String? apiUrl;
  String? apiKey;

  DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  void init({required String apiUrl, required String apiKey}) {
    this.apiUrl = apiUrl;
    this.apiKey = apiKey;
  }

  @override
  Future<dynamic> call(DioParams params, {String? contentType}) async {
    String url = '';
    if (params.url == null) {
      url = '$apiUrl${params.endpoint}';
    } else {
      url = '${params.url}${params.endpoint}';
    }
    // if (params.params != null) {
    //   url += '?';

    //   if (params.params != null) {
    //     params.params!.forEach((key, value) {
    //       url += '$key=$value&';
    //     });
    //   }
    // }
    Map<String, String> header = params.headers ?? <String, String>{};

    var logString = '${params.httpMethod}: $url';

    params.params?['key'] = apiKey;
    if (params.params != null) {
      logString += ' params: ${params.params.toString()}';
    }

    if (params.body != null) {
      logString += ' body: ${params.body.toString()}';
    }
    log(logString);
    try {
      final rawResponse = (await _connect(params.httpMethod,
          url: url, headers: header, body: params.body, contentType: contentType, params: params.params));
      // ignore: prefer_typing_uninitialized_variables
      var response;
      // log('Response: $rawResponse}');
      if (params.shouldHandleResponse) {
        response = rawResponse.handleError(params.allowedStatusCodes);
      } else {
        response = rawResponse.data;
      }
      return response!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> _connect(
    HttpMethod method, {
    required String url,
    String? contentType,
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? params,
  }) async {
    Dio dio = Dio();
    if (headers != null) {
      dio.options = BaseOptions(
          headers: headers,
          contentType: contentType ?? Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (statusCode) {
            return statusCode! <= 1000;
          });
    }

    switch (method) {
      case HttpMethod.DELETE:
        return _handleCall(() async {
          return (await dio.delete(url,
              data:
                  //FormData.fromMap(body ?? {})
                  body,
              queryParameters: params));
        });
      case HttpMethod.GET:
        return _handleCall(() async {
          final response = (await dio.get(url, queryParameters: params));
          return response;
        });
      case HttpMethod.POST:
        return _handleCall(() async {
          return (await dio.post(url, queryParameters: params, data: body));
        });
      case HttpMethod.PUT:
        return _handleCall(() async {
          return (await dio.put(url, queryParameters: params, data: body));
        });
      case HttpMethod.PATCH:
        return _handleCall(() async {
          return (await dio.patch(url, queryParameters: params, data: body));
        });
      default:
        return _handleCall(() async {
          final response = (await dio.get(url, queryParameters: params));
          return response;
        });
    }
  }

  Future<T> _handleCall<T>(Future<T> Function() onRequest) async {
    try {
      return onRequest().timeout(const Duration(seconds: 25));
    } on TimeoutException catch (_) {
      throw 'Request timeout!!';
    } catch (e) {
      throw e.toString();
    }
  }
}

extension ResponseExtension on Response {
  Map<String, dynamic>? handleError(List<int> allowedStatusCodes) {
    if (data == null) return {};
    Map<String, dynamic> json;
    if ((allowedStatusCodes.contains(statusCode)) || statusCode! < 400) {
      if (data is! Map<String, dynamic>) {
        json = jsonDecode(data);
      } else {
        json = data;
      }
      return json;
    } else {
      // if (statusCode == 400) {
      //   Observable().notifyListeners((observer) => observer.onUnAuthorized());
      // }
      String errorText = "";
      if (data["errors"] != null) {
        Map<dynamic, dynamic> errors = data["errors"];
        if (errors.values.isEmpty || errors.values.toList()[0] == null || (errors.values.toList()[0] as List).isEmpty) {
          errorText = 'エラー！エラーが発生しました。しばらくしてからもう一度お試しください。';
        }
        errorText = errors.values.toList()[0][0];
      } else if (data["message"] != null && data["message"] != "") {
        errorText = data["message"];
      } else {
        errorText = 'エラー！エラーが発生しました。しばらくしてからもう一度お試しください。';
      }
      throw errorText;
    }
  }
}

class DioParams {
  final HttpMethod httpMethod;
  final String? url;
  final String endpoint;
  final bool dynamicResponse;
  final Map<String, String>? headers;
  Map<String, dynamic>? params;
  final dynamic body;
  final bool needAuthrorize;
  final bool shouldHandleResponse;
  final List<int> allowedStatusCodes;

  DioParams(this.httpMethod,
      {this.url,
      required this.endpoint,
      this.headers,
      this.params,
      this.body,
      this.dynamicResponse = false,
      this.needAuthrorize = true,
      this.shouldHandleResponse = true,
      this.allowedStatusCodes = const []});
}
