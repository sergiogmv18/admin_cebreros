import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class RequestHttp {

  static const serverCebreterra = 'cebreterra';
  static const  serverElCieloDeCebreros = 'elCielodeCebreros';
  /*
   * Verify url and return server specific
   * @author SGV
   * @version 20230309 initial release
   * @param <String> server
   */
  getSpecificURL(String server){
    late String url;
    switch(server){
      case serverCebreterra:
        // url = 'http://localhost/projetGit/cebrero/api/api.php';
        url = 'https://cebreterra.com/api/api.php';
      
      break;
      case serverElCieloDeCebreros:
         // url = 'http://localhost/projetGit/cebrero/api/api.php';
        url = 'https://cielodecebreros.com/api/api.php';
      break;

     
    }
     return url;
  }
  

  /*
   * http post encrypted
   * @author SGV
   * @version 20230309 initial release
   * @param <String> action
   * @param <Map<String, dynamic>> parameters
   * @return Map<String, dynamic>
   */
  Future<Map<String, dynamic>> httpPost({Map<String, dynamic>? parameters, int maxLimitInSeconds = 30, required String server,}) async {
    Map<String, dynamic> result = {};
    late String url;
    url = getSpecificURL(server);
    result = await _httpPost(url: url, parameters: parameters, maxLimitInSeconds: maxLimitInSeconds);
    return result;
  }

  /*
   * http post
   * @author SGV
   * @version 20230309 initial release
   * @param <String> url
   * @param <Map<String, dynamic>> parameters
   * @return Map<String, dynamic>
   */
  Future _httpPost({required String url, Map<String, dynamic>? parameters, int maxLimitInSeconds = 30}) async {
    Map<String, dynamic> result;
    Map<String, dynamic>? body = parameters;
    result = {
      'success': false,
      'error': 303,
    };
    try {
      var response = await http.post(Uri.parse(url), body: body, headers: {}).timeout(Duration(seconds: maxLimitInSeconds));
    //  FunctionsClass.printDebug(response.body);
      Map<String, dynamic> verifyResponse = {};
      if (response.statusCode == 200) {
        verifyResponse = json.decode(response.body);
        if (verifyResponse['statusCode'] != null) {
          result = {
            'success': false,
            'error': verifyResponse['statusCode'],
          };
        } else {
          result = verifyResponse;
        } 
      } else {
        if (verifyResponse['statusCode'] != null) {
          result = {
            'success': false,
            'error': verifyResponse['statusCode'],
            'payload': verifyResponse = json.decode(response.body),
          };
        } else {
          result = {
            'success': false,
            'error': response.statusCode,
            'payload': verifyResponse = json.decode(response.body),
          };
        }
      }
    } catch (e) {
      log(e.toString());
      if (e is SocketException) {
        result = {
          'success': false,
          'error': 104,
        };
      //  FunctionsClass.printRequest(url: url, statusCode: 104, body: 'Socket exception: ${e.toString()}', error: "SocketException");
      } else if (e is TimeoutException) {
        result = {
          'success': false,
          'error': 408,
        };
       // FunctionsClass.printRequest(url: url, statusCode: 408, body: 'Timeout exception: ${e.toString()}', error: "TimeoutException");
      } else {
        result = {
          'success': false,
          'error': 303,
        };
      //  FunctionsClass.printRequest(url: url, statusCode: 303, body: 'Unhandled exception: ${e.toString()}', error: "undifined");
      }
    }
    //FunctionsClass.printDebug(result);
    return result;
  }
}