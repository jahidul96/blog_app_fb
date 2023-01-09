import 'package:firebase_auth/firebase_auth.dart';

class AppNeededData {
  static final userUid = FirebaseAuth.instance.currentUser!.uid;

  static final List<String> categories = [
    "Sport",
    "News",
    "Proggraminng",
    "Enterteinment",
    "Others",
  ];
}
