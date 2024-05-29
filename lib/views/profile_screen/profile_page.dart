// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/services/firestore_services.dart';
import 'package:food_delivery/views/auth_screens/sign_in_or_login_screen.dart';
import 'package:food_delivery/views/profile_screen/components/count_info.dart';
import 'package:food_delivery/views/profile_screen/components/info_row.dart';
import 'package:food_delivery/views/profile_screen/orders_screen.dart';

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
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            // storing data
            var data = snapshot.data!.docs[0];

            return SingleChildScrollView(
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
                    // profile picture ===============================================
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
                    // orders, cars, wishlist count ==================================
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          // cart
                          countInfo(
                              title: "My Cart", count: data["cart_count"]),
                          Dimension.widthSize(10).widthBox,
                          // favourites
                          countInfo(
                              title: "My Favourites",
                              count: data["favourite_count"]),
                          Dimension.widthSize(10).widthBox,
                          // orders
                          countInfo(
                                  title: "My Orders",
                                  count: data["orders_count"])
                              .onTap(() {
                            Get.to(() => const OrdersScreen());
                          }),
                        ],
                      )
                          .box
                          .margin(
                            EdgeInsets.symmetric(
                              horizontal: Dimension.widthSize(15),
                            ),
                          )
                          .make(),
                    ),
                    Dimension.heightSize(10).heightBox,
                    // profile information ===========================================
                    // name
                    infoRow(
                      icon: Icons.person,
                      iconColor: AppColors.whiteColor,
                      iconBackgroundColor: AppColors.mainColor,
                      textColor: data["name"] == ""
                          ? Colors.red
                          : AppColors.mainBlackColor,
                      text: data["name"] == "" ? "Not added yet" : data["name"],
                    ),
                    // phone number
                    infoRow(
                      icon: Icons.phone,
                      iconColor: AppColors.whiteColor,
                      iconBackgroundColor: AppColors.iconColor1,
                      textColor: data["phoneNumber"] == ""
                          ? Colors.red
                          : AppColors.mainBlackColor,
                      text: data["phoneNumber"] == ""
                          ? "Not added yet"
                          : data["phoneNumber"],
                      isPhone: true,
                      isPhoneVerified: data["phone_verified"],
                    ),
                    // email
                    infoRow(
                      icon: Icons.email,
                      iconColor: AppColors.whiteColor,
                      iconBackgroundColor: AppColors.iconColor1,
                      textColor: data["email"] == ""
                          ? Colors.red
                          : AppColors.mainBlackColor,
                      text:
                          data["email"] == "" ? "Not added yet" : data["email"],
                    ),
                    // address
                    infoRow(
                      icon: Icons.maps_home_work_rounded,
                      iconColor: AppColors.whiteColor,
                      iconBackgroundColor: AppColors.iconColor1,
                      textColor: data["address"] == ""
                          ? Colors.red
                          : AppColors.mainBlackColor,
                      text: data["address"] == ""
                          ? "Not added yet"
                          : data["address"],
                    ),
                    // logout
                    infoRow(
                        icon: Icons.logout,
                        iconColor: AppColors.whiteColor,
                        iconBackgroundColor: AppColors.iconColor2,
                        text: "Logout",
                        onPress: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return loaderDialogbox(
                                text: "Logging out...",
                              );
                            },
                          );
                          await Get.put(AuthController())
                              .signoutMethod(context);
                          Navigator.of(context).pop();
                          Get.offAll(() => const SignInOrLoginScreen());
                        })
                  ],
                ),
              ),
            );
          }
        },
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
