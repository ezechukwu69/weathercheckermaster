import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  bool showForgotPasswordButton = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<Result> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "${email.trim()}",
        password: "${password.trim()}",
      );
      return Result(status: true, message: "SignIn successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        showForgotPasswordButton = true;
        refresh();
      }
      return Result(status: false, message: e.message);
    } catch (e) {
      return Result(status: false, message: e.toString());
    }
  }

  Future<Result> signUp(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "${email.trim()}",
        password: "${password.trim()}",
      );
      return Result(status: true, message: "SignIn successful");
    } on FirebaseAuthException catch (e) {
      return Result(status: false, message: e.message);
    } catch (e) {
      return Result(status: false, message: e.toString());
    }
  }

  Future<Result> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: "${email.trim()}",
      );
      return Result(
          status: true, message: "Password reset link sent successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == "auth/user-not-found")
        return Result(status: false, message: "Email does not exist");
      return Result(status: false, message: e.message);
    } catch (e) {
      return Result(status: false, message: e.toString());
    }
  }
}

class Result {
  final String? message;
  final bool status;

  Result({this.message, required this.status});
}
