import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'models/api_data_model.dart';

// Exceptions
class FetchLocationFailure implements Exception {}

class LocationNotFoundFailure implements Exception {}

// Data Fetch Class
class ApiClient {
  // http client
  final http.Client _httpClient = http.Client();

  // base urls
  static const _baseUrl = 'api-stg.together.buzz';

  Future<List<ApiDataModel>> fetchApiData(int fetchPageNumber) async {
    final Uri locationRequest = Uri.https(
      _baseUrl,
      '/mocks/discovery',
      {
        'page': fetchPageNumber.toString(),
        'limit': '10',
      },
    );
    print('############   FETCHING PAGE $fetchPageNumber   #############\n\n');
    try {
      final Response locationResponse = await _httpClient.get(locationRequest);

      if (locationResponse.statusCode != 200) {
        throw FetchLocationFailure();
      }

      final response = json.decode(locationResponse.body) as Map;
      // print('############   $response   #############\n\n');

      if (!response.containsKey('data')) throw LocationNotFoundFailure();

      final results = response['data'] as List;

      if (results.isEmpty) throw LocationNotFoundFailure();
      // print('################${results.first} ################\n\n\n\n');

      //storing items of list from Api in local List.
      List<ApiDataModel> _apiListItems = [];
      for (var i = 0; i < results.length; i++) {
        _apiListItems.add(
          ApiDataModel.fromMap(
            results[i] as Map<String, dynamic>,
          ),
        );
      }

      return _apiListItems;
    } catch (error) {
      print('############   Error in api client :   #############\n\n');
      print('############   $error   #############\n\n');
      throw FetchLocationFailure();
    }
  }
}
