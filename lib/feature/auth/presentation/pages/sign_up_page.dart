import 'package:aidm/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/request_otp/request_otp_cubit.dart';
import '../bloc/request_otp/request_otp_state.dart';
import '../widgets/auth_page_layout.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
            title: "Let's Get You\nSigned Up!",
            buttonLabel: 'Request OTP',
            secondaryPrefix: 'Already have an account? ',
            secondaryActionLabel: 'Login',
            isLoading: state is RequestOtpLoading,
            errorMessage: state is RequestOtpFailure ? state.message : null,
            onBack: () => AuthRoutes.backFromSignUp(context),
            onPrimaryPressed: context.read<RequestOtpCubit>().submit,
            onSecondaryPressed: () {
              context.read<RequestOtpCubit>().reset();
              AuthRoutes.toSignIn(context);
            },
          );
        },
      ),
    );
  }
}
