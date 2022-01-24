import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/src/core/base_component.dart';
import 'package:flutter_skeleton/src/core/components/centered_loader.dart';
import 'package:flutter_skeleton/src/feature/auth/providers/login_form_provider.dart';

class LoginForm extends BaseComponent {
  LoginForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final _loginFormProvider = ref.read(loginFormProvider.notifier);
    final _loginFormModel = ref.watch(loginFormProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    controller: _loginFormProvider.emailController,
                    validator: _loginFormProvider.emailValidator,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                    controller: _loginFormProvider.passwordController,
                    validator: _loginFormProvider.passwordValidator,
                    obscureText: true,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed:
                            _loginFormModel.status == LoginFormStatus.Empty
                                ? null
                                : () {
                                    _loginFormProvider.clear();
                                  },
                        child: const Text("Clear"),
                      ),
                      ElevatedButton(
                        onPressed:
                            _loginFormModel.status == LoginFormStatus.Processing
                                ? null
                                : () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    _loginFormProvider.submit();
                                  },
                        child: const Text("Login"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
