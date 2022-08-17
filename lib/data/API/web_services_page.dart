// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_application_1/Constants/Strings.dart';

class WebServices {

  late Dio dio;
WebServices(){
  BaseOptions options =BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    receiveTimeout: 20 *1000,
    connectTimeout: 20*1000,
  );

  dio = Dio(options);

}
  
  Future<List<dynamic>> getAllCracters() async{

    try {
      Response response = await dio.get('characters');
  // print(response.data.toString());
  return response.data;
} on Exception catch (e) {
  print(e);
  return [];
  // TODO
}

  }

   
  Future<List<dynamic>> getCharacterQuote(charName) async{

    try {
      Response response = await dio.get('quote/random?' , queryParameters: {'author':charName});
  // print(response.data.toString());


  return response.data;
} on Exception catch (e) {
  print(e);
  return [];
  // TODO
}

  }



}
