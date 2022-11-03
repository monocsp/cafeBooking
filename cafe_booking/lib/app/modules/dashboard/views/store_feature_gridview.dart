import 'package:cafe_booking/uitilites/sources.dart';
import 'package:flutter/material.dart';

class StoreFeatureGridView extends StatelessWidget {
  const StoreFeatureGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
        childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
        mainAxisSpacing: space_xl, //수평 Padding
        crossAxisSpacing: space_xl, //수직 Padding
      ),
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
