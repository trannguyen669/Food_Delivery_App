import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'food_card.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Tiêu đề "Recommendation"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommendation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See All'),
              ),
            ],
          ),
        ),

        // 2. Grid layout 2 cột
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<QuerySnapshot>(
            // Lấy các món ăn có isRecommended == true
            stream: FirebaseFirestore.instance
                .collection('foods')
                .where('isRecommended', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              // Báo lỗi nếu có
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Đã xảy ra lỗi!', style: TextStyle(color: Colors.red)),
                );
              }
              // Hiển thị vòng xoay khi đang tải
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Nếu không có món ăn nào
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Chưa có món ăn được đề xuất!'),
                );
              }

              // 3. Hiển thị grid 2 cột
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // Lấy dữ liệu từ Firestore
                  var doc = snapshot.data!.docs[index];
                  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

                  return FoodCard(
                    foodId: doc.id,
                    name: data['name'] ?? 'Lỗi tên',
                    restaurantName: 'McDonald\'s',
                    price: (data['price'] ?? 0).toDouble(),
                    imageUrl: data['imageUrl'] ?? '',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
