import 'dart:io';
import 'package:flutter/material.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/password_textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/SignupScreen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final TextEditingController _confirmPassword = TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    File? _pickedImage;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                _signupLine(context),
                const SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 68,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                        radius: 66,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage)
                              : const AssetImage('images/default_user.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: IconButton(
                        tooltip: 'Edit Image',
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 40,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  title: 'Name',
                  controller: _name,
                  autoFocus: true,
                  validator: (String? value) =>
                      CustomValidator.lessThen4(value),
                ),
                CustomTextFormField(
                  title: 'Email',
                  controller: _email,
                  hint: 'test@test.com',
                  validator: (String? value) => CustomValidator.email(value),
                ),
                PasswordTextFormField(controller: _password),
                PasswordTextFormField(
                  controller: _confirmPassword,
                  title: 'Confirm Password',
                ),
                CustomTextButton(
                  onTap: () {},
                  text: 'Sign up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _signupLine(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'Sign up',
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
