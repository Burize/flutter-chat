import '../http_actions.dart';
import '../models/user.dart' as CityModel;
import './base_api.dart';
// import '../converters/city.dart';

class User extends BaseApi {
  HttpActions _httpActions;
  User(HttpActions httpActions) {
    _httpActions = httpActions;
  }

  Future<List<CityModel.City>> authenticate() async {
    // final response = await _httpActions.get(IMethodArgs(
    //   url: '/cities/',
    //   isUseCoreApi: true,
    // ));

    await Future.delayed(Duration(milliseconds: 1500));

    // throwExceptionIfInvalidStatusCode(response);
    // final cities = convertCities(response.body);
    return null;
  }
}
