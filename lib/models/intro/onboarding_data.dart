import 'package:app_base_flutter/configs/global_images.dart';

class OnBoarding {
  String title;
  String subtitle;
  String image;

  OnBoarding({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Đặt Phòng Họp Nhanh Chóng',
    subtitle: 'Chỉ với vài bước đơn giản, bạn có thể đặt lịch phòng họp tiện lợi và nhanh chóng.',
    image: GlobalImages.intro1,
  ),
  OnBoarding(
    title: 'Quản Lý Lịch Họp Dễ Dàng',
    subtitle: 'Xem và quản lý chi tiết các cuộc họp đã đặt chỉ trong vài giây.',
    image: GlobalImages.intro2,
  ),
  OnBoarding(
    title: 'Tối Ưu Sử Dụng Phòng Họp',
    subtitle: 'Nhận gợi ý và tối ưu thời gian sử dụng phòng họp để tránh trùng lặp và đạt hiệu quả cao nhất.',
    image: GlobalImages.intro3,
  ),
];

