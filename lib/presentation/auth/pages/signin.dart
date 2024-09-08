import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widgets/appbar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';
import 'package:spotify_app/domain/usecases/auth/signin.dart';
import 'package:spotify_app/presentation/auth/pages/signup.dart';
import 'package:spotify_app/presentation/home/pages/home.dart';

import '../../../service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(height: 50),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignInUseCase>().call(
                      params: SignInUserRequest(
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString()));
                  result.fold((l) {
                    var snackBar = SnackBar(content: Text(l.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const HomePage()),
                            (route) => false);
                  });
                },
                title: 'Sign In'),
          ],
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Enter Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
