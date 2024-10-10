import 'package:cinema_club/constants/string/route_name.dart';
import 'package:cinema_club/features/authentication/data/models/user_model.dart';
import 'package:cinema_club/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/widgets/header.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.grey[700]!,
                Colors.grey[500]!,
                Colors.grey[600]!,
              ],
            ),
          ),*/
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 80),

                Expanded(
                  child: Card(
                    elevation: 10.0,
                    child: inputWrapper(context),
                  ),
                ),
                //const SizedBox(height: 20),
                // Added Sign Up button
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          inputFieldContainer(
            controller: _userNameController,
            textInputAction: TextInputAction.next,
            label: S.of(context).nameLabel,
            icon: Icons.person,
            validator: (value) {
              // UserName validation
              final userNamePattern = RegExp(r'^[0-9]');
              final trimmedValue = value?.trim();
              if (trimmedValue == null || trimmedValue.isEmpty) {
                return S.of(context).pleaseEnterUsernameLabel;
              }
              if (trimmedValue.isNotEmpty &&
                  userNamePattern.hasMatch(trimmedValue)) {
                return S.of(context).usernameCannotStartWithNumberLabel;
              }
              return null;
            },
          ),
          inputFieldContainer(
            controller: _emailController,
            textInputAction: TextInputAction.next,
            label: S.of(context).emailLabel,
            icon: Icons.email,
            validator: (value) {
              // Email validation
              const emailPattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseEnterAnEmailLabel;
              }
              if (!RegExp(emailPattern).hasMatch(value)) {
                return S.of(context).validEmailLabel;
              }
              return null;
            },
          ),
          inputFieldContainer(
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            label: S.of(context).phoneLabel,
            icon: Icons.phone_android,
            validator: (value) {
              final phoneNumberPattern = RegExp(r'^(010|011|012|015)[0-9]{8}$');
              // Phone Number validation
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseEnterPhoneNumberLabel;
              }
              if (!phoneNumberPattern.hasMatch(value)) {
                return S.of(context).invalidPhoneLabel;
              }
              return null;
            },
          ),
          inputFieldContainer(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            label: S.of(context).passwordLabel,
            icon: Icons.lock,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseEnterPasswordLabel;
              }
              return null;
            },
          ),
          inputFieldContainer(
            controller: _confrimPasswordController,
            textInputAction: TextInputAction.done,
            label: S.of(context).confirmPasswordLabel,
            icon: Icons.lock,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseConfirmYourPasswordLabel;
              }
              if (value != _passwordController.text) {
                return S.of(context).passwordsDoNotMatchLabel;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget inputFieldContainer({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    required TextInputAction textInputAction,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon),
          ),
          obscureText: obscureText,
          validator: validator,
          textInputAction: textInputAction,
        ),
      ),
    );
  }

  Widget inputWrapper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Header(headerName: S.of(context).signupLabel),
          //const SizedBox(height: 12),
          inputField(context),
          const SizedBox(height: 20),
          signUpButton(context),
          const SizedBox(height: 40),
          gotoLogin(),
        ],
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSignUp) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final name = _userNameController.text;
              final email = _emailController.text;
              final phone = _phoneController.text;
              final password = _passwordController.text;
              final userEntity = UserModel(
                uid: '',
                name: name,
                email: email,
                phone: phone,
                photo: '',
                emailVerified: false,
              );

              context.read<AuthenticationBloc>().add(
                    SignUpEvent(
                      userEntity: userEntity,
                      password: password,
                    ),
                  );

              showToast("SignUp sucessful");
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: MediaQuery.of(context).size.width * 0.27),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10.0,
          ),
          child: Text(S.of(context).signupLabel,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 15)),
        ),
      ),
    );
  }

  Widget gotoLogin() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).aleardyHaveAnAccountLabel,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
        TextButton(
          style: const ButtonStyle(
              padding: WidgetStatePropertyAll(
                EdgeInsets.only(right: 20),
              ),
              overlayColor: WidgetStatePropertyAll(Colors.transparent)),
          onPressed: () {
            Navigator.pushNamed(context, loginScreen);
          },
          child: Text(
            S.of(context).loginLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast
      gravity: ToastGravity.BOTTOM, // Position of the toast
      timeInSecForIosWeb: 1, // Duration for iOS/Web
      backgroundColor: Colors.white, // Background color of the toast
      textColor: Colors.black, // Text color of the toast
      fontSize: 16.0, // Font size of the toast
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confrimPasswordController.dispose();
    super.dispose();
  }
}
