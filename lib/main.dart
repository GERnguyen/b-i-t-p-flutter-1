import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import thư viện http [cite: 1762]

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue, useMaterial3: true),
      home: const IntroPage(),
    );
  }
}

// --- TRANG 1: INTRO (GIỮ NGUYÊN LOGIC CŨ) ---
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(child: Text('HCMUTE - Đang chuyển trang...', style: TextStyle(color: Colors.white))),
    );
  }
}

// --- TRANG 2: LOGIN (JWT) ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> _login() async {
    // URL API của bạn em làm Backend
    final url = Uri.parse('http://your-api-url.com/api/login');
    
    try {
      final response = await http.post(url, 
        body: jsonEncode({'username': _userController.text, 'password': _passController.text}),
        headers: {'Content-Type': 'application/json'}
      ); [cite: 1717]

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token']; // Nhận JWT từ Backend
        print('Login Success, Token: $token');
        // Điều hướng vào trang chủ app tại đây
      } else {
        _showError('Đăng nhập thất bại');
      }
    } catch (e) {
      _showError('Lỗi kết nối: $e');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Manager')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _passController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('ĐĂNG NHẬP')),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
              child: const Text('Chưa có tài khoản? Đăng ký'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage())),
              child: const Text('Quên mật khẩu?'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TRANG 3: REGISTER (OTP) ---
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Email/Username')),
            const TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Gọi API gửi OTP rồi chuyển sang trang xác thực
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPVerificationPage(type: 'register')));
              }, [cite: 1603]
              child: const Text('GỬI MÃ OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TRANG 4: FORGET PASSWORD ---
class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quên mật khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nhập Email đã đăng ký')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Gọi API quên mật khẩu
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPVerificationPage(type: 'forget_password')));
              },
              child: const Text('TIẾP TỤC'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TRANG 5: XÁC THỰC OTP (DÙNG CHUNG) ---
class OTPVerificationPage extends StatelessWidget {
  final String type;
  const OTPVerificationPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xác thực OTP')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Mã OTP đã được gửi để ${type == 'register' ? 'Đăng ký' : 'Khôi phục mật khẩu'}'),
            const TextField(decoration: InputDecoration(labelText: 'Nhập mã 6 số'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kiểm tra OTP qua API...
                Navigator.pop(context); // Trở về sau khi xong [cite: 1605]
              },
              child: const Text('XÁC NHẬN'),
            ),
          ],
        ),
      ),
    );
  }
}