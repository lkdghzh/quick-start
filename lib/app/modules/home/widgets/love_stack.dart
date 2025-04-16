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
      "文静女孩1",
      "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    UserCardData(
      "慢慢进步2",
      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    ),
    // UserCardData("慢慢进步3", "assets/girl1.png"),
    // UserCardData("可爱一点4", "assets/girl2.png"),
    // UserCardData("努力工作5", "assets/girl3.png"),
  ];

  Offset cardOffset = Offset.zero;
  double rotate = 0;

  @override
  Widget build(BuildContext context) {
    const int visibleCardCount = 4;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 卡片叠加部分
          ...cards.asMap().entries.toList().reversed.map((entry) {
            int index = entry.key;
            UserCardData data = entry.value;

            // 只显示前两张卡片（提高性能）

            if (index >= visibleCardCount) return Container();
            // if (index >= 2) return const SizedBox.shrink();

            bool isTopCard = index == 0;
            // 计算缩放和偏移（下面卡片逐层变化）
            double progress = (cardOffset.dx.abs() / 200).clamp(0.0, 1.0);

            double scale = 1.0 - 0.03 * index;
            double offsetY = -20.0 * index;

            //  -(15 * index).toDouble()
            if (index == 1) {
              scale += 0.05 * progress;
              offsetY += (20 * index) * progress;
            }
            return Positioned.fill(
              child: Center(
                child:
                    isTopCard
                        ? GestureDetector(
                          // onTap: () {
                          //   print('11');
                          // },
                          onPanStart: (details) => {print('panstart')},
                          onPanUpdate: (details) {
                            // print(
                            //   'onPanUpdate ${details.delta}-${details.delta.dx}-${details.delta.dy} ${details.localPosition}',
                            // );
                            setState(() {
                              cardOffset += details.delta;
                              rotate = cardOffset.dx / 500;
                            });
                          },
                          onPanEnd: (_) {
                            print('onPanEnd $cardOffset');
                            if (cardOffset.dx.abs() > 80) {
                              removeTopCard();
                            } else {
                              resetCard();
                            }
                          },
                          child: buildCard(
                            data,
                            offset: cardOffset,
                            rotate: rotate,
                            offsetY: offsetY,
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
          alignment: Alignment.bottomCenter,
          angle: rotate,
          // child:ClipRRect(child: CachedNetworkImage(),)
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image:
                    data.imagePath.contains('http')
                        // 1.插件cached_network_image 可缓存
                        // 若已缓存，可本地读取，极快加载
                        // 不支持占位图和错误图（它是 ImageProvider）
                        ? CachedNetworkImageProvider(data.imagePath)
                        // ?2 NetworkImage(data.imagePath) 正常网络加载
                        // xxx 类型不能用? CachedNetworkImage(imageUrl: data.imagePath)
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
      rotate = 0;
    });
  }

  void resetCard() {
    setState(() {
      cardOffset = Offset.zero;
      rotate = 0;
    });
  }

  Image getimageWithLoadingAndCache(imagePath) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      cacheWidth: 800, // 推荐加上
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator()); // 可替换为透明占位
      },
    );
  }
}

class UserCardData {
  final String name;
  final String imagePath;

  UserCardData(this.name, this.imagePath);
}
