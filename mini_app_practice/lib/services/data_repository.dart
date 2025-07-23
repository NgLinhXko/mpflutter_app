import 'dart:convert';

import 'package:mini_app_practice/services/receive_data_manager.dart';

class DataRepository {
  static final DataRepository _instance = DataRepository._internal();

  DataRepository._internal();

  static DataRepository get getInstance => _instance;

  String? accessToken;
  String? refreshToken;

  Future<void> refreshTokenExpired() async {
    // Callback gọi sang hostapp để lấy data
    try {
      var accessTokenProcess = MpReceiveDataManager();
      var res = await accessTokenProcess.getAccessToken();
      var value = json.decode(res) as Map;
      accessToken = value['accessToken'];
      refreshToken = value['refreshToken'];
      print(
          "accessToken refreshTokenExpired:1212  ======================== accesstoken: $accessToken -====== refreshToken: $refreshToken");
      // verifyToken(token: accessToken!);
    } catch (e) {
      print(
          "accessToken refreshTokenExpired:1212  ========================EXCEPTION error: $e");
      throw Exception(e);
    }
  }

Future<Map<String, dynamic>> listenData() async {
  var listenDataProcess = MpReceiveDataManager();
  var res = await listenDataProcess.listenData();
  final value = json.decode(res) as Map<String, dynamic>;
 
  print(
      "listenData:1212  ======================== data1: ${value['data1']} -====== data2: ${value['data2']}");
  return value;
}
}