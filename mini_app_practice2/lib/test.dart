// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:mpcore/channel/channel_io.dart';
// import 'package:mpcore/mpcore.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   MPCore().connectToHostChannel(
//     body: () {
//       runApp(const MyApp());
//     },
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MPApp(
//       title: 'Counter Mini App',
//       color: Colors.blue,
//       routes: {
//         '/': (context) => const MyHomePage(),
//       },
//       navigatorObservers: [MPCore.getNavigationObserver()],
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   String? data1;
//   String? data2;

//   @override
//   void initState() {
//     super.initState();
//     _incrementCounter();
//   }

//   void _incrementCounter() async {
//     DataManager.getInstance.refreshTokenExpired();
//     var res = await DataManager.getInstance.listenData();
//     data1 = res['data1'];
//     data2 = res['data2'];
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MPScaffold(
//       name: 'Mini app 2',
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Text(
//                   'Đây là mini app 2',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Data from host app: $data1 - $data2',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             child: GestureDetector(
//               onTap: _incrementCounter,
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'Click to call method channel get data from host app',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// abstract class AccessTokenManager {
//   static AccessTokenManager getFileManager() {
//     return MpAccessTokenManager();
//   }

//   Future<dynamic> getAccessToken();
//   Future<dynamic> listenData();
// }

// class MpAccessTokenManager extends AccessTokenManager {
//   final _channel = MethodChannel('access_token_process/mp');
//   final _channelListenData = MethodChannel('listen_data_process/mp');

//   @override
//   Future<dynamic> getAccessToken() async {
//     final result = _channel.invokeMethod('get_access_token');
//     return result;
//   }

//   @override
//   Future listenData() async {
//     final result = _channelListenData.invokeMethod('get_data');
//     return result;
//   }
// }

// class DataManager {
//   static final DataManager _instance = DataManager._internal();

//   DataManager._internal();

//   static DataManager get getInstance => _instance;

//   String? accessToken;
//   String? refreshToken;

//   Future<void> refreshTokenExpired() async {
//     // Callback gọi sang MyMB để lấy lại token
//     try {
//       var accessTokenProcess = MpAccessTokenManager();
//       var res = await accessTokenProcess.getAccessToken();
//       var value = json.decode(res) as Map;
//       accessToken = value['accessToken'];
//       refreshToken = value['refreshToken'];
//       print(
//           "accessToken refreshTokenExpired:1212  ======================== accesstoken: $accessToken -====== refreshToken: $refreshToken");
//       // verifyToken(token: accessToken!);
//     } catch (e) {
//       print(
//           "accessToken refreshTokenExpired:1212  ========================EXCEPTION error: $e");
//       throw Exception(e);
//     }
//   }

// Future<Map<String, dynamic>> listenData() async {
//   var listenDataProcess = MpAccessTokenManager();
//   var res = await listenDataProcess.listenData();
//   final value = json.decode(res) as Map<String, dynamic>;
 
//   print(
//       "listenData:1212  ======================== data1: ${value['data1']} -====== data2: ${value['data2']}");
//   return value;
// }
// }
