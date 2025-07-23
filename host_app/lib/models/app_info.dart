class AppInfo {
  final String id;
  final String mpkAssetFile;
  final String mpkUrl;
  final String name;
  final String icon;
  final String description;
  final AppType appType;

  AppInfo({
    required this.id,
    required this.mpkAssetFile,
    required this.mpkUrl,
    required this.name,
    required this.icon,
    required this.description,
    this.appType = AppType.asset,
  });
}

List<AppInfo> mockListApp() {
  List<AppInfo> mockListApp = [
    AppInfo(
      id: '1',
      mpkAssetFile: 'assets/build/app.mpk',
      mpkUrl: 'https://github.com/NgLinhXko/mpflutter_app/releases/download/v1.0.1/app.mpk',
      name: 'Mini App 1',
      icon: '',
      description: 'Mô tả app 1',
      appType: AppType.url,
    ),
    AppInfo(
      id: '2',
      mpkAssetFile: 'assets/build/app2.mpk',
      mpkUrl: 'https://github.com/NgLinhXko/mpflutter_app/releases/download/v1.0.1/app2.mpk',
      name: 'Mini App 2', 
      icon: '',
      description: 'Mô tả app 2',
      appType: AppType.url,
    ),
    // Thêm app khác nếu muốn
  ];

  return mockListApp;
}

enum AppType {
  asset,
  url,
}
