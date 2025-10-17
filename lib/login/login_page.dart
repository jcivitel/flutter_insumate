import 'package:flutter/material.dart';
import 'package:flutter_insumate/pages/dashboard_page.dart';
import 'package:flutter_insumate/tools/api_key_manager.dart';
import 'package:flutter_insumate/tools/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkExistingApiKey();
  }

  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String? _error;
  bool _isLoading = false;

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      try {
        final apiKey = await ApiService.login(
          username: _username,
          password: _password,
        );
        if (apiKey != null) {
          debugPrint('Login erfolgreich, API-Key: $apiKey');
          await ApiKeyManager.setApiKey(apiKey);
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DashboardPage(),
            ),
          );
        } else {
          setState(() {
            _error = 'Ungültige Anmeldeinformationen';
          });
        }
      } catch (e) {
        setState(() {
          _error = 'Login fehlgeschlagen: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Insumate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/logo/logo.jpg', height: 150),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _username = value ?? '',
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your username'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      onEditingComplete: _submit,
                      obscureText: true,
                      onSaved: (value) => _password = value ?? '',
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your password'
                                  : null,
                    ),

                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: _submit,
                      child:
                          _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkExistingApiKey() async {
    try {
      var api_key = await ApiKeyManager.getApiKey();
      if (api_key != null) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => DashboardPage(),
          ),
        );
      }
    } catch (e) {
      debugPrint('No API key found: $e');
    }
  }
}
