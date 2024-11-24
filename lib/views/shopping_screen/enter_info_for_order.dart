// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';
import 'package:food_delivery/views/shopping_screen/components/phone_not_verified_dialogbox.dart';

class EnterInfoForOrder extends StatefulWidget {
  const EnterInfoForOrder({super.key});

  @override
  State<EnterInfoForOrder> createState() => _EnterInfoForOrderState();
}

class _EnterInfoForOrderState extends State<EnterInfoForOrder> {
  // controller
  var orderController = Get.put(ShoppingController());
  // text fields controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  var userData;
  var isPhoneVerified;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      userData = await firestore
          .collection(usersCollection)
          .where('id', isEqualTo: currentUser!.uid)
          .get();
      if (userData.docs.isNotEmpty) {
        var userDoc = userData.docs[0];
        setState(() {
          nameController.text = userDoc["name"];
          phoneController.text = userDoc["phoneNumber"];
          addressController.text = userDoc["address"];
          isPhoneVerified = userDoc["phone_verified"];
        });
      }
    } catch (e) {
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // (Dimension.screenHeight * 0.08).heightBox,
              // image logo ======================================================
              Image.asset(
                ImgUserMarker,
                fit: BoxFit.contain,
              )
                  .box
                  .size(Dimension.widthSize(80), Dimension.heightSize(80))
                  .make(),
              Dimension.heightSize(20).heightBox,
              boldText(
                text: "Enter Necessary Info...",
                size: Dimension.widthSize(18),
              ),
              Dimension.heightSize(30).heightBox,
              // input fields ====================================================
              // name field
              inputField(
                hintText: "Name",
                controller: nameController,
                keyboard: TextInputType.text,
                prefixIcon: const Icon(Icons.person),
              ),
              Dimension.heightSize(8).heightBox,
              // phone field
              inputField(
                hintText: "Phone Number",
                controller: phoneController,
                keyboard: TextInputType.number,
                prefixIcon: const Icon(Icons.phone),
              ),
              Dimension.heightSize(8).heightBox,
              // address field
              inputField(
                hintText: "Address",
                controller: addressController,
                keyboard: TextInputType.text,
                prefixIcon: const Icon(Icons.maps_home_work),
              ),
              Dimension.heightSize(8).heightBox,
              // city field
              inputField(
                hintText: "City",
                controller: cityController,
                keyboard: TextInputType.text,
                prefixIcon: const Icon(Icons.location_city_rounded),
              ),
              Dimension.heightSize(25).heightBox,
              // confirm order now =============================================
              elevatedButton(
                text: "Confirm Order",
                textSize: Dimension.widthSize(16),
                onPress: () async {
                  if (nameController.text.trim() == "" ||
                      phoneController.text.trim() == "" ||
                      addressController.text.trim() == "" ||
                      cityController.text.trim() == "") {
                    showToast(
                      context: context,
                      msg: "Any field should not be blank!",
                      seconds: 5000,
                    );
                  } else {
                    // if (isPhoneVerified == true) {
                    try {
                      await orderController.placeOrder(
                        context,
                        nameController.text,
                        phoneController.text,
                        addressController.text,
                        cityController.text,
                      );
                    } catch (e) {
                      showToast(
                        context: context,
                        msg: e.toString(),
                        seconds: 5000,
                      );
                    }
                    // } else {
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) {
                    //       return phoneNumberNotVerified(context);
                    //     },
                    //   );
                    // }
                  }
                },
              ),
            ],
          )
              .box
              .width(Dimension.screenWidth)
              .padding(
                EdgeInsets.only(
                  top: Dimension.screenHeight * 0.03,
                  left: Dimension.widthSize(15),
                  right: Dimension.widthSize(15),
                  bottom: Dimension.heightSize(30),
                ),
              )
              .make(),
        ),
      ),
    );
  }
}
