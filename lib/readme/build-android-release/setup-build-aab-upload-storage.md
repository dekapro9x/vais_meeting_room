Để build file `.aab` (Android App Bundle) cho ứng dụng Flutter ở chế độ release, bạn có thể thực hiện các bước sau:

1. **Chuyển sang channel stable (nếu chưa làm):**
   Mở terminal hoặc command prompt, di chuyển đến thư mục dự án Flutter của bạn, và kiểm tra xem bạn có đang ở channel stable hay không. Nếu không, bạn có thể chuyển bằng lệnh sau:

   flutter channel stable
   flutter upgrade

2. **Clean dự án (tuỳ chọn):**
   Để đảm bảo rằng không có file tạm thời nào gây ảnh hưởng đến build, bạn có thể clean dự án trước khi build:

   flutter clean

3. **Build `.aab` ở chế độ release:**
   Dùng lệnh sau để build file `.aab`:

   flutter build appbundle --release

   Lệnh này sẽ tạo ra file `.aab` trong thư mục `build/app/outputs/bundle/release/`.

4. **Xác thực file `.aab` (tuỳ chọn):**
   Sau khi build xong, bạn có thể kiểm tra file `.aab` vừa tạo để đảm bảo rằng nó không có lỗi:

   java -jar bundletool.jar validate --bundle=build/app/outputs/bundle/release/app-release.aab

Sau khi hoàn tất, bạn có thể tải file `.aab` này lên Google Play Console để phát hành ứng dụng của mình.