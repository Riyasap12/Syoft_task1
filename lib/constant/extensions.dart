import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension SizedBoxExt on num {
  Widget get sbh => SizedBox(height: this.h);
  Widget get sbw => SizedBox(width: this.h);
}
