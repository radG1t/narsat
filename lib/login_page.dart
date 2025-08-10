import 'package:flutter/material.dart';
import 'product_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا شماره تلفن را وارد کنید.';
    }
    final RegExp phoneRegExp = RegExp(r'^09[0-9]{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'فرمت شماره تلفن صحیح نیست. (مثال: 09123456789)';
    }
    return null;
  }

  // اعتبارسنجی رمز عبور
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا رمز عبور را وارد کنید.';
    }
    if (value.length < 6 || value.length > 12) {
      return 'رمز عبور باید بین 6 تا 12 کاراکتر باشد.';
    }
    final RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'رمز باید شامل حروف بزرگ، کوچک و عدد باشد.';
    }
    return null;
  }

  void _login() {
    // ابتدا بررسی می‌کنیم که آیا فرم معتبر است یا خیر
    if (_formKey.currentState!.validate()) {
      // اگر معتبر بود، به صفحه محصولات می‌رویم
      // در یک اپلیکیشن واقعی، اینجا درخواست به سرور ارسال می‌شود
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // بخش لوگو
                  Icon(Icons.satellite_alt, size: 80.0, color: Colors.red[700]),
                  const SizedBox(height: 8.0),
                  Text(
                    'نارسات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 48.0),

                  // فیلد شماره تلفن
                  TextFormField(
                    validator: _validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      hintText: 'شماره تلفن',
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 12.0),

                  // فیلد رمز عبور
                  TextFormField(
                    validator: _validatePassword,
                    obscureText: !_isPasswordVisible,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 24.0),

                  // دکمه ورود
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5.0,
                    ),
                    child: const Text(
                      'ورود',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // گزینه ثبت نام
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('حساب کاربری ندارید؟'),
                      TextButton(
                        onPressed: () {
                          // منطق رفتن به صفحه ثبت نام در اینجا قرار می‌گیرد
                          // فعلا یک پیام در کنسول چاپ می‌کنیم
                          print('رفتن به صفحه ثبت نام');
                        },
                        child: Text(
                          'ثبت نام کنید',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
