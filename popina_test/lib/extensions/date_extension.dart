extension DateExtension on DateTime {
  String time24Format({String separator = ':'}) {
    return '${this.hour.toString().padLeft(2, '0')}$separator${this.minute.toString().padLeft(2, '0')}';
  }
}
