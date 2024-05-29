import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // store users data ==========================================================
  storeUserData({name, email, phoneNumber = "", imageUrl = ""}) async {
    if (currentUser != null) {
      DocumentReference store =
          firestore.collection(usersCollection).doc(currentUser!.uid);
      await store.set({
        "name": name,
        "email": email,
        "address": "",
        "imageURL": imageUrl,
        "phoneNumber": phoneNumber,
        "id": currentUser!.uid,
        "cart_count": 0,
        "favourite_count": 0,
        "orders_count": 0,
        "phone_verified": false,
      });
    }
  }

  // Email login method ========================================================
  Future emailLoginMethod({context, email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
    } catch (e) {
      showToast(context: context, msg: e.toString(), seconds: 5000);
    }
    return userCredential;
  }

  // Email sign-up method ======================================================
  Future emailSignupMethod({context, email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
    } catch (e) {
      showToast(context: context, msg: e.toString(), seconds: 5000);
    }
    return userCredential;
  }

  // Email forgot password method ==============================================
  forgotPassword(email, context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showToast(
        context: context,
        msg: "Verification Email successfully sent!",
        seconds: 5000,
      );
    } catch (e) {
      showToast(
        context: context,
        msg: e.toString(),
        seconds: 5000,
      );
    }
  }

  // email signout method ======================================================
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      showToast(context: context, msg: e.toString(), seconds: 5000);
    }
  }

  // Google sign in method =====================================================
  Future googleSignInMethod(context) async {
    UserCredential? userCredential;
    try {
      // signing out to allow user to select new account
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await auth.signInWithCredential(credential);
        currentUser = userCredential.user;

        // store user data if new user is sign in
        if (userCredential.additionalUserInfo!.isNewUser) {
          await storeUserData(
            email: googleUser.email,
            name: googleUser.displayName ?? "",
            imageUrl: googleUser.photoUrl ?? "",
          );
        }
      }
    } catch (e) {
      showToast(context: context, msg: e.toString(), seconds: 5000);
    }
    return userCredential;
  }

  // google signout method =====================================================
  Future googleSignOutMethod(context) async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      showToast(context: context, msg: e.toString(), seconds: 5000);
    }
  }

  // Facebook sign in method ===================================================
  // Future facebookSignInMethod(context) async {
  //   UserCredential? userCredential;
  //   try {
  //     await FacebookAuth.instance.logOut();
      
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     if (result.status == LoginStatus.success) {
  //       final AccessToken accessToken = result.accessToken!;
  //       final AuthCredential credential = FacebookAuthProvider.credential(
  //         accessToken.tokenString,
  //       );

  //       userCredential = await auth.signInWithCredential(credential);
  //       currentUser = userCredential.user;

  //       // store user data if new user is sign in
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         final userData = await FacebookAuth.instance.getUserData();
  //         await storeUserData(
  //           email: userData['email'],
  //           name: userData['name'],
  //           imageUrl: userData['picture']['data']['url'],
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     showToast(context: context, msg: e.toString(), seconds: 5000);
  //   }
  //   return userCredential;
  // }

  // // Facebook signout method ===================================================
  // Future facebookSignOutMethod(context) async {
  //   try {
  //     await FacebookAuth.instance.logOut();
  //     await auth.signOut();
  //   } catch (e) {
  //     showToast(context: context, msg: e.toString(), seconds: 5000);
  //   }
  // }
}
