import 'package:flutter/material.dart';
import 'login_fields.dart';

import '../styles/text_styles.dart';
import '../styles/app_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MisoIoT', style: AppTextStyles.appBar),
        centerTitle: true,
        backgroundColor: const Color(0xFFB2DFDB),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(decoration: AppDecorations.loginContainer),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    padding: const EdgeInsets.all(24),
                    decoration: AppDecorations.loginContainer,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Bienvenido a VetMiso',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bigTitles,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ingresa tu correo y contraseña para acceder a la app.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subTitles,
                        ),
                      ],
                    ),
                  ),
                  LoginFields(
                    onLogin: (email) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WelcomeScreen(email: email),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String email;

  const WelcomeScreen({super.key, required this.email});

  String _extractNameFromEmail() {
    final parts = email.split('@');
    if (parts.isEmpty) return '';
    final raw = parts[0].trim();
    if (raw.isEmpty) return '';
    return raw[0].toUpperCase() + (raw.length > 1 ? raw.substring(1) : '');
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _extractNameFromEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido', style: AppTextStyles.appBar),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(224, 250, 246, 246),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(24),
          decoration: AppDecorations.loginContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bienvenido $email',
                style: AppTextStyles.bigTitles,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (displayName.isNotEmpty)
                Text(
                  '¡Hola, $displayName! Esto es para ti.',
                  style: AppTextStyles.subTitles,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
