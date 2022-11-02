import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cafe_booking/screens/dashboard/controller/dashboard_controller.dart';
import 'package:cafe_booking/uitilites/sources.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final list = [1, 2, 3, 4];
final list2 = [1, 2, 3, 4, 5, 6];

class MainDashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: Get.size.height / 3,
            color: Colors.deepPurple[100],
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.flutter_dash,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedFlipCounter(
                  thousandSeparator: ',',
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  value: 12000,
                  prefix: '\u{20A9}',
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: Get.size.height / 4.5,
            width: Get.size.width,
            child: carouselSliderBuilder(),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: controller.isSelected.value == -1
                  ? const SizedBox(
                      key: ValueKey(0),
                    )
                  : widgetElement(key: const ValueKey(1)),
            ),
          )
        ]),
      ),
    );
  }

  Widget carouselSliderBuilder() {
    return CarouselSlider.builder(
        options: CarouselOptions(
            aspectRatio: 1.0,
            padEnds: false,
            viewportFraction: 0.5,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {},
            autoPlay: false),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (controller.isSelected.value == itemIndex) {
                controller.isSelected(-1);
                return;
              }
              controller.isSelected(itemIndex);
            },
            child: Obx(
              () => Card(
                color: controller.isSelected.value == itemIndex ? primeColor : null,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.settings,
                              )),
                          Center(
                            child: Icon(
                              Icons.coffee,
                              size: Get.size.height / 10,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '커피명가',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          '호산점',
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //달별 벌어들인 곳
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: AnimatedFlipCounter(
                                    thousandSeparator: ',',
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    value: 240000,
                                    prefix: '\u{20A9}',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }

  Widget widgetElement({Key? key}) {
    return Column(
      key: key,
      children: [
        for (final i in list2)
          SizedBox(
            height: 70,
            width: Get.size.width,
            child: Container(
                child: Center(
              child: controller.isSelected.value == 1
                  ? Icon(Icons.ac_unit)
                  : Icon(Icons.access_alarm_outlined),
            )),
          )
      ],
    );
  }
}
