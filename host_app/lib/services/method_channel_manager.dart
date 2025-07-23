import 'dart:convert';

import 'package:mp_flutter_runtime/mp_flutter_runtime.dart';

/// Các method channel constant cho ListenDataMethodChannel
class MethodChannelListen {
  static const String getData = 'get_data';
  static const String getDataSecond = 'get_data_second';
}

/// Quản lý state cho ListenDataMethodChannel
String data = '';
int counterData = 0;


class ListenDataMethodChannel extends MPMethodChannel {
  ListenDataMethodChannel() : super('listen_data_process/mp');

  @override
  Future? onMethodCall(String method, params) async {
    if (method == MethodChannelListen.getData) {
      counterData++;
      final data1 = ' ${data} == ${counterData}';
      final data2 = ' ${data} ==${counterData}';
      final number = int.parse(data) + counterData;
      print("data1 from host app: $data1");
      print("data2 from host app: $data2");
      return json.encode({'data1': data1, 'data2': data2, 'number': number});
    } 
    return super.onMethodCall(method, params);
  }
}


var _counter = 0;

class AccessTokenMethodChannel extends MPMethodChannel {
  AccessTokenMethodChannel() : super('access_token_process/mp');

  @override
  Future? onMethodCall(String method, params) async {
    if (method == 'get_access_token') {
      _counter++;
      final accessToken = '123 $_counter';
      final refreshToken = '456 $_counter';
      return json.encode({'accessToken': accessToken, 'refreshToken': refreshToken});
    }
    return super.onMethodCall(method, params);
  }
}
