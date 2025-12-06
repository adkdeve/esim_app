abstract class BaseApiServices {
  Future<dynamic> postApiResponse(dynamic data, String url);
  Future<dynamic> postApiResponseWithHeader(dynamic data, String url);
  Future<dynamic> postApiResponseWithToken(dynamic data, String url,String token);
  Future<dynamic> getApiResponseWithToken(String url,String token);
  //========== Update Profile  ==============
  Future<dynamic> postApiResponseProfile(dynamic data, String url,String token);
}
