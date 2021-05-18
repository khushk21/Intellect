import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';

class OTPMgr {
  static final _firestore = FirebaseFirestore.instance;
  
  static int numAttempts;
  static void sendOTP(String email) async {
    numAttempts = 3;
    EmailAuth.sessionName = "Verification";
    var response = await EmailAuth.sendOtp(receiverMail: email);
    if (response) {
      print("OTP SENT");
    } else {
      print("problem encountered");
    }
  }

  static Future<bool> validateEmail(String email) async {
    bool isValid = false;
    await for (var snapshot in _firestore
        .collection("Students")
        .where("email", isEqualTo: email)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        for (var document in documents) {
          if (document['email'] == email) {
            isValid = true;
            return isValid;
          }
        }
      }
      return isValid;
    }
  }

  static bool maxTries() {
    numAttempts--;
    if (numAttempts == 0) return true;
    return false;
  }

  static bool verifyOTP(String email, String otp) {
    var response = EmailAuth.validate(receiverMail: email, userOTP: otp);
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
