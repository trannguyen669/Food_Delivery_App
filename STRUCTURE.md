# Food Delivery App - Cấu trúc thư mục

## 📁 Cấu trúc code (lib/)

```
lib/
├── main.dart                      # Entry point của app
├── firebase_options.dart          # Cấu hình Firebase
│
├── 📂 models/                     # Data models
│   └── cart_item.dart             # Model cho item trong giỏ hàng
│
├── 📂 providers/                  # State management (Provider pattern)
│   └── cart_provider.dart         # Provider quản lý giỏ hàng
│
├── 📂 screens/                    # Các màn hình UI
│   ├── login_screen.dart          # Màn hình đăng nhập
│   ├── signup_screen.dart         # Màn hình đăng ký
│   ├── home_screen.dart           # Màn hình chính
│   ├── product_detail_screen.dart # Chi tiết sản phẩm
│   └── cart_screen.dart           # Giỏ hàng
│
├── 📂 services/                   # Business logic & services
│   ├── auth_service.dart          # Service xử lý authentication
│   └── auth_gate.dart             # Gate kiểm tra trạng thái đăng nhập
│
└── 📂 widgets/                    # Reusable UI components
    ├── category_list.dart         # Danh sách categories
    ├── food_card.dart             # Card hiển thị món ăn
    ├── recommendation_list.dart   # Danh sách recommendations
    └── special_offer_card.dart    # Card special offers
```

## 🎯 Quy tắc import

### Từ main.dart:
```dart
import 'providers/cart_provider.dart';
import 'services/auth_gate.dart';
```

### Từ screens/:
```dart
import '../services/auth_service.dart';
import '../providers/cart_provider.dart';
import '../widgets/food_card.dart';
import 'cart_screen.dart';  // Same folder
```

### Từ widgets/:
```dart
import '../screens/product_detail_screen.dart';
```

### Từ services/:
```dart
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'auth_service.dart';  // Same folder
```

## 📝 Mô tả chi tiết

### Models
- **cart_item.dart**: Class định nghĩa cấu trúc dữ liệu của item trong giỏ hàng

### Providers
- **cart_provider.dart**: Quản lý state của giỏ hàng với ChangeNotifier pattern

### Screens
- **login_screen.dart**: UI đăng nhập
- **signup_screen.dart**: UI đăng ký
- **home_screen.dart**: Màn hình chính với categories, foods
- **product_detail_screen.dart**: Chi tiết món ăn với size picker, quantity
- **cart_screen.dart**: Hiển thị giỏ hàng với swipe-to-delete

### Services
- **auth_service.dart**: Xử lý Firebase Authentication (login, signup, signout)
- **auth_gate.dart**: Widget kiểm tra user đã login chưa, redirect phù hợp

### Widgets
- **category_list.dart**: Component hiển thị danh sách categories
- **food_card.dart**: Component card món ăn (reusable)
- **recommendation_list.dart**: Component danh sách gợi ý
- **special_offer_card.dart**: Component card ưu đãi

## ✅ Lợi ích của cấu trúc này

1. **Separation of Concerns**: Mỗi thư mục có nhiệm vụ rõ ràng
2. **Scalability**: Dễ dàng thêm features mới
3. **Maintainability**: Code dễ bảo trì và tìm kiếm
4. **Reusability**: Widgets có thể tái sử dụng
5. **Team Collaboration**: Nhiều người làm việc không conflict

## 🚀 Hot Restart sau khi reorganize

Sau khi thay đổi cấu trúc, nhớ **Hot Restart** (R) thay vì Hot Reload (r) để áp dụng thay đổi!
