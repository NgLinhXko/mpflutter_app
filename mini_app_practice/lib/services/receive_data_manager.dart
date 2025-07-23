import 'package:flutter/services.dart';

abstract class ReceiveDataManager {
  static ReceiveDataManager getFileManager() {
    return MpReceiveDataManager();
  }

  Future<dynamic> getAccessToken();
  Future<dynamic> listenData();
}

class MpReceiveDataManager extends ReceiveDataManager {
  final _channel = MethodChannel('access_token_process/mp');
  final _channelListenData = MethodChannel('listen_data_process/mp');

  @override
  Future<dynamic> getAccessToken() async {
    final result = _channel.invokeMethod('get_access_token');
    return result;
  }

  @override
  Future listenData() async {
    final result = _channelListenData.invokeMethod('get_data');
    return result;
  }
}