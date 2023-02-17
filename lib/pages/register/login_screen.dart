import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innon/pages/home/home_page.dart';
import 'package:innon/pages/register/register_screen.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/resources/firebase_consts.dart';
import 'package:innon/resources/screen_navigation_const.dart';
import 'package:innon/services/global_methods.dart';
import 'package:innon/widgets/discolored_button.dart';
import 'package:innon/widgets/general_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.accountType}) : super(key: key);
  final int? accountType;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await authInstance.signInWithEmailAndPassword(
              email: _emailController.text.toLowerCase().trim(),
              password: _passController.text.trim());

      print('Succefully logged in');
    } on FirebaseException catch (error) {
      GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget loginDisplay() {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: size.height * .09),
              GeneralButton(
                  isLoading: _isLoading,
                  text: 'Войти',
                  onPressed: () {
                    _submitFormOnLogin();
                  }),
              const SizedBox(height: 16),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: Text(
                    'Забыли пароль?',
                    style: AppStyles.s16w500.copyWith(color: AppColors.primary),
                  )),
              const Spacer(),
              DiscoloredButton(
                  text: 'Зарегистрироваться',
                  onPressed: () {
                    changeScreenByRemove(
                        context, const RegisterScreen(), '/register');
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authInstance.currentUser;
    return user != null ? const HomePage() : loginDisplay();
  }
}
