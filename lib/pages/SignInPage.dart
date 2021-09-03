import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathercheckermaster/controllers/authcontroller.dart';
import 'package:weathercheckermaster/pages/HomePage.dart';
import 'package:weathercheckermaster/pages/SignUpPage.dart';
import 'package:weathercheckermaster/utils/space.dart';
import 'package:weathercheckermaster/widgets/authButtons.dart';
import 'package:weathercheckermaster/widgets/customTextField.dart';

class SignInPage extends StatefulWidget {
  static const String path = "/";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscureText = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
    if (FirebaseAuth.instance.currentUser != null) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.path, (route) => false);
      });
    }
  }

  @override
  void dispose() {
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WeatherCheckerMaster",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          size(height: 50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: "Email",
              controller: email,
              validator: (v) {
                if (v!.isEmail) {
                  return null;
                }
                return "Please enter a valid Email";
              },
            ),
          ),
          size(height: 18),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: "Password",
              controller: password,
              obscureText: obscureText,
              suffixIcon: GestureDetector(
                onTap: () => setState(() => obscureText = !obscureText),
                child: Icon(
                  Icons.remove_red_eye,
                  color: !obscureText ? Colors.green : Colors.grey,
                ),
              ),
              validator: (v) {
                if (v!.length >= 6) {
                  return null;
                }
                return "Password needs to be atleast six characters long";
              },
            ),
          ),
          size(height: 18),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: AuthButtons(
              title: "Login",
              icon: Icons.arrow_forward_ios,
              onTap: () async {
                if (key.currentState?.validate() == true) {
                  var data = await Get.find<AuthController>()
                      .login(email: email.text, password: password.text);
                  if (data.status) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.path, (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(data.message!),
                      ),
                    );
                  }
                } else {}
              },
            ),
          ),
          size(height: 12),
          GetBuilder<AuthController>(
            builder: (_controller) => !_controller.showForgotPasswordButton
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: AuthButtons(
                      title: "Reset Password",
                      onTap: () async {
                        if (email.text.length <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter email address"),
                            ),
                          );
                          return;
                        }
                        var data = await Get.find<AuthController>()
                            .resetPassword(email: email.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(data.message!),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          size(height: 12),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(SignUpPage.path),
            child: RichText(
              text: TextSpan(
                  text: "Already Have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    ));
  }
}
