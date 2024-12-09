import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_pet_controller.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/PassButton.dart';
import 'package:intl/intl.dart'; // 导入 intl 包

class ChoosePetInfoView extends GetView<AddPetController> {
  const ChoosePetInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("宠物资料"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Obx(() => selectionBox(
                    "性别", controller.selectedGender, ["弟弟", "妹妹"], 0)),
                const SizedBox(height: 15),
                Obx(() => selectionBox(
                    "绝育", controller.selectedSterilized, ["已绝育", "未绝育"], 1)),
                const SizedBox(height: 15),

                Obx(() => dateSelectionBox(
                    "生日", controller.selectedBirthday.toString(), 4)),
                const SizedBox(height: 15),
                Obx(() => dateSelectionBox(
                    "到家日", controller.selectedArrivalDay.toString(), 5)),
                const SizedBox(height: 15),
                weightInput(), // 输入体重
                const SizedBox(height: 15),
                Obx(() => selectionBox("花色", controller.selectedColor,
                    ["请选择", "白色", "黑色", "棕色"], 2)),
                PassButton(
                  text: "      完成      ",
                  onPressed: () async {
                    // 处理完成按钮逻辑
                    if (controller.selectedGender.isEmpty) {
                      Get.snackbar("提示信息", "性别未选择");
                      return;
                    }

                    if (controller.selectedSterilized.isEmpty) {
                      Get.snackbar("提示信息", "绝育状态未选择");
                      return;
                    }

                    if (controller.selectedBirthday.isEmpty) {
                      Get.snackbar("提示信息", "生日未选择");
                      return;
                    }

                    if (controller.selectedArrivalDay.isEmpty) {
                      Get.snackbar("提示信息", "到家日未选择");
                      return;
                    }
                    if (controller.selectedColor.isEmpty) {
                      Get.snackbar("提示信息", "颜色未选择");
                      return;
                    }
                    //下一步
                    Get.toNamed("/info_display_view");
                  },
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.toNamed("/info_display_view");
                  },
                  child: const Opacity(
                    opacity: 0.50,
                    child: Text(
                      '不确定，先跳过',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 选择框
  Widget selectionBox(
      String label, RxString selectedValue, List<String>? items, int type) {
    return Container(
      width: 350,
      height: 50,
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Expanded(
            child: Obx(() => SizedBox(
                  child: Text(
                    selectedValue.value.isEmpty ? "未选择" : selectedValue.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )),
          ),
          DropdownButton<String>(
            hint: Text("请选择"),
            items: items?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            elevation: 1,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              if (newValue != null) {
                selectedValue.value = newValue; // Update the selected value
                controller.updateValue(newValue, type);
              }
            },
          ),
        ],
      ),
    );
  }

  // 日期选择框
  Widget dateSelectionBox(String label, String time, int type) {
    DateTime? selectedDate;

    return GestureDetector(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: Get.context!,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (date != null) {
          selectedDate = date;
          // 使用 DateFormat 格式化日期为 "yyyy-MM-dd" 格式
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
          print('选择的日期: $formattedDate'); // 打印选择的日期
          controller.updateValue(formattedDate, type);
        }
      },
      child: Container(
        width: 350,
        height: 50,
        padding: const EdgeInsets.all(15),
        decoration: ShapeDecoration(
          color: const Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              width: 205,
              child: Text(
                selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                    : time ?? "未选择",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  // 输入体重
  Widget weightInput() {
    TextEditingController weightController = TextEditingController();
    int type = 3;
    return Container(
      width: 350,
      height: 50,
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 80,
            child: Text(
              "体重",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft, // 左侧对齐
              child: TextField(
                controller: weightController,
                decoration: const InputDecoration(
                  hintText: "输入体重",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8), // 设置上下内边距
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.updateValue(value, type);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
