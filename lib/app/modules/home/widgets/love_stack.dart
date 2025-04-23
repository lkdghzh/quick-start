import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../models/user.dart';
import '../../../widgets/image.dart';
import '../../../modules/user/view.dart';
import '../../../modules/user/controller.dart';
import '../../user/bindings.dart';

class LoveStack extends StatefulWidget {
  const LoveStack({super.key});

  @override
  State<LoveStack> createState() => LoveStackState();
}

class LoveStackState extends State<LoveStack>
    with SingleTickerProviderStateMixin {
  List<User> cards = [
    User(
      id: "1",
      name: "慢慢进步3",
      job: "播音主持",
      location: "在北京",
      marriage: "未婚",
      gender: "女",
      age: "24岁",
      avatar: "assets/girl1.png",
    ),
    User(
      id: "2",
      name: "文静女孩11",
      job: "设计师",
      location: "在上海",
      marriage: "未婚",
      gender: "女",
      age: "25岁",
      avatar:
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
    ),
    User(
      id: "3",
      name: "慢慢进步2",
      job: "产品经理",
      location: "在广州",
      marriage: "未婚",
      gender: "女",
      age: "26岁",
      avatar:
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    ),
    User(
      id: "4",
      name: "可爱一点4",
      job: "教师",
      location: "在深圳",
      marriage: "未婚",
      gender: "女",
      age: "23岁",
      avatar: "assets/girl2.png",
    ),
    User(
      id: "5",
      name: "努力工作5",
      job: "医生",
      location: "在成都",
      marriage: "未婚",
      gender: "女",
      age: "27岁",
      avatar: "assets/girl3.png",
    ),
  ];

  Offset cardOffset = Offset.zero;
  double rotate = 0;
  ({double width, double height}) cardStyle = (width: 360.0.w, height: 500.0.h);

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
      User data = entry.value;

      // 只显示前3张卡片（提高性能）
      if (index >= visibleCardCount) return Container();

      double scale = 1.0 - 0.03 * index;
      double offsetY = -20.0.h * index;

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
  GestureDetector buildTopCard(User data) {
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
        if (cardOffset.dx.abs() > 100) {
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
    User data, {
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
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: Container(
              width: cardStyle.width,
              height: cardStyle.height + 120.h,
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
  Widget buildIMG(User data) {
    return Hero(
      tag: 'user-avatar-${data.id}',
      child: CommonImage(
        imageUrl: data.avatar,
        width: cardStyle.width,
        height: cardStyle.height,
      ),
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
          height: 150.h,
          // color: Colors.green,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
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
  Positioned buildInfo(User data) {
    return Positioned(
      bottom: 120.h,
      left: 15.w,
      right: 15.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          Text(
            [
              data.job ?? '',
              data.location ?? '',
              data.marriage ?? '',
            ].join(' · '),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              Container(
                height: 30.h,
                constraints: BoxConstraints(minWidth: 50.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  color: Colors.pink,
                ),
                child: Text(
                  data.age ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
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
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.CHAT_DETAIL,
                        arguments: {
                          'id': data.id,
                          'name': data.name,
                          'avatar': data.avatar,
                        },
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: const Color.fromARGB(255, 84, 81, 81),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      print('查看资料');
                      final args = {
                        'id': data.id,
                        'name': data.name,
                        'avatar': data.avatar,
                        'age': data.age,
                        'gender': data.gender,
                        'location': data.location,
                        'job': data.job,
                        'marriage': data.marriage,
                        'bio': '喜欢旅行、摄影、美食，希望能遇到一个有趣的灵魂～',
                        'interests': [data.job ?? '', '旅行', '摄影', '美食', '电影'],
                        'photos': [
                          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
                          'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg',
                        ],
                      };

                      Get.to(
                        () => const UserPage(),
                        arguments: args,
                        opaque: false,
                        fullscreenDialog: true,
                        binding: UserBinding(),
                        // transition: Transition.topLevel,
                      );
                    },
                    child: Container(
                      height: 30.h,
                      constraints: BoxConstraints(minWidth: 80.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        color: const Color.fromARGB(255, 84, 81, 81),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '查看资料',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
      bottom: 60.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(Icons.refresh, Colors.yellow),
          Container(
            width: 80.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: Colors.white,
            ),
            child: Icon(
              Icons.clear,
              size: 30.sp,
              color: const Color.fromARGB(255, 186, 134, 134),
            ),
          ),
          Container(
            width: 80.h,
            height: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: Colors.white,
            ),
            child: Icon(Icons.favorite, size: 30.sp, color: Colors.pink),
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
        radius: 28.r,
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, size: 30.sp, color: color),
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
