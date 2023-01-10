import 'package:dio/dio.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import '../repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  authStateChangeHandler(context, state) {
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
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
