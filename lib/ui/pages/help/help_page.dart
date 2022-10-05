import 'package:flutter/widgets.dart';
import 'package:kopi/ui/pages/help/custom_step_bantuan.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: content(),
    );
  }

  Widget content() {
    return ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 30),
      children: const [
        SizedBox(height: 20),
        CustomStepBantuan(
            imgUrl: "assets/image/image_bantuan1.png",
            step: "Step 1",
            text:
                "Kopi adalah minuman hasil seduhan biji kopi yang telah disangrai dan dihaluskan menjadi bubuk. "),
        CustomStepBantuan(
            isLeft: true,
            imgUrl: "assets/image/image_bantuan2.png",
            step: "Step 2",
            text:
                "Kopi adalah minuman hasil seduhan biji kopi yang telah disangrai dan dihaluskan menjadi bubuk. "),
        CustomStepBantuan(
            imgUrl: "assets/image/image_bantuan3.png",
            step: "Step 3",
            text:
                "Kopi adalah minuman hasil seduhan biji kopi yang telah disangrai dan dihaluskan menjadi bubuk. ")
      ],
    );
  }
}
