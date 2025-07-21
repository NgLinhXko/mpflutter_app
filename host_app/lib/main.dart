import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp_flutter_runtime/mp_flutter_runtime.dart';

class AppInfo {
  final String id;
  final String mpkAssetFile;
  final String name;
  final String icon;
  final String description;

  AppInfo({
    required this.id,
    required this.mpkAssetFile,
    required this.name,
    required this.icon,
    required this.description,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini App Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppGridScreen(),
    );
  }
}

class AppGridScreen extends StatelessWidget {
  const AppGridScreen({super.key});

  List<AppInfo> get _apps => [
        AppInfo(
          id: '1',
          mpkAssetFile: 'assets/build/app.mpk',
          name: 'Mini App 1',
          icon: '',
          description: 'Mô tả app 1',
        ),
        AppInfo(
          id: '2',
          mpkAssetFile: 'assets/app2.mpk',
          name: 'Mini App 2',
          icon: '',
          description: 'Mô tả app 2',
        ),
        // Thêm app khác nếu muốn
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: _buildGrid(),
    );
  }

  PreferredSizeWidget _buildHeader() {
    return AppBar(
      title: const Text('Host App Grid'),
      centerTitle: true,
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MiniAppPage(
                    appInfo: _apps[index],
                    data: 'sample_data',
                  ),
                ),
              );
            },
            child: _buildAppCard(_apps[index]),
          );
        },
      ),
    );
  }

  Widget _buildAppCard(AppInfo app) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Icon(Icons.app_registration, size: 30,),
            const SizedBox(height: 12),
            Text(
              app.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              app.description,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

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
    _loadMpkFile();
  }

  Future<void> _loadMpkFile() async {
    try {
      final bytes = await rootBundle.load(widget.appInfo.mpkAssetFile);
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
