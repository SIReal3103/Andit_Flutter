import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:andit/view_models/tabber_view_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  void signOut() {}

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<TabbarViewModel>(context);
    var auth = Provider.of<ApplicationState>(context);

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              auth.loggedIn
                  ? const Text(
                      'You are logged in !',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      ),
                    )
                  : const Text(
                      'You are not logged in !',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      ),
                    ),
              Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                  child: auth.loggedIn
                      ? Container(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  auth.signOut();
                                },
                                child: const Center(
                                  child: Text(
                                    'Sign out',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 26),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sign-in');
                                },
                                child: const Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 26),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
