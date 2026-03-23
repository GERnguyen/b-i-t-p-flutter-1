import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const IntroPage(), // Chạy trang Intro đầu tiên
    );
  }
}

// --- TRANG 1: GIỚI THIỆU THÀNH VIÊN ---
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    // Logic: Đợi 10 giây rồi chuyển sang trang Login [cite: 1624]
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'NHÓM SINH VIÊN HCMUTE',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '1. Nguyễn Văn A - 2211xxxx\n2. Trần Thị B - 2211xxxx',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.white),
            Text(
              '\nĐang chuyển trang sau 10s...',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TRANG 2: LOGIN MANAGER ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Manager'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'HỆ THỐNG QUẢN LÝ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: const Text('ĐĂNG NHẬP'),
            ),
          ],
        ),
      ),
    );
  }
}
