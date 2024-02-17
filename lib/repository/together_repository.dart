import '../data/models/api_data_model.dart';

import '../data/api_client.dart';

import 'models/together_repository_model.dart';

class TogetherRepository {
  Future<TogetherRepositoryModel> fetchApiClientList(
      int fetchPageNumber) async {
    final ApiClient apiClient = ApiClient();

    try {
      final List<ApiDataModel> locationResponse =
          await apiClient.fetchApiData(fetchPageNumber);

      return TogetherRepositoryModel(
        apiRepositoryListItem: locationResponse,
      );
    } catch (error) {
      print('######### ERROR in TogetherRepositoryModel  ##########');
      print('######### $apiClient ######### ');
      throw Exception();
    }
  }
}
