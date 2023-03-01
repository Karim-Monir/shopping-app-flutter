import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-type' : 'application/json',
          'lang' : 'en'
        }
      ),
    );
  }

  static Future<Response?> getData
      ({
    required String path,
    required Map<String, dynamic> queryParameters,
    String lang = 'ar',
    String? token,
  }) async {

    dio?.options.headers =
      {
        'lang' : lang,
        'Authorization' : token,
      };

    return await dio?.get(
      path,
      queryParameters: queryParameters,
    );
  }



  static Future<Response?> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
}) async
{

  dio?.options.headers = {
    'lang' : lang,
    'Authorization' : token,
  };
  return dio!.post(
    path,
    queryParameters: queryParameters,
    data: data
  );
}
}
