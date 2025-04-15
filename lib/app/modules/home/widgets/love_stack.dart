import 'package:flutter/material.dart';

class LoveStack extends StatefulWidget {
  const LoveStack({super.key});

  @override
  State<LoveStack> createState() => LoveStackState();
}

class LoveStackState extends State<LoveStack> {
  List<UserCardData> cards = [
    UserCardData(
      "文静女孩1",
      "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    UserCardData(
      "短发气质2",
      "https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg",
    ),
    UserCardData(
      "慢慢进步3",
      "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    UserCardData(
      "慢慢进步4",
      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    ),
    UserCardData("慢慢进步5", "assets/girl1.png"),
    UserCardData("可爱一点6", "assets/girl2.png"),
    UserCardData("努力工作7", "assets/girl3.png"),
  ];

  Offset cardOffset = Offset.zero;
  double rotation = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 卡片叠加部分
          ...cards.asMap().entries.map((entry) {
            int index = entry.key;
            UserCardData data = entry.value;

            // 只显示前两张卡片（提高性能）
            if (index >= 2) return Container();

            bool isTopCard = index == 0;

            return Positioned.fill(
              child: Center(
                child:
                    isTopCard
                        ? GestureDetector(
                          onTap: () {
                            print('11');
                          },
                          onPanStart: (details) => {print('panstart')},
                          onPanUpdate: (details) {
                            setState(() {
                              cardOffset += details.delta;
                              rotation = cardOffset.dx / 300;
                            });
                          },
                          onPanEnd: (_) {
                            if (cardOffset.dx.abs() > 120) {
                              removeTopCard();
                            } else {
                              resetCard();
                            }
                          },
                          child: buildCard(data, cardOffset, rotation),
                        )
                        : buildCard(
                          data,
                          Offset.zero,
                          0.0,
                          scale: 0.95,
                          offsetY: 20,
                        ),
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
    UserCardData data,
    Offset offset,
    double angle, {
    double scale = 1.0,
    double offsetY = 0,
  }) {
    return Transform.translate(
      offset: offset + Offset(0, offsetY),
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image:
                    data.imagePath.contains('http')
                        ? NetworkImage(data.imagePath)
                        : AssetImage(data.imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Stack(
              children: [
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
      rotation = 0;
    });
  }

  void resetCard() {
    setState(() {
      cardOffset = Offset.zero;
      rotation = 0;
    });
  }
}

class UserCardData {
  final String name;
  final String imagePath;

  UserCardData(this.name, this.imagePath);
}
