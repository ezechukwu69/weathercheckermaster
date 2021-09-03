import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathercheckermaster/controllers/authcontroller.dart';
import 'package:weathercheckermaster/pages/HomePage.dart';
import 'package:weathercheckermaster/utils/space.dart';
import 'package:weathercheckermaster/widgets/authButtons.dart';
import 'package:weathercheckermaster/widgets/customTextField.dart';

class SignUpPage extends StatefulWidget {
  static const String path = "/signup";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool obscureText = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                    if (v!.length > 6) {
                      return null;
                    }
                    return "Password needs to be atleast six characters long";
                  }),
            ),
            size(height: 18),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: AuthButtons(
                  title: "Register",
                  icon: Icons.arrow_forward_ios,
                  onTap: () async {
                    if (key.currentState?.validate() == true) {
                      var data = await Get.find<AuthController>()
                          .signUp(email: email.text, password: password.text);
                      if (data.status) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.path, (route) => false);
                      }
                    } else {}
                  }),
            ),
            size(height: 12),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
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
                        text: "Login",
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
      ),
    );
  }
}
