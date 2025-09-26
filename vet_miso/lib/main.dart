import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../styles/app_decorations.dart'; // ← se agregó esta línea

void main() {
  runApp(const VetMiso());
}

class VetMiso extends StatelessWidget {
  const VetMiso({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetMiso - IoT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ------------------ PANTALLA DE LOGIN ------------------

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _simulateLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 4));

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(email: _emailController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VetMiso - Inicio de Sesión',
          style: AppTextStyles.appBar,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: VetMisoBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: AppDecorations.loginContainer, // ← tu contenedor aplicado
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Bienvenido a VetMiso - IoT',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bigTitles,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Plataforma para el cuidado y monitoreo de tus mascotas',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subTitles,
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          hintText: 'usuario@gmail.com',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty) return 'Ingrese su correo electrónico';
                          if (!v.contains('@')) {
                            return 'El correo debe contener "@" ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          hintText: 'Al menos 6 caracteres',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          final v = value ?? '';
                          if (v.isEmpty) return 'Ingrese su contraseña';
                          if (v.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _simulateLogin,
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : const Text('Ingresar'),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------ PANTALLA DE BIENVENIDA ------------------ //

class WelcomeScreen extends StatelessWidget {
  final String email;

  const WelcomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VetMiso - Bienvenida',
          style: AppTextStyles.appBar,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      body: VetMisoBackground(
        child: Center(
          child: Container(
            decoration: AppDecorations.loginContainer, // ← tu contenedor aplicado
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¡Bienvenido, $email!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bigTitles,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Has iniciado sesión correctamente en VetMiso IoT.\nAquí puedes supervisar el cuidado de tus mascotas.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subTitles,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text('Cerrar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VetMisoBackground extends StatelessWidget {
  final Widget child;
  const VetMisoBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://i.ibb.co/Mk7j2448/fondo-Pantalla-Animalitos.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white.withAlpha(25), Colors.white.withAlpha(35)],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
