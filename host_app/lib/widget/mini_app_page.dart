import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp_flutter_runtime/mp_flutter_runtime.dart';

import '../services/download_manager.dart';
import '../main.dart';
import '../models/app_info.dart';
import '../services/channel_manager.dart';
import '../services/method_channel_manager.dart';

class MiniAppPage extends StatefulWidget {
  const MiniAppPage({super.key, required this.appInfo, required this.data});

  final AppInfo appInfo;
  final String data;

  @override
  State<MiniAppPage> createState() => _MiniAppPageState();
}

class _MiniAppPageState extends State<MiniAppPage> {
  Uint8List? mpkData;

  @override
  void initState() {
    super.initState();
    _loadFile();
    data = widget.data;
    ChannelManager.registerChannel();
  }

  void _loadFile() {
    if (widget.appInfo.appType == AppType.asset) {
      _loadMpkFile();
    } else {
      _loadMpkFileFromServer();
    }
  }

  Future<void> _loadMpkFile() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Delay để test loading
      final bytes = await rootBundle.load(widget.appInfo.mpkAssetFile);
      setState(() {
        mpkData = bytes.buffer.asUint8List();
      });
    } catch (e) {
      print('Error loading MPK file: $e');
    }
  }

    Future<void> _loadMpkFileFromServer() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Delay để test loading
      final bytes = await DownloadManager.downloadFile(widget.appInfo.mpkUrl);
      setState(() {
        mpkData = bytes.buffer.asUint8List();
      });
    } catch (e) {
      print('Error loading MPK file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mpkData == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading MPK file...'),
                ],
              ),
            )
          : MPMiniPageDebug(
              packageId: widget.appInfo.name,
              dev: false,
              mpk: mpkData,
              initParams: {
                'accessToken': widget.data,
                'refreshToken': '',
                'data': widget.data,
              },
              splash: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading mini app...'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}