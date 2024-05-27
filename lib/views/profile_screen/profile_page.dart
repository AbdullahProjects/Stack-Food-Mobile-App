import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/profile_screen/components/info_row.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "My Profile",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: Dimension.heightSize(20),
            bottom: Dimension.heightSize(50),
          ),
          child: Column(
            children: [
              Dimension.heightSize(10).heightBox,
              // profile picture ===================================================
              Icon(
                Icons.person,
                size: Dimension.widthSize(50),
                color: AppColors.whiteColor,
              )
                  .box
                  .color(AppColors.mainColor)
                  .size(Dimension.widthSize(90), Dimension.heightSize(90))
                  .roundedFull
                  .make(),
              Dimension.heightSize(20).heightBox,
              // profile information ===============================================
              // name
              infoRow(
                icon: Icons.person,
                iconColor: AppColors.whiteColor,
                iconBackgroundColor: AppColors.mainColor,
                text: "Ahmad",
              ),
              // phone number
              infoRow(
                icon: Icons.phone,
                iconColor: AppColors.whiteColor,
                iconBackgroundColor: AppColors.iconColor1,
                text: "03064090012",
              ),
              // email
              infoRow(
                icon: Icons.email,
                iconColor: AppColors.whiteColor,
                iconBackgroundColor: AppColors.iconColor1,
                text: "ahmad@gmail.com",
              ),
              // address
              infoRow(
                icon: Icons.maps_home_work_rounded,
                iconColor: AppColors.whiteColor,
                iconBackgroundColor: AppColors.iconColor1,
                text: "Faisal Park, Lahore",
              ),
              // logout
              infoRow(
                icon: Icons.logout,
                iconColor: AppColors.whiteColor,
                iconBackgroundColor: AppColors.iconColor2,
                text: "Logout",
              )
            ],
          ),
        ),
      ),
      // floating action button; of edit profile and setting ===================
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animationDuration: const Duration(milliseconds: 400),
        foregroundColor: AppColors.whiteColor,
        buttonSize: Size(Dimension.widthSize(50), Dimension.heightSize(48)),
        spacing: 15,
        backgroundColor: AppColors.mainColor,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.edit,
              color: AppColors.blackColor,
              size: Dimension.widthSize(20),
            ),
            backgroundColor: AppColors.iconColor1,
            label: 'Edit Personal Info',
            labelStyle: TextStyle(
                fontSize: Dimension.widthSize(14), color: AppColors.blackColor),
            labelBackgroundColor: AppColors.iconColor1,
            onTap: () {
              showToast(
                context: context,
                msg: "Edit Profile Info",
              );
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: Dimension.widthSize(20),
            ),
            backgroundColor: AppColors.iconColor2,
            label: 'Settings',
            labelStyle: TextStyle(
                fontSize: Dimension.widthSize(14), color: Colors.white),
            labelBackgroundColor: AppColors.iconColor2,
            onTap: () {
              showToast(
                context: context,
                msg: "Settings",
              );
            },
          ),
        ],
      ),
    );
  }
}
