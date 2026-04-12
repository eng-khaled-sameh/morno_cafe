import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:caffe_app/core/logic/auth_cubit.dart';
import 'package:caffe_app/core/logic/auth_state.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 317,
          height: 54,
          child: ElevatedButton(
            onPressed: state is AuthLoading
                ? null
                : () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0x8A000000),
              elevation: 3,
              shadowColor: const Color(0x2B000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: state is AuthLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0x8A000000)),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/logo_google.png'),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        AppLocalizations.of(context)!.continueWithGoogle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0x8A000000),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
