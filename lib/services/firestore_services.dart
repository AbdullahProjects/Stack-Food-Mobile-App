import 'package:food_delivery/consts/consts.dart';

class FirestoreServices extends GetxController {
  // get users data
  static getUser(uid) {
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }
}
