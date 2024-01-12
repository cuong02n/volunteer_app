# thien_nguyen_app

Ứng dụng quản lý và hỗ trợ hoạt động từ thiện

## Yêu cầu cấu hình

### Phía người dùng: 
Android Lolipop (API 21), iOS không rõ
### Phía dev: 
* Hệ thống đủ cấu hình chạy Android Studio với máy ảo Android
* Máy tính đã cài đặt Flutter v3.10.6 trở lên (recommend v3.16.3)
* Đã cài đặt Swagger UI và máy chủ MySQL

## Hướng dẫn sử dụng cho nhà phát triển
### Phía frontend
0. Clone dự án này bằng cách:
   > git clone https://github.com/cuong02n/volunteer_app.git
1. Mở Android Studio, tại cửa sổ chào mừng, chọn dấu ... dọc ở góc trên bên phải -> Import Project -> Chọn folder ./front-end -> Next (Yes, không cần chỉnh sửa). Khi cửa sổ project mở, đợi một thời gian để Android Studio phát hiện và khởi tạo môi trường phát triển Flutter
2. Trong terminal của android studio hoặc trỏ vào thư mục gốc của front_end, gõ lệnh để tải các package cần thiết
   > flutter pub get
3. Tại góc trên bên phải của Android Studio (UI cũ), chọn thiết bị muốn chạy và bấm nút tam giác màu xanh để chạy, nút con bọ màu xanh để gỡ lỗi và sử dụng.
   
   ![Góc trên bên phải Android Studio](https://lh3.googleusercontent.com/pw/ABLVV87JgXFdjzyJapHZeklILKC_WovNGSO0_WC9e1Ku80yYAwgsP_lJF5k0UTe52E4yuOjKM3gd48_Dw0jrM_rlPrEVFalXhcDT9aeKO6YMmjVft1TuJ-k-6JCeNOJrJk1VgVvqKr40_cpmAEoFH5OyvfYU=w608-h39-s-no-gm)

#### Lưu ý:
Nếu chạy trên web, cần tắt cài đặt bảo mật của Chrome bằng việc chọn vào phần main.dart, sau đó bấm "Edit Configurations...", chỉnh sửa như hình và lưu lại:

![Configurations](https://lh3.googleusercontent.com/pw/ABLVV86J7BpSo4BczHSe7cSkpt6WXphLZjRiy3kGT-0olsBUfMpztXqZ9VMlm6MoAj2KcIObV1FYpbGwn6yiTcjGYOEBuzelIe0edz6sqqjqKjwVlPaIoYzsZwqU3j1UGDHZljb8XFQLM4q6zFD9tvaiCxzF=w1307-h847-s-no-gm)

### Phía backend:
Xem hướng dẫn chi tiết trong file README.md trong folder server.

   
