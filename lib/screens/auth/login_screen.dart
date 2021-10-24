import 'package:firebase_api_task/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../database/aith_methods.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/password_textformfield.dart';
import '../../widgets/custom_toast.dart';
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
  void initState() {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    super.initState();
  }

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
              CustomTextButton(
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    showLoadingDislog(context);
                    final User? _user =
                        await AuthMethod().loginWithEmailAndPassword(
                      _email.text.trim(),
                      _password.text.trim(),
                    );
                    if (_user != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName,
                          (Route<dynamic> route) => false);
                    } else {
                      Navigator.of(context).pop();
                      CustomToast.errorToast(
                          message: 'email OR password in incorrect');
                    }
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
