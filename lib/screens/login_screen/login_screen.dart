import 'package:andit/models/error_response.dart';
import 'package:andit/utils/size_constant.dart';
import 'package:andit/utils/text_style_constant.dart';
import 'package:andit/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:provider/provider.dart';

import '../../utils/extensions/textstyle_ext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _handleLogin(context, state) async {
    Utils.showLoading();
    try {
      await Future.delayed(Duration(milliseconds: 200));
      Utils.hideLoading();
      Utils.showSuccessMessage(context, 'Login', 'Login Successfully!', () {
        Navigator.of(context).pop();

        Navigator.popUntil(context, (route) => route.settings.name == '/');
      });
    } on ErrorResponse catch (e) {
      Utils.hideLoading();
      Utils.showErrorMessage(context, '', e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.dismissKeyboard(context);
      },
      child: SignInScreen(
        footerBuilder: (context, action) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
        actions: [
          ForgotPasswordAction(((context, email) {
            Navigator.of(context)
                .pushNamed('/forgot-password', arguments: {'email': email});
          })),
          AuthStateChangeAction(((context, state) {
            if (state is SignedIn || state is UserCreated) {
              var user = (state is SignedIn)
                  ? state.user
                  : (state as UserCreated).credential.user;
              if (user == null) {
                return;
              }
              if (state is UserCreated) {
                user.updateDisplayName(user.email!.split('@')[0]);
              }
              if (!user.emailVerified) {
                user.sendEmailVerification();
                const snackBar = SnackBar(
                    content: Text(
                        'Please check your email to verify your email address'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            }
          })),
        ],
      ),
    );
  }
}
