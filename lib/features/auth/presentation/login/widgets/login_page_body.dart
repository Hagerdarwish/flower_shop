import 'package:flower_shop/features/auth/presentation/login/widgets/login_form.dart';
import 'package:flutter/widgets.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          LoginForm(
            formKey: GlobalKey<FormState>(),
            autoValidate: false,
          ),
        ],
      ),
    );
  }
}