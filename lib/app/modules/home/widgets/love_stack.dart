import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoveStack extends StatefulWidget {
  const LoveStack({super.key});

  @override
  State<LoveStack> createState() => LoveStackState();
}

class LoveStackState extends State<LoveStack>
    with SingleTickerProviderStateMixin {
  List<UserCardData> cards = [
    UserCardData("慢慢进步3", "assets/girl1.png"),
    UserCardData(
      "文静女孩11",
      "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    UserCardData(
      "慢慢进步2",
      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    ),
    UserCardData("可爱一点4", "assets/girl2.png"),
    UserCardData("努力工作5", "assets/girl3.png"),
  ];

  Offset cardOffset = Offset.zero;
  double rotate = 0;
  ({double width, double height}) cardStyle = (width: 360.0, height: 500.0);

  late final AnimationController _animationController;
  late Animation _slideAnimation;
  late Animation _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animationController.addListener(() {
      // print('controller ${_animationController.value}');
      // print('slide val ${_slideAnimation.value}');
      // print('rotate val  ${_rotateAnimation.value}');
      setState(() {
        cardOffset = _slideAnimation.value;
        rotate = _rotateAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int visibleCardCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 卡片叠加部分
          ...buildCards(visibleCardCount),
          buildActions(),
        ],
      ),
    );
  }

  //多张卡片
  List<Widget> buildCards(int visibleCardCount) {
    return cards.asMap().entries.toList().reversed.map((entry) {
      int index = entry.key;
      UserCardData data = entry.value;

      // 只显示前3张卡片（提高性能）
      if (index >= visibleCardCount) return Container();

      double scale = 1.0 - 0.03 * index;
      double offsetY = -20.0 * index;

      //  -(15 * index).toDouble()
      // 计算缩放和偏移（下面卡片逐层变化） 最大判定距离200
      // 拖动时 progress为0，只有在拖动时才会下移和放大
      double progress = (cardOffset.dx.abs() / cardStyle.width).clamp(0.0, 1.0);
      // print('$progress');
      if (index == 1) {
        scale += 0.08 * progress;
        offsetY += (20 + 10 * index) * progress;
      }
      return Positioned.fill(
        child: Center(
          child:
              index == 0
                  ? buildTopCard(data)
                  : buildCard(data, scale: scale, offsetY: offsetY),
        ),
      );
    }).toList();
  }

  // 第一张卡片
  GestureDetector buildTopCard(UserCardData data) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          cardOffset += details.delta;
          // print(details.localPosition);
          // 向左拖 cardOffset为负值
          // print(cardOffset);
          // 拖拽点在图片下半部分
          if (details.localPosition.dy < cardStyle.height / 2) {
            rotate = cardOffset.dx / 1500;
          } else {
            // 拖拽点在图片下半部分
            rotate = -cardOffset.dx / 1500;
          }
        });
      },
      onPanEnd: (_) {
        if (cardOffset.dx.abs() > 120) {
          // print('remove');
          removeTopCard();
        } else {
          // print('reset');
          resetCard();
        }
      },
      child: buildCard(data, offset: cardOffset, rotate: rotate),
    );
  }

  // 卡片
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
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              width: cardStyle.width,
              height: cardStyle.height + 120,
              child: Stack(
                children: [buildIMG(data), buildBottomStyle(), buildInfo(data)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 卡片图片
  Widget buildIMG(data) {
    return data.imagePath.contains('http')
        ? CachedNetworkImage(
          imageUrl: data.imagePath,
          width: cardStyle.width,
          height: cardStyle.height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: Colors.grey[300]),
          errorWidget: (context, url, error) => Icon(Icons.error),
        )
        : Image.asset(
          data.imagePath,
          width: cardStyle.width,
          height: cardStyle.height,
          fit: BoxFit.cover,
        );
  }

  // 底部样式
  Positioned buildBottomStyle() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: cardStyle.width,
          height: 150,
          // color: Colors.green,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87, Colors.black],
              stops: [0.0, 0.2, 1],
            ),
          ),
        ),
      ),
    );
  }

  // 卡片信息
  Positioned buildInfo(UserCardData data) {
    return Positioned(
      bottom: 120,
      left: 15,
      right: 15, // 添加right约束以便更好地控制布局
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),

          Text(
            ['播音主持', '文化', '传媒'].join(' · '),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Container(
                height: 30,
                constraints: BoxConstraints(minWidth: 50),
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.pink,
                ),
                child: Text(
                  '24',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: const Color.fromARGB(255, 84, 81, 81),
                ),
                child: Text(
                  '天秤座',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 84, 81, 81),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 30,
                    constraints: BoxConstraints(minWidth: 80),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: const Color.fromARGB(255, 84, 81, 81),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '查看资料',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 底部操作栏
  Widget buildActions() {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(Icons.refresh, Colors.yellow),
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Icon(
              Icons.clear,
              size: 30,
              color: const Color.fromARGB(255, 186, 134, 134),
            ),
          ),
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Icon(Icons.favorite, size: 30, color: Colors.pink),
          ),
          actionButton(Icons.star, Colors.blue),
        ],
      ),
    );
  }

  // 按钮
  Widget actionButton(IconData icon, Color color) {
    return InkWell(
      child: CircleAvatar(
        radius: 28,
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, size: 30, color: color),
      ),
    );
  }

  // 删除卡片
  void removeTopCard() {
    double screenWidth = MediaQuery.of(context).size.width;
    _slideAnimation = Tween<Offset>(
      begin: cardOffset,
      end: Offset(cardOffset.dx > 0 ? screenWidth : -screenWidth, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _rotateAnimation = Tween<double>(begin: rotate, end: rotate * 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward().then((_) {
      setState(() {
        cards.removeAt(0);
        // cardOffset = Offset.zero;
        // rotate = 0;
      });
      _initAnimation();
    });
  }

  // 下次拖动前，将上次拖动置位 Offset.zero  0
  // 否则下次拖动的start就是上次拖动的end
  void _initAnimation() {
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.reset();
  }

  void resetCard() {
    _slideAnimation = Tween<Offset>(
      begin: cardOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _rotateAnimation = Tween<double>(begin: rotate, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward().then((_) {
      _initAnimation();
    });
  }
}

class UserCardData {
  final String name;
  final String imagePath;

  UserCardData(this.name, this.imagePath);
}
