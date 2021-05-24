import 'package:flutter/material.dart';
import 'package:leso/Screens/Login/components/OTP.dart';
import 'package:leso/Screens/Signup/admin_signup.dart';
import 'package:leso/Screens/administrator/admin_dep.dart';
import '../../../Success/success.dart';
import 'background.dart';
import '../../Signup/signup_screen.dart';
import '../../book/Book.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

String email;
String password;
class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Admin leso",
              style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 50),
            ),
            SizedBox(height: size.height * 0.001),
            Image.asset("assets/images/login.jpg",
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.03),

            RoundedInputField(
              hintText: "Your Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value ;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),

            RoundedButton(
              text: "LOGIN",
              color: button,
              press: () async {
                try  {
                  await FirebaseAuth.instance.signOut();
                  final user = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: email, password: password);
                  if(user!=null){
                    if(!user.user.emailVerified)
                      user.user.sendEmailVerification().then((value) =>{




                      });
                    if(!user.user.emailVerified)
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Verify Your Email "),
                          content: Text("Click Next When Verified"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                if(user.user.emailVerified)
                                  Navigator.of(ctx).pop();

                              },
                              child: Text("Next"),
                            ),

                          ],
                        ),
                      );

                    print(FirebaseAuth.instance.currentUser.email);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyStatefulWidget();
                        },
                      ),
                    );
                  }

                }
                catch(e) {
                  print(e);
                }
                print(email);
                print(password);
              },
            ),
            RoundedButton(
              text: "RESET PASSWORD",
              color: button,
              press: () async {

                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Password Reset "),
                    content: Text("Click Next and check your mail"),
                    actions: <Widget>[
                      RoundedInputField(
                        hintText: "Your Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value ;
                        },
                      ),
                      FlatButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                          Navigator.of(ctx).pop();

                        },
                        child: Text("Next"),
                      ),

                    ],
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(

              press: () {

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AdminSignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
