import 'package:flutter/material.dart';
import 'package:vet_miso/styles/text_styles.dart';
import 'package:vet_miso/styles/app_decorations.dart'; // import para intentar reutilizar codigo en decoraciones

class LoginFields extends StatefulWidget {
  final void Function(String email) onLogin;

  const LoginFields({super.key, required this.onLogin});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingresa un correo válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      widget.onLogin(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppDecorations.loginContainer, // ← Aquí se aplica tu estilo
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: AppTextStyles.subTitles,
              cursorColor: Colors.teal,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: AppTextStyles.subTitles,
                hintText: 'ejemplo@correo.com',
                hintStyle: AppTextStyles.subTitles.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF26A69A),
                ),
                filled: true,
                fillColor: const Color(0xFFE0F2F1),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 2.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                errorStyle: AppTextStyles.subTitles.copyWith(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
              ),
              validator: _validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              textInputAction: TextInputAction.done,
              style: AppTextStyles.subTitles,
              cursorColor: Colors.teal,
              onFieldSubmitted: (_) => _handleSubmit(),
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: AppTextStyles.subTitles,
                hintText: 'Ingresa tu contraseña',
                hintStyle: AppTextStyles.subTitles.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  color: Color(0xFF26A69A),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF26A69A),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                filled: true,
                fillColor: const Color(0xFFE0F2F1),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 2.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                errorStyle: AppTextStyles.subTitles.copyWith(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Iniciar sesión',
                style: AppTextStyles.subTitles
              ),
            ),
          ],
        ),
      ),
    );
  }
}