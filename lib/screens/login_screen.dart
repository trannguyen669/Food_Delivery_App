import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers cho ô nhập liệu
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Biến để hiển thị/ẩn mật khẩu
  bool _isPasswordVisible = false;

  // Hàm xử lý đăng nhập
  void _login(BuildContext context) async {
    // Lấy auth service
    final authService = AuthService();

    try {
      // Thử đăng nhập
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      // (AuthGate sẽ tự động chuyển màn hình nếu thành công)
      
    } catch (e) {
      // Hiển thị lỗi nếu đăng nhập thất bại
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi Đăng Nhập"),
          content: Text(e.toString().replaceAll("Exception: ", "")),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Hàm chuyển sang trang Đăng ký
  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy theme (màu sắc) từ main.dart
    final theme = Theme.of(context);

    return Scaffold(
      // Không cần set backgroundColor, sẽ dùng scaffoldBackgroundColor từ theme
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo (Bạn có thể thay bằng Image.asset nếu có logo)
                Icon(
                  Icons.restaurant_menu, // Icon tạm thời
                  size: 80,
                  color: theme.colorScheme.primary, // Màu Vàng
                ),
                const SizedBox(height: 16),
                Text(
                  "MadeFork",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),

                // 2. Chào mừng
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login with your account to continue.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 40),

                // 3. Ô nhập Email (Username)
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person_outline, color: Colors.black38),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // 4. Ô nhập Mật khẩu
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.black38),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 5. Quên mật khẩu? (Tạm thời)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.white.withOpacity(0.9)), // Màu trắng
                  ),
                ),
                const SizedBox(height: 32),

                // 6. Nút Đăng nhập
                // (Dùng style từ ButtonTheme trong main.dart)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 24),

                // 7. Chuyển sang Đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have Account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () => _navigateToSignUp(context),
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: theme.colorScheme.primary, // Màu Vàng
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
    );
  }
}