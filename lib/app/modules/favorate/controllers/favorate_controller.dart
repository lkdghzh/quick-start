import "package:get/get.dart";
import "../../../models/user.dart";
import "../../../routes/routes.dart";

class FavorateController extends GetxController {
  final RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 模拟数据
    users.addAll([
      User(
        id: "1",
        name: "爱自由，爱追寻",
        job: "软件工程师",
        location: "在北京",
        marriage: "未婚",
        gender: "女",
        age: "28岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "2",
        name: "一生不羁爱自由",
        job: "金融分析师",
        location: "在北京",
        marriage: "未婚",
        gender: "女",
        age: "34岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "3",
        name: "想法太多的名称",
        job: "程序员",
        location: "在北京",
        marriage: "未婚",
        gender: "女",
        age: "18岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "4",
        name: "春雨的宇宙",
        job: "学生",
        location: "在北京",
        marriage: "未婚",
        gender: "女",
        age: "21岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "5",
        name: "追梦人",
        job: "产品经理",
        location: "在上海",
        marriage: "未婚",
        gender: "女",
        age: "26岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "6",
        name: "星空漫步",
        job: "UI设计师",
        location: "在广州",
        marriage: "未婚",
        gender: "女",
        age: "25岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "7",
        name: "微风细雨",
        job: "教师",
        location: "在深圳",
        marriage: "未婚",
        gender: "女",
        age: "27岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "8",
        name: "晨曦初露",
        job: "医生",
        location: "在成都",
        marriage: "未婚",
        gender: "女",
        age: "29岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "9",
        name: "云端漫步",
        job: "律师",
        location: "在杭州",
        marriage: "未婚",
        gender: "女",
        age: "31岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
      User(
        id: "10",
        name: "静水流深",
        job: "会计师",
        location: "在武汉",
        marriage: "未婚",
        gender: "女",
        age: "24岁",
        avatar:
            "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      ),
    ]);
  }

  void viewDetails(int index) {
    final user = users[index];
    Get.toNamed("/user/details", arguments: user.toJson());
  }

  void sendGreeting(int index) {
    final user = users[index];
    Get.toNamed(Routes.CHAT_DETAIL, arguments: {"userId": user.id});
  }
}
