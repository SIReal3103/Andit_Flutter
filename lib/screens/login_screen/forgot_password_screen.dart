import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import '../../utils/text_style_constant.dart';

class ForgotPasswordScreenMain extends StatefulWidget {
  const ForgotPasswordScreenMain({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreenMain> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreenMain> {
  final _formKey = GlobalKey<FormBuilderState>();
  var phoneMode = false;
  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)?.settings.arguments
    as Map<String, dynamic>?;

    return ForgotPasswordScreen(
      email: arguments?['email'] as String,
      headerMaxExtent: 200,
    );
  }
}
