// import 'dart:convert';

// import '../../../services/i18n/i18n.dart';
// import '../models/city.dart';

// List<City> convertCities(String data) {
//   final results = List<Map<String, dynamic>>.from(jsonDecode(data)['results']);
//   return results.map((cityResponse) {
//     return City(
//       id: cityResponse['id'],
//       name: cityResponse['name'] ?? '',
//       languageCode: ELocales.values.singleWhere(
//           (v) => v.toString() == 'ELocales.${cityResponse['language_code']}'),
//       apiHost: cityResponse['api_host'],
//       telegramBotName: cityResponse['telegram_bot_name'],
//       isActive: cityResponse['is_active'],
//       currencyCode: cityResponse['currency_code'],
//     );
//   }).toList();
// }
