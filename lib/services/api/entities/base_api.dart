import 'dart:convert';

import '../errors/errors.dart';
import '../http_actions.dart';

class BaseApi {
  void throwExceptionIfInvalidStatusCode(Response response) {
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ApiError(
        statusCode: response.statusCode,
        message: response.body,
      );
    }

    if (response.statusCode >= 500) {
      throw ApiError(
        statusCode: response.statusCode,
        message: 'Server is not responding! Please try again later',
      );
    }
  }

  bool isResultsFieldIsUndefinedOrNotMap(Response response) {
    Map body = jsonDecode(response.body);
    return body['results'] == null || !(body['results'] is Map);
  }
}
