import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class HttpActions {
  IOptions _options;

  HttpActions(IOptions options) {
    _options = options;
  }

  Future<Response> get(IMethodArgs args) async {
    final request = await _makeRequest('get', args);
    final response = await http.get(request.url, headers: request.headers);
    return Response.fromHttpResponse(response);
  }

  Future<Response> post(IMethodArgs args) async {
    final request = await _makeRequest('post', args);
    final response = await http.post(
      request.url,
      headers: request.headers,
      body: request.body,
    );
    return Response.fromHttpResponse(response);
  }

  Future<Response> patch(IMethodArgs args) async {
    final request = await _makeRequest('get', args);
    final response = await http.patch(
      request.url,
      headers: request.headers,
      body: request.body,
    );
    return Response.fromHttpResponse(response);
  }

  Future<IRequest> _makeRequest<R>(String method, IMethodArgs args) async {
    final resGetBaseUrl = _options.getApiHost();

    final resHeaders = Map<String, String>.from(
        args.headers != null ? args.headers : Map<String, String>())
      ..addAll(_options.headers);

    final body = args.data != null ? jsonEncode(args.data) : '';

    return IRequest(
        body: body, url: resGetBaseUrl + args.url, headers: resHeaders);
  }
}

typedef Future<Map<String, String>> TGetPrivateHeaders();
typedef Future<T> TAsyncFunction<T>();
typedef T TFunction<T>();

class IOptions {
  final Map<String, String> headers;
  final TFunction<String> getApiHost;

  IOptions({this.headers, this.getApiHost});
}

class IResponse {
  final String body;
  final Map<String, String> headers;
  final int status;
  final String statusText;

  IResponse({this.body, this.headers, this.status, this.statusText});
}

class IRequest {
  final Map<String, String> headers;
  final String url;
  final String body;

  IRequest({this.headers, this.body, this.url});
}

class IMethodArgs {
  final String url;
  final Map<String, dynamic> data;
  final Map<String, String> headers;
  final bool isSigned;
  final bool isUseCoreApi;

  IMethodArgs(
      {this.url = '',
      this.data,
      this.headers = const {},
      this.isSigned = false,
      this.isUseCoreApi = false});
}

class Response {
  int statusCode;
  String body;
  Map<String, String> headers;

  Response(
      {@required this.headers, @required this.body, @required this.statusCode});

  Response.fromHttpResponse(http.Response response) {
    headers = response.headers;
    statusCode = response.statusCode;
    body = utf8.decode(response.bodyBytes);
  }
}
