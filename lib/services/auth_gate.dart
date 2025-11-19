import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lấy AuthService
    final authService = AuthService();

    return Scaffold(
      body: StreamBuilder<User?>(
        // Lắng nghe trạng thái đăng nhập từ AuthService
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          // 1. Đang kiểm tra...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. User ĐÃ đăng nhập
          if (snapshot.hasData) {
            return const HomeScreen(); 
          }

          // 3. User CHƯA đăng nhập
          return const LoginScreen(); 
        },
      ),
    );
  }
}