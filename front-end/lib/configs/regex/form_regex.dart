abstract class FormRegExp {
  static RegExp email = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp password = RegExp(r'^\S{6,100}$');
}