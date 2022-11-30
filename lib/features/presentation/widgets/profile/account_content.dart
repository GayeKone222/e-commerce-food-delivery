import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountContent extends StatelessWidget {
  const AccountContent({Key? key, required this.bigtext, required this.appIcon})
      : super(key: key);

  final Bigtext bigtext;
  final AppIcon appIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
      child: Row(
        children: [appIcon,SizedBox(width: 20.w,), bigtext],
      ),
    );
  }
}
