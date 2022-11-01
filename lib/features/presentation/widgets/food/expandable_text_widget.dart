import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textheight = 150.h;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textheight) {
      firstHalf = widget.text.substring(0, textheight.toInt());
      secondHalf =
          widget.text.substring(textheight.toInt() + 1, widget.text.length);
      hiddenText = true;
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      hiddenText = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: textheight,
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                SmallText(
                  text: hiddenText ? "$firstHalf..." : firstHalf + secondHalf,
                  size: 16.h,
                  color: AppColors.textColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: hiddenText ? "show more" : "show less",
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColors.mainColor,
                    )
                  ]),
                )
              ],
            ),
    );
  }
}
