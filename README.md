# MPFlutter Practice – Load Mini App MPK vào Host App

## Cấu trúc thư mục

```
mpflutter_practice/
├── host_app/                # Host app Flutter 
├── mini_app_practice/       # Mini app Flutter module (dùng mpflutter)
├── mpflutter/               # Source mpflutter và các package liên quan
└── README.md
```

## Yêu cầu môi trường
- **Flutter:** 3.7.12 (dùng FVM)
- **Dart:** 2.19.6

---

## 1. Tạo project

### Tạo Host App
```sh
fvm flutter create host_app
```

### Tạo Mini App (module)
```sh
fvm flutter create --template=module mini_app_practice
```

---

## 2. Build & tích hợp Mini App

### Build file mpk cho mini app
```sh
cd mini_app_practice
sh ./build.sh
```
- Sau khi build, file `app.mpk` sẽ nằm ở: `mini_app_practice/assets/build/app.mpk`

### **Cách sử dụng file mpk**
#### **A. Dùng file local (cũ)**
- Copy file `mini_app_practice/assets/build/app.mpk` vào `host_app/assets/build/app.mpk`
- Thêm asset vào `pubspec.yaml` của host app:
  ```yaml
  flutter:
    assets:
      - assets/build/app.mpk
  ```

#### **B. Dùng file online (khuyên dùng)**
- Upload file `.mpk` lên server (ví dụ: GitHub Releases, Firebase Storage, S3, v.v.)
- Lấy link download trực tiếp, ví dụ:  
  `https://github.com/<user>/<repo>/releases/download/<tag>/app.mpk`
- Trong code, truyền link này vào `AppInfo` thay vì asset local.

---

## 3. Khởi tạo & quản lý Multi Mini App (Multi App Init)

Bạn có thể tích hợp nhiều mini app (.mpk) vào host app và cho phép người dùng chọn app để chạy.

### **A. Thêm nhiều file mpk**
- Nếu dùng local: copy nhiều file `.mpk` vào thư mục `assets/build/` và khai báo trong `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - assets/build/app1.mpk
      - assets/build/app2.mpk
  ```
- Nếu dùng online: upload nhiều file `.mpk` lên server, mỗi file một link riêng.

### **B. Cấu hình danh sách AppInfo**
- Trong code, tạo danh sách các app:
  ```dart
  List<AppInfo> mockListApp() => [
    AppInfo(
      id: '1',
      name: 'Mini App 1',
      description: 'Mô tả app 1',
      mpkUrl: 'https://github.com/<user>/<repo>/releases/download/<tag>/app1.mpk',
      icon: '',
    ),
    AppInfo(
      id: '2',
      name: 'Mini App 2',
      description: 'Mô tả app 2',
      mpkUrl: 'https://github.com/<user>/<repo>/releases/download/<tag>/app2.mpk',
      icon: '',
    ),
    // Thêm app khác nếu muốn
  ];
  ```

### **C. Chọn app để load**
- UI sẽ hiển thị danh sách app (dạng grid/list). Khi người dùng chọn app nào, truyền `AppInfo` tương ứng vào màn hình mini app:
  ```dart
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => MiniAppPage(
        appInfo: selectedApp,
        data: ..., // dữ liệu truyền vào nếu có
      ),
    ),
  );
  ```
- Trong `MiniAppPage`, lấy đúng link/file `.mpk` từ `appInfo` để load app tương ứng.

---

## 4. Truyền nhận dữ liệu 2 chiều

- **Host app:**  
  - Quản lý channel qua `ChannelManager`:
    ```dart
    ChannelManager.registerAllChannels();
    ```
  - Đăng ký channel truyền nhận data qua:
    ```dart
    MPPluginRegister.registerChannel(
      <channel_name>,
      () => <MethodChannel() class>,
    );
    ```
  - Xử lý nhận message từ mini app qua: `onMethodCall<method_name>` của MethodChannel.

- **Mini app:**  
  - Truyền nhận data ra host app qua `invokeMethod`:
    ```dart
    final result = await _channelListenData.invokeMethod('get_data');
    ```

---

## 5. Cài đặt dependencies
```sh
cd host_app
fvm flutter clean
fvm flutter pub get
```

---

## 6. Chạy Host App
```sh
fvm flutter run -d <device_id>
```

---

## 7. UI & Code Style
- UI grid hiện đại, đẹp, dễ mở rộng (tham khảo trong source code).
- Tách riêng các class quản lý channel, download, model, widget.
- Không để logic channel trong UI.
- Dễ dàng mở rộng thêm mini app mới chỉ bằng cách thêm vào danh sách AppInfo.

---

## 8. Tham khảo
- mpflutter, mpcore, mpflutter_runtime: https://gitee.com/mpflutter
- Template plugin: https://github.com/mpflutter/mpflutter_plugin_template
- mpflutter: https://github.com/mpflutter/mpflutter

---

**Lưu ý:**
- Host app dùng Flutter như bình thường, thêm lib `mp_flutter_runtime` để render UI mini app, truyền nhận dữ liệu giữa host và mini.
- Mini app dùng mpflutter, thêm lib `mpcore` và `mpflutter_plugin_template` để xây dựng UI abstract.
- Có thể dùng nhiều file `.mpk` khác nhau, local hoặc online đều được.