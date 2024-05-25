

import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimension.screenHeight / 5;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt());
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimension.heightSize(5), bottom: Dimension.heightSize(15)),
      // color: Colors.blue,
      child: secondHalf
              .isEmpty // if second half is empty, means text is small, no need to show 'show more' button
          ? regularText(text: firstHalf, color: AppColors.paraColor)
          // if second half is not empty, then need to use Column for showing both text and 'show more' button
          : Column(
              children: [
                // now here, if hiddenText will True, then show only firstHalf and 'show more' button
                // else if hiddenText will False, then shown both first and second Half and 'show less' button
                regularText(
                    text: hiddenText
                        ? ("$firstHalf...")
                        : ("$firstHalf$secondHalf"),
                    color: AppColors.paraColor),
                Dimension.heightSize(8).heightBox,
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      // if hiddenText is true, then return show more else show less text widget
                      mediumText(
                          text: hiddenText ? "Show more" : "Show less",
                          color: AppColors.mainColor),
                      Dimension.widthSize(5).widthBox,
                      // if hiddenText is true, then return down arrow else show upward arrow
                      Icon(
                        hiddenText ? Icons.expand_more : Icons.expand_less,
                        color: AppColors.mainColor,
                        size: Dimension.widthSize(20),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
