import 'package:flutter/material.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/password_textformfield.dart';
import '../../widgets/show_loading.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _loginWord(context),
              const SizedBox(height: 30),
              CustomTextFormField(
                title: 'Email',
                controller: _email,
                hint: 'test@test.com',
                validator: (String? value) => CustomValidator.email(value),
                autoFocus: true,
              ),
              PasswordTextFormField(controller: _password),
              _forgetPassword(),
              CustomTextButton(
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    showLoadingDislog(context);
                  }
                },
                text: 'Login',
              ),
              const Spacer(),
              _signupLine(),
              SizedBox(height: Utilities.padding),
            ],
          ),
        ),
      ),
    );
  }

  Row _signupLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('''Don't have a account? '''),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }

  GestureDetector _forgetPassword() {
    return GestureDetector(
      onTap: () {
        // TODO: Forget password
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        alignment: Alignment.centerRight,
        child: const Text('Forget password?'),
      ),
    );
  }

  Row _loginWord(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'Login',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Icon(
            Icons.fiber_manual_record,
            size: 18,
          ),
        )
      ],
    );
  }
}
