import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class LoveStack extends StatefulWidget {
  const LoveStack({super.key});

  @override
  State<LoveStack> createState() => LoveStackState();
}

class LoveStackState extends State<LoveStack> {
  List<UserCardData> cards = [
    UserCardData(
      "文静女孩11111221111",
      "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    UserCardData(
      "慢慢进步2",
      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    ),
    UserCardData("慢慢进步3", "assets/girl1.png"),
    UserCardData("可爱一点4", "assets/girl2.png"),
    UserCardData("努力工作5", "assets/girl3.png"),
  ];

  Offset cardOffset = Offset.zero;
  double rotate = 0;
  ({double width, double height}) cardStyle = (width: 350.0, height: 500.0);

  @override
  Widget build(BuildContext context) {
    const int visibleCardCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 卡片叠加部分
          ...cards.asMap().entries.toList().reversed.map((entry) {
            int index = entry.key;
            UserCardData data = entry.value;

            // print('$index ${data.name}');
            // 只显示前3张卡片（提高性能）
            if (index >= visibleCardCount) return Container();

            double scale = 1.0 - 0.03 * index;
            double offsetY = -20.0 * index;

            //  -(15 * index).toDouble()
            // 计算缩放和偏移（下面卡片逐层变化） 最大判定距离200
            // 拖动时 progress为0，只有在拖动时才会下移和放大
            double progress = (cardOffset.dx.abs() / cardStyle.width).clamp(
              0.0,
              1.0,
            );
            print('$progress');
            if (index == 1) {
              scale += 0.05 * progress;
              offsetY += (20 * index) * progress;
            }
            return Positioned.fill(
              child: Center(
                child:
                    index == 0
                        ? GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              cardOffset += details.delta;
                              // print(details.localPosition);
                              // 向左拖 cardOffset为负值
                              print(cardOffset);
                              // 拖拽点在图片下半部分
                              if (details.localPosition.dy <
                                  cardStyle.height / 2) {
                                rotate = cardOffset.dx / 1500;
                              } else {
                                // 拖拽点在图片下半部分
                                rotate = -cardOffset.dx / 1500;
                              }
                            });
                          },
                          onPanEnd: (_) {
                            if (cardOffset.dx.abs() > 120) {
                              removeTopCard();
                            } else {
                              resetCard();
                            }
                          },
                          child: buildCard(
                            data,
                            offset: cardOffset,
                            rotate: rotate,
                          ),
                        )
                        : buildCard(data, scale: scale, offsetY: offsetY),
              ),
            );
          }).toList(),

          // 底部操作栏
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                actionButton(Icons.refresh, Colors.yellow),
                actionButton(Icons.clear, Colors.black),
                actionButton(Icons.favorite, Colors.pink),
                actionButton(Icons.star, Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(
    UserCardData data, {
    Offset offset = Offset.zero,
    double rotate = 0,
    double scale = 1.0,
    double offsetY = 0,
  }) {
    return Transform.translate(
      offset: offset + Offset(0, offsetY),
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          alignment: Alignment.center,
          angle: rotate,
          child: Container(
            width: cardStyle.width,
            height: cardStyle.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  data.imagePath.contains('http')
                      ? CachedNetworkImage(
                        imageUrl: data.imagePath,
                        width: cardStyle.width,
                        height: cardStyle.height,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) =>
                                Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                      : Image.asset(
                        data.imagePath,
                        width: 350,
                        height: 500,
                        fit: BoxFit.cover,
                      ),
                  Positioned(
                    bottom: 20,
                    left: 15,
                    child: Text(
                      data.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, size: 30, color: color),
    );
  }

  void removeTopCard() {
    setState(() {
      cards.removeAt(0);
      cardOffset = Offset.zero;
      rotate = 0;
    });
  }

  void resetCard() {
    setState(() {
      cardOffset = Offset.zero;
      rotate = 0;
    });
  }
}

class UserCardData {
  final String name;
  final String imagePath;

  UserCardData(this.name, this.imagePath);
}
