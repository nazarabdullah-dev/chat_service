import 'package:chat_service/src/data/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _emailController,
          decoration:
              InputDecoration(labelText: AppLocalizations.of(context)!.email),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.password),
          obscureText: true,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => context.read<LoginCubit>().signIn(
                email: _emailController.text,
                password: _passwordController.text,
              ),
          child: Text(AppLocalizations.of(context)!.login),
        ),
      ],
    );
  }
}
