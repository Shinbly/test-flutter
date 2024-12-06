extension DateExtension on DateTime {
  String time24Format({String separator = ':'}) {
    return '${hour.toString().padLeft(2, '0')}$separator${minute.toString().padLeft(2, '0')}';
  }
}
