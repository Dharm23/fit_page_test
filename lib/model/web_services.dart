import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

const baseURL = "https://mobile-app-challenge.herokuapp.com";
const apiData = "$baseURL/data";

class WS {
  static Future<WSResponse> getAPICall({
    required String url,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );

      return WSResponse().responseToWS(response);
    } catch (e) {
      debugPrint(e.toString());
      return WSResponse().responseToWS(null);
    }
  }

  static Future<bool> checkInternet() async {
    if (kIsWeb) {
      return true;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}

class WSResponse {
  late String body;
  late String msg;
  late bool success;
  late int statusCode;

  WSResponse responseToWS(http.Response? response) {
    if (response == null) {
      success = false;
      body = "";
      msg = "Something went wrong please try again after sometime";
      statusCode = 00;
    } else {
      success = (response.statusCode == 200 || response.statusCode == 201);
      body = response.body;
      msg = response.body;
      statusCode = response.statusCode;
    }
    return this;
  }
}
