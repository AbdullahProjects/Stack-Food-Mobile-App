import 'package:food_delivery/consts/consts.dart';

Widget inputField(
    {hintText,
    prefixIcon,
    prefixIconColor = AppColors.mainColor,
    controller,
    isSecure = false,
    keyboard = TextInputType.text}) {
  return Container(
    margin: EdgeInsets.symmetric(
      // horizontal: Dimension.widthSize(20),
      vertical: Dimension.heightSize(6),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: Dimension.widthSize(25),
    ),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimension.widthSize(40),
        ),
      ),
      boxShadow: const [
        BoxShadow(
          color: AppColors.textColor,
          offset: Offset(2, 2),
          blurRadius: 5,
        ),
        BoxShadow(
          color: AppColors.textColor,
          offset: Offset(-2, -2),
          blurRadius: 5,
        )
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: isSecure,
      keyboardType: keyboard,
      autofocus: false,
      cursorColor: AppColors.mainColor,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: Dimension.heightSize(15),
        ),
      ),
    ),
  );
}
