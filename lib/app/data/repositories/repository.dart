import 'package:pcom_app/app/data/network/network_api_service.dart';

class Repository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<dynamic> postApi(dynamic data, String url) async {
    try {
      dynamic response = await _apiServices.postApiResponse(data, url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postApiWithToken(data, String url, String token) async {
    try {
      dynamic response =
          await _apiServices.postApiResponseWithToken(data, url, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getApiWithToken(url, token) async {
    try {
      dynamic response = await _apiServices.getApiResponseWithToken(url, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<dynamic> postProfile(data, url, token) async {
    try {
      dynamic response =
          await _apiServices.postApiResponseProfile(data, url, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
