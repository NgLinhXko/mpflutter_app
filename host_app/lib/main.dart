import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:host_app/services/method_channel_manager.dart';
import 'package:host_app/widget/mini_app_page.dart';
import 'package:mp_flutter_runtime/mp_flutter_runtime.dart';

import 'models/app_info.dart';

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

class AppGridScreen extends StatefulWidget {
  const AppGridScreen({super.key});

  @override
  State<AppGridScreen> createState() => _AppGridScreenState();
}

class _AppGridScreenState extends State<AppGridScreen> {
  final TextEditingController _controller = TextEditingController();

  List<AppInfo> get _apps => mockListApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter data to send to mini app',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: _buildGrid()),
        ],
      )
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
              counterData = -2;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MiniAppPage(
                    appInfo: _apps[index],
                    data: _controller.text,
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


