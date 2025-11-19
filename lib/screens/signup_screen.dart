import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers cho ô nhập liệu
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Biến để hiển thị/ẩn mật khẩu
  bool _isPasswordVisible = false;

  // Hàm xử lý đăng ký
  void _signup(BuildContext context) async {
    // Lấy auth service
    final authService = AuthService();

    try {
      // Thử đăng ký
      await authService.signUpWithEmailPassword(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      // Nếu đăng ký thành công, quay lại trang Đăng nhập
      // (AuthGate sẽ KHÔNG tự chuyển vì user vẫn ở màn hình login)
      if (mounted) {
        Navigator.pop(context); // Quay lại LoginScreen
      }
      
    } catch (e) {
      // Hiển thị lỗi nếu đăng ký thất bại
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi Đăng Ký"),
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
                  "Create Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign up to get started!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 40),

                // 3. Ô nhập Tên
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person_outline, color: Colors.black38),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),


                // 4. Ô nhập Email (Username)
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline, color: Colors.black38),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // 5. Ô nhập Mật khẩu
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
                const SizedBox(height: 32),

                // 6. Nút Đăng ký
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _signup(context),
                    child: const Text('Create Account'),
                  ),
                ),
                const SizedBox(height: 24),

                // 7. Chuyển sang Đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have Account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context), // Quay lại LoginScreen
                      child: Text(
                        "Login Now",
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