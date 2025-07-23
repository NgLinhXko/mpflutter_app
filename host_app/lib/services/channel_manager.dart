import 'package:mp_flutter_runtime/mp_flutter_runtime.dart';
import 'package:host_app/services/method_channel_manager.dart';

/// ChannelManager: Quản lý đăng ký các method channel cho app
class ChannelManager {
  /// Đăng ký tất cả các channel cần thiết
  static void registerChannel() {
    MPPluginRegister.registerChannel(
      "access_token_process/mp",
      () => AccessTokenMethodChannel(),
    );
    MPPluginRegister.registerChannel(
      "listen_data_process/mp",
      () => ListenDataMethodChannel(),
    );
  }
}
