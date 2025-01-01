import 'package:flutter/material.dart';
import 'package:halqahquran/feature/pray_time/ui/widget/pray_card.dart';
import 'package:halqahquran/core/util/const_varible.dart';

class ListOfPrayTime extends StatelessWidget {
  const ListOfPrayTime({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: PrayCard(
          prayName: praysName[index],
          index: index,
        ),
      ),
      itemCount: praysName.length,
    );
  }
}
