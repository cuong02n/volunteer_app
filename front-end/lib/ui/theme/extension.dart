part of 'theme.dart';

/// Extension giúp rút gọn code cho việc truy xuất các thuộc tính trong Theme
extension GetThemeData on BuildContext {
  ThemeData get appTheme => Theme.of(this);
}