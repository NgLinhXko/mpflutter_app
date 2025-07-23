import 'dart:convert';

import 'package:mini_app_practice2/services/data_repository.dart';
import 'package:mpcore/channel/channel_io.dart';
import 'package:mpcore/mpcore.dart';
import 'package:flutter/widgets.dart';

void main() {
  MPCore().connectToHostChannel(
    body: () {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MPApp(
      title: 'Counter Mini App',
      color: Colors.blue,
      routes: {
        '/': (context) => const MyHomePage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? data1;
  String? data2;
  int? number;

  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  void _incrementCounter() async {
    await DataRepository.getInstance.refreshTokenExpired();
    var res = await DataRepository.getInstance.listenData();
    setState(() {
      data1 = res['data1'];
      data2 = res['data2'];
      number = res['number'];
      print("number: $number");
      _counter = number ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: 'Mini app 2',
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          GestureDetector(
            onTap: _incrementCounter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '🔄 Get data from host app',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _counter,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item $index',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Data from host app:',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${data1 ?? ''} - ${data2 ?? ''}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
