# MPFlutter Practice Load file MPK minapp vào host app

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

## 1. Tạo project

### Tạo Host App
```sh
fvm flutter create host_app
```

### Tạo Mini App (module)
```sh
fvm flutter create --template=module mini_app_practice
```

## 2. Build & tích hợp Mini App

### Build file mpk cho mini app
```sh
cd mini_app_practice
sh ./build.sh
```
- Sau khi build, file `app.mpk` sẽ nằm ở: `mini_app_practice/assets/build/app.mpk`

### Copy file mpk sang host app
- Copy file `mini_app_practice/assets/build/app.mpk` vào `host_app/assets/build/app.mpk`

### Thêm asset vào pubspec.yaml của host app
```yaml
flutter:
  assets:
    - assets/build/app.mpk
```

### Cài đặt lại dependencies
```sh
cd host_app
fvm flutter clean
fvm flutter pub get
```

## 3. Chạy Host App
```sh
fvm flutter run -d <device_id>
```

## 4. Tham khảo
- mpflutter , mpcore, mpflutter_runtime: https://gitee.com/mpflutter
- Template plugin: https://github.com/mpflutter/mpflutter_plugin_template
- mpflutter: https://github.com/mpflutter/mpflutter

---
**Lưu ý:**
- Host app dùng Flutter như bình thường, thêm lib `mp_flutter_runtime` để render UI mini app, truyền nhận dữ liệu giữa host và mini.
- Mini app dùng mpflutter, thêm lib `mpcore` và `mpflutter_plugin_template` để xây dựng UI abstract.