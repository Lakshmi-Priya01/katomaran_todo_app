import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      print("🔁 Starting Google Sign-In...");
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ Google user canceled sign-in.");
        return null;
      }

      print("✅ Google account selected: ${googleUser.email}");

      final googleAuth = await googleUser.authentication;

      print("🧩 Access Token: ${googleAuth.accessToken}");
      print("🧩 ID Token: ${googleAuth.idToken}");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      print("✅ Firebase login successful! UID: ${userCredential.user?.uid}");
      return userCredential.user;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }
}
