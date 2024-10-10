import 'package:cinema_club/constants/string/route_name.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/widgets/header.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool hidenPasswordText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          /* decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.grey[700]!,
            Colors.grey[500]!,
            Colors.grey[600]!,
          ])),*/
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: Card(
                    elevation: 10.0,
                    child: inputWrapper(context),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
          context: context,
          controller: _emailController,
          labelText: S.of(context).emailLabel,
          icon: Icons.person,
          obscureText: false,
        ),
        _buildInputField(
          context: context,
          controller: _passwordController,
          labelText: S.of(context).passwordLabel,
          icon: Icons.lock,
          obscureText: hidenPasswordText,
          isPasswordField: true,
          toggleVisibility: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
              hidenPasswordText = !hidenPasswordText;
            });
          },
          isPasswordVisible: _isPasswordVisible,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool obscureText,
    bool isPasswordField = false,
    VoidCallback? toggleVisibility,
    bool isPasswordVisible = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      /*decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),*/
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            label: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            labelStyle: const TextStyle(fontSize: 14),
            floatingLabelStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon),
            suffixIcon: isPasswordField
                ? IconButton(
                    onPressed: toggleVisibility,
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )
                : null,
          ),
          obscureText: obscureText,
        ),
      ),
    );
  }

  Widget inputWrapper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            headerName: S.of(context).loginLabel,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: inputField(context),
          ),
          textButton(context),
          buttons(context),
          goToSignUp(),
        ],
      ),
    );
  }

  Widget textButton(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: () {
        Navigator.pushNamed(context, forgetPasswordScreen);
      },
      child: Text(
        S.of(context).forgetPasswordLabel,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // print("state ${state.runtimeType}");
        if (state is AuthenticationLogin) {
          Navigator.pushReplacementNamed(context, moviesNav);
          context.read<MovieFavoriteBloc>().add(GetRemoteFavoriteMoviesEvent());
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UpdateSendEmailVerification) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EmailVerificationSent) {
          //print(state.message);
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                final email = _emailController.text;
                final password = _passwordController.text;
                if (email.isNotEmpty && password.isNotEmpty) {
                  context.read<AuthenticationBloc>().add(
                        LoginWithEmailEvent(
                          email: email,
                          password: password,
                        ),
                      );

                  //context.read<AuthenticationBloc>().add(event)
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
              child: Text(
                S.of(context).loginLabel,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15),
              ),
            ),
          ),
          dividerWithText(),
          socialLoginButton(context)
        ],
      ),
    );
  }

  Widget dividerWithText() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Colors.black,
          indent: 30,
          endIndent: 30,
        ),
        const SizedBox(height: 10),
        Text(S.of(context).orLoginwithLabel,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Padding socialLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton(
            context: context,
            imagePath: "assets/image/googleicon.png",
            onPressed: () {
              context.read<AuthenticationBloc>().add(LoginWithGoogleEvent());
            },
          ),
          const SizedBox(width: 50),
          _buildSocialButton(
            context: context,
            imagePath: "assets/image/facebookicon.png",
            onPressed: () {
              context.read<AuthenticationBloc>().add(LoginWithFacebookEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 60,
      width: 65,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        //splashColor: Colors.grey,
        onPressed: onPressed,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget goToSignUp() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).dontHaveAnAccountLabel,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
        TextButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.only(right: 10),
            ),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, signUpScreen);
          },
          child: Text(
            S.of(context).signupLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
