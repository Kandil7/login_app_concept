import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/presentation_layer.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome ${state.user.email}')));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username')),
                const SizedBox(height: 10),
                TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 10),
                TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password')),
                const SizedBox(height: 10),
                TextField(
                    controller: confirmPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'confirm Password')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      // validate fields
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          usernameController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('All fields are required')));
                        return;
                      } else {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          context.read<AuthCubit>().register(
                                emailController.text,
                                passwordController.text,
                                usernameController.text,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Password does not match')));
                        }
                      }
                    },
                    child: const Text('Register')),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text(" I have an account ."),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login Now ',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
