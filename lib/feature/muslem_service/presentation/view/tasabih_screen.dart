import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class TsbihScreen extends StatefulWidget {
  const TsbihScreen({super.key});

  @override
  State<TsbihScreen> createState() => _TsbihScreenState();
}

class _TsbihScreenState extends State<TsbihScreen> {
  List<Map<String, String>> tasbehZekr = [
    {
      "zekr": "سُبْحَانَ اللَّهِ",
      "desc": "يكتب له ألف حسنة أو يحط عنه ألف خطيئة (100مره)"
    },
    {
      "zekr": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ",
      "desc":
          "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ (100مره)"
    },
    {
      "zekr": "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ",
      "desc": "(100 مره) تَمْلَآَنِ مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ"
    },
    {
      "zekr": "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ",
      "desc": " (100 مره) غرست له نخلة في الجنة"
    },
    {
      "zekr": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ",
      "desc": "(اي عدد) ثقيلتان في الميزان حبيبتان إلى الرحمن"
    },
    {
      "zekr":
          "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ",
      "desc":
          "(100 مره)  كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان."
    },
    {
      "zekr": "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ",
      "desc": "كنز من كنوز الجنة"
    },
    {
      "zekr": "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ",
      "desc": "تملأ ميزان العبد بالحسنات."
    },
    {
      "zekr": "أستغفر الله",
      "desc": "لفعل الرسول صلى الله عليه وسلم",
    },
    {
      "zekr":
          "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ",
      "desc":
          "أنهن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات"
    },
    {
      "zekr": "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد",
      "desc": "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة."
    },
    {
      "zekr": "لَا إِلَهَ إِلَّا اللَّهُ",
      "desc": "أفضل الذكر لا إله إلاّ الله",
    },
    {
      "zekr": "الْلَّهُ أَكْبَرُ",
      "desc":
          "من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء.",
    },
    {
      "zekr":
          "سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي",
      "desc": "خير الدنيا والآخرة ",
    },
  ];

  int currentIndex = 0;
  List<int> counts = []; // Declare counts list

  @override
  void initState() {
    super.initState();
    counts = List.filled(
        tasbehZekr.length, 0); // Initialize counts based on tasbehZekr length
  }

  void _nextZekr() {
    setState(() {
      if (currentIndex < tasbehZekr.length - 1) {
        currentIndex++;
      }
    });
  }

  void _prevZekr() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void _incrementCount() {
    setState(() {
      counts[currentIndex]++;
    });
  }

  void _resetCount() {
    setState(() {
      counts[currentIndex] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppScreenUtil.getResponsiveHeight(context, .03),
            horizontal: 14),
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.centerRight,
              child: Text(
                "${tasbehZekr.length}/${currentIndex + 1}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 231, 231),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentIndex > 0
                            ? IconButton(
                                onPressed: _prevZekr,
                                icon: const Icon(Icons.arrow_back_ios))
                            : const SizedBox(
                                width: 48), // placeholder for alignment
                        Expanded(
                          child: Center(
                            child: Text(
                              tasbehZekr[currentIndex]['zekr'].toString(),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        currentIndex < tasbehZekr.length - 1
                            ? IconButton(
                                onPressed: _nextZekr,
                                icon: const Icon(Icons.arrow_forward_ios))
                            : const SizedBox(
                                width: 48), // placeholder for alignment
                      ],
                    ),
                    AppSize.hight(20),
                    Text(
                      tasbehZekr[currentIndex]['desc'].toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 77, 201, 164),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: _incrementCount,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: AppColor.primeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    counts[currentIndex].toString(),
                    style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.orange),
              child: IconButton(
                  onPressed: () {
                    _resetCount();
                  },
                  icon: const Icon(
                    Icons.replay_sharp,
                    size: 40,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
/**
 * do two list 
 * first for zekr
 * second for count zekr
 * 
 */