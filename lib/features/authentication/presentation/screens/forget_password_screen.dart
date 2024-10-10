import 'package:cinema_club/constants/string/route_name.dart';
import 'package:cinema_club/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/widgets/header.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Expanded(
                  child: Card(
                    elevation: 10.0,
                    child: inputWrapper(context),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputWrapper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            headerName: S.of(context).forgetPasswordLabel,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: forgetPasswordInputField(context),
          ),
          forgetPasswordButton(),
        ],
      ),
    );
  }

  forgetPasswordInputField(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
          context: context,
          controller: _emailController,
          labelText: S.of(context).emailLabel,
          icon: Icons.person,
          obscureText: false,
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

  forgetPasswordButton() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationResetPassword) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).forgetpasswordconfirmLabel,
                style: Theme.of(context).textTheme.bodyMedium),
            margin: const EdgeInsets.all(10.0),
            behavior: SnackBarBehavior.floating,
          ));
          // Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacementNamed(context, loginScreen);
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            final email = _emailController.text;
            if (email.isNotEmpty) {
              context
                  .read<AuthenticationBloc>()
                  .add(ResetPasswordEvent(email: email));
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: MediaQuery.of(context).size.width * 0.32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10.0,
          ),
          child: Text(
            S.of(context).forgetPasswordButtonLabel,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
