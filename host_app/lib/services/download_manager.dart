import 'dart:typed_data';
import 'package:http/http.dart' as http;


class DownloadManager {

  static Future<Uint8List> downloadFile(String url) async {
    print("dzoooo 1: $url");
    final response = await http.get(Uri.parse(url));

    print("dzooooooo");
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download file: HTTP ${response.statusCode}');
    }
  }
} 