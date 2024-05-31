// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/profile_controller.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';
import 'package:food_delivery/views/profile_screen/profile_page.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  final dynamic data;
  const EditProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // initialize profile controller
    var profileController = Get.put(ProfileController());

    // ignore: deprecated_member_use
    return
        // WillPopScope(
        // onWillPop: () async {
        //   Get.delete<ProfileController>();
        //   Get.to(() => const MainPage());
        //   return false;
        // },
        // child:
        Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            // Get.delete<ProfileController>();
            Get.to(() => const MainPage());
          },
        ),
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "Edit Personal Info",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: Dimension.screenWidth,
          padding: EdgeInsets.only(
            top: Dimension.heightSize(30),
            left: Dimension.widthSize(15),
            right: Dimension.widthSize(15),
            bottom: Dimension.heightSize(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // profile picture =================================================
              Obx(
                () => Container(
                  width: Dimension.widthSize(90),
                  height: Dimension.heightSize(90),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      45,
                    ),
                    child: data["imageURL"] == "" &&
                            profileController.profileImgPath.isEmpty
                        ? Icon(
                            Icons.person,
                            size: Dimension.widthSize(50),
                            color: AppColors.whiteColor,
                          )
                        : data["imageURL"] != "" &&
                                profileController.profileImgPath.isEmpty
                            ? Image.network(
                                data["imageURL"],
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(profileController.profileImgPath.value),
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
              ),
              Dimension.heightSize(15).heightBox,
              // change profile picture button ===================================
              elevatedButton(
                text: "Change Picture",
                textColor: AppColors.mainBlackColor,
                bgColor: AppColors.whiteColor,
                textSize: Dimension.widthSize(14),
                onPress: () async {
                  // first, select image source; gallery or camera =============
                  var imgSource = await showDialog<ImageSource>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Column(
                          children: [
                            blackText(
                              text: "Choose Image Source",
                              color: AppColors.mainBlackColor,
                              size: Dimension.widthSize(18),
                            ),
                            Dimension.heightSize(20).heightBox,
                            regularText(
                              text:
                                  "Whether your want to open camera or select from gallery?",
                              color: AppColors.mainBlackColor,
                              size: Dimension.widthSize(16),
                            ),
                            Dimension.heightSize(20).heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                elevatedButton(
                                  text: "Open Camera",
                                  textColor: AppColors.mainBlackColor,
                                  bgColor: AppColors.whiteColor,
                                  textSize: Dimension.widthSize(15),
                                  onPress: () {
                                    Navigator.of(context)
                                        .pop(ImageSource.camera);
                                  },
                                ),
                                Dimension.widthSize(5).widthBox,
                                elevatedButton(
                                  text: "Open Gallery",
                                  textSize: Dimension.widthSize(15),
                                  onPress: () {
                                    Navigator.of(context)
                                        .pop(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                            .box
                            .height(Dimension.heightSize(200))
                            .color(AppColors.whiteColor)
                            .padding(
                              EdgeInsets.symmetric(
                                vertical: Dimension.heightSize(15),
                                horizontal: Dimension.widthSize(15),
                              ),
                            )
                            .make(),
                      );
                    },
                  );
                  // Check if the user selected an image source
                  if (imgSource != null) {
                    // Second, change image
                    profileController.changeImage(context, imgSource);
                  } else {
                    // Show error that image source not selected
                    showToast(
                      context: context,
                      msg: "No image source selected",
                      seconds: 5000,
                    );
                  }
                },
              ),
              Dimension.heightSize(30).heightBox,
              // text fields =====================================================
              // name field
              inputField(
                controller: profileController.nameController,
                hintText: "Name",
                keyboard: TextInputType.text,
                prefixIcon: const Icon(Icons.person),
                prefixIconColor: AppColors.iconColor1,
              ),
              Dimension.heightSize(8).heightBox,
              // phone number field
              inputField(
                controller: profileController.phoneController,
                hintText: "Phone Number",
                keyboard: TextInputType.number,
                prefixIcon: const Icon(Icons.phone),
                prefixIconColor: AppColors.iconColor1,
              ),
              Dimension.heightSize(8).heightBox,
              // address feild
              inputField(
                controller: profileController.addressController,
                hintText: "Address",
                keyboard: TextInputType.text,
                prefixIcon: const Icon(Icons.maps_home_work_rounded),
                prefixIconColor: AppColors.iconColor1,
              ),
              // save or discard changes =========================================
              Dimension.heightSize(20).heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  elevatedButton(
                    text: "Discard Changes",
                    textColor: AppColors.mainBlackColor,
                    bgColor: AppColors.whiteColor,
                    textSize: Dimension.widthSize(15),
                    onPress: () {
                      Get.offAll(() => const MainPage());
                    },
                  ),
                  Dimension.widthSize(5).widthBox,
                  elevatedButton(
                    text: "Save Changes",
                    textSize: Dimension.widthSize(15),
                    onPress: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return loaderDialogbox(
                            text: "Saving Changes...",
                          );
                        },
                      );
                      // if user not change image
                      if (profileController.profileImgPath.isNotEmpty) {
                        await profileController.uploadProfileImg(context);
                      } else {
                        profileController.profileImgLink = data["imageURL"];
                      }
                      // ensure that none fields should be none
                      if (profileController.nameController.text.trim() == "" ||
                          profileController.addressController.text.trim() ==
                              "" ||
                          profileController.phoneController.text.trim() == "") {
                        Navigator.of(context).pop();
                        showToast(
                          context: context,
                          msg: "Any field should not be blank!",
                          seconds: 5000,
                        );
                      } else {
                        if (profileController.phoneController.text.length !=
                            11) {
                          Navigator.of(context).pop();
                          showToast(
                            context: context,
                            msg: "Phone number length should be 11",
                            seconds: 5000,
                          );
                        } else {
                          await profileController.updateProfile(
                            context: context,
                            name: profileController.nameController.text,
                            phone: profileController.phoneController.text,
                            address: profileController.addressController.text,
                            imageUrl: profileController.profileImgLink,
                          );
                          Navigator.of(context).pop();
                          Get.offAll(() => const MainPage());
                          showToast(
                            context: context,
                            msg: "Changes saved",
                            seconds: 5000,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
