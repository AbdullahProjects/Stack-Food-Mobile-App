import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';
import 'package:food_delivery/views/profile_screen/phone%20verification/otp_screen.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProfileController extends GetxController {
  // phone number verification
  var verificationId = ''.obs;
  var phoneNumber = ''.obs;
  var isPhoneVerified = false.obs;
  var isLoading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // handling toggle button On,Off state for setting app theme
  RxBool isDarkTheme = false.obs;
  void toggleTheme() {
    if (isDarkTheme.value) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
    isDarkTheme.value = !isDarkTheme.value;
  }

  // necessary varaibles for handling image selection
  var profileImgPath = "".obs;
  var profileImgLink = "";

  // edit profile text fields
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  // update profile info =======================================================
  updateProfile({context, name, phone, address, imageUrl}) async {
    try {
      var store = firestore.collection(usersCollection).doc(currentUser!.uid);
      await store.set({
        "name": name,
        "phoneNumber": phone,
        "address": address,
        "imageURL": imageUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  // change image ==============================================================
  changeImage(context, source) async {
    try {
      final img =
          await ImagePicker().pickImage(source: source, imageQuality: 40);
      if (img == null) return;
      profileImgPath.value = img.path;
    } catch (e) {
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  // upload profile img to firebase ============================================
  uploadProfileImg(context) async {
    try {
      var filename = basename(profileImgPath.value);
      var destination = "profileImages/${currentUser!.uid}/$filename";
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));
      profileImgLink = await ref.getDownloadURL();
    } catch (e) {
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  // check phone number is verified or not =====================================
  // Future<bool> isPhoneVerified(String uid) async {
  //   try {
  //     var checkUser = await firestore
  //         .collection(usersCollection)
  //         .where(currentUser!.uid, isEqualTo: uid)
  //         .get();
  //     if (checkUser.docs.isNotEmpty) {
  //       var document = checkUser.docs.first;
  //       return document['phone_verified'];
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // verify phone number =======================================================
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      // await _auth.signOut();
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential);
          isLoading.value = false;
          showToast(
            context: context,
            msg: "Phone Number verified!",
            seconds: 5000,
          );
          isPhoneVerified.value = true;
        },
        verificationFailed: (FirebaseException e) {
          isLoading.value = false;
          showToast(context: context, msg: e.toString(), seconds: 5000);
        },
        codeSent: (String verificationId, int? resendToken) {
          // this.verificationId.value = '';
          this.verificationId.value = verificationId;
          isLoading.value = false;
          Get.offAll(() => const OtpScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      isLoading.value = false;
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  // verify otp code =========================================================
  Future<void> verifyOtpCode(String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpCode,
      );

      await _auth.signInWithCredential(credential);
      isLoading.value = false;
      showToast(
        context: context,
        msg: "Phone Number verified successfully!",
        seconds: 5000,
      );

      // update firebase database phone verified field
      await firestore.collection(usersCollection).doc(currentUser!.uid).set(
        {
          'phone_verified': true,
        },
        SetOptions(merge: true),
      );

      // Sign out immediately after verification
      await _auth.signOut();
      Get.offAll(() => const MainPage());
    } catch (e) {
      isLoading.value = false;
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }
}
