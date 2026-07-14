import 'package:aidm/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/request_otp/request_otp_cubit.dart';
import '../bloc/request_otp/request_otp_state.dart';
import '../widgets/auth_page_layout.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestOtpCubit, RequestOtpState>(
      listener: (context, state) {
        if (state is RequestOtpSuccess) {
          AuthRoutes.toOtpVerification(context, email: state.email);
          context.read<RequestOtpCubit>().reset();
        }
      },
      child: BlocBuilder<RequestOtpCubit, RequestOtpState>(
        builder: (context, state) {
          return AuthPageLayout(
            title: 'Welcome\nBack!',
            buttonLabel: 'Login',
            secondaryPrefix: "Don't have an account? ",
            secondaryActionLabel: 'Sign Up',
            isLoading: state is RequestOtpLoading,
            errorMessage: state is RequestOtpFailure ? state.message : null,
            onBack: () => AuthRoutes.backFromSignIn(context),
            onPrimaryPressed: context.read<RequestOtpCubit>().submit,
            onSecondaryPressed: () {
              context.read<RequestOtpCubit>().reset();
              AuthRoutes.toSignUpFromSignIn(context);
            },
          );
        },
      ),
    );
  }
}
