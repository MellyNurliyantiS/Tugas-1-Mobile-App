import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  String? _wajibIsi(String? val, String pesan) =>
      val == null || val.trim().isEmpty ? pesan : null;

  void _register() {
    if (_formKey.currentState!.validate()) {
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil! Silakan masuk.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(title: const Text('Pendaftaran Akun')),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nama Lengkap',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (val) => _wajibIsi(val, 'Masukkan nama'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.badge_outlined),
                          ),
                          validator: (val) => _wajibIsi(val, 'Masukkan Username'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (val) =>
                              _wajibIsi(val, 'Masukkan kata sandi'),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _register,
                          child: const Text('Daftar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}