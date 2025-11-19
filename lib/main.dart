import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// CÁC FILE CỦA CHÚNG TA
import 'providers/cart_provider.dart';
import 'services/auth_gate.dart';

// FILE CẤU HÌNH FIREBASE
import 'firebase_options.dart';

void main() async {
  // Đảm bảo Flutter đã khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Chúng ta sẽ "cung cấp" (Provide) CartProvider
  // để sau này toàn bộ ứng dụng có thể truy cập Giỏ hàng
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Màu nền chung của app (Màu xanh ngọc vừa)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3D8B87), // Màu xanh ngọc vừa (giống ảnh mẫu)
          primary: const Color(0xFFF0C759), // Màu Vàng (cho nút, text)
          secondary: const Color(0xFFE0E0E0), // Màu xám nhạt (cho text phụ)
        ),

        // Scaffold background màu xanh ngọc vừa (#3D8B87)
        scaffoldBackgroundColor: const Color(0xFF3D8B87),
        // Chỉnh theme cho Ô Nhập Liệu (TextField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // Nền trắng
          hintStyle: const TextStyle(color: Colors.black38), // Hint màu xám
          labelStyle: const TextStyle(color: Colors.black54), // Label màu xám đậm  
          // Viền khi không focus
          // Viền khi không focus
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12, width: 1), // Viền xám mỏng
          ),
          // Viền khi focus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4A9A96), width: 2), // Viền xanh khi focus
          ),
        ),

        // Chỉnh theme cho Nút Bấm (ElevatedButton)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF0C759), // Nền nút màu vàng
            foregroundColor: const Color(0xFF1E3A3A), // Chữ trên nút màu xanh đậm
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Đảm bảo text trên nền tối là màu trắng
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        
        // Đảm bảo icon trên nền tối là màu trắng
        iconTheme: const IconThemeData(color: Colors.white70),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)
        )
      ),

      // Điểm bắt đầu của ứng dụng
      home: const AuthGate(),
    );
  }
}

// BƯỚC 2: XÓA TOÀN BỘ class AuthGate TẠM THỜI Ở ĐÂY