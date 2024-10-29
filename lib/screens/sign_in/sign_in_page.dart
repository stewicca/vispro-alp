import 'package:alp/main.dart';
import 'package:alp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/sign_in/sign_in_bloc.dart';
import '../../blocs/sign_in/sign_in_event.dart';
import '../../blocs/sign_in/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is SignInLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                CustomTextField(
                  controller: _usernameController,
                  label: "Username",
                ),
                CustomTextField(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    context
                        .read<SignInBloc>()
                        .add(SignInSubmitted(username, password));
                  },
                  child: const Text('Sign In'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
