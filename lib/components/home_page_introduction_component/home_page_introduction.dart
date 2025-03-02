 import 'package:Mada/structure_main_flow/flutter_mada_theme.dart';
import 'package:Mada/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page_introduction_component_model.dart';

class HomePageIntroductionComponent extends StatefulWidget {
  const HomePageIntroductionComponent({super.key});

  @override
  State<HomePageIntroductionComponent> createState() =>
      _HomePageIntroductionComponentState();
}

class _HomePageIntroductionComponentState
    extends State<HomePageIntroductionComponent> {
  late HomePageIntroductionComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageIntroductionComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postBuild(
          context,
          isRight: true,
          pageTitleEn: 'About Us',
          pageTitleAr: 'من نحن',
          titleEn: 'When you visit our restaurant',
          titleAr: 'عند زيارتك لمطعمنا',
          bodyEn:
              'At Tastee Chicken To Go, we’re all about serving up fresh, delicious, and flavorful chicken that’s perfect for every craving. Whether you’re in the mood for crispy fried chicken, juicy grilled options, or tasty sides, we’ve got you covered.\nOur mission is simple: to deliver mouthwatering meals quickly and with a smile. Whether you’re dining in, taking it to go, or ordering delivery, Tastee Chicken To Go is here to satisfy your hunger with quality you can taste and service you’ll love.\nGreat food. Fast service. Unbeatable flavor. That’s the Tastee Chicken To Go promise!',
          bodyAr:
              'في تاستي تشيكن تو جو، نحن نحرص على تقديم الدجاج الطازج واللذيذ المليء بالنكهات الرائعة، ليناسب كل رغباتك. سواء كنت تشتهي الدجاج المقلي المقرمش، أو المشوي الطري، أو الأطباق الجانبية الشهية، فإننا نوفر لك كل ما تحتاجه.\nمهمتنا بسيطة: تقديم وجبات شهية بسرعة وبابتسامة. سواء كنت تتناول طعامك داخل المطعم، تأخذه معك، أو تطلبه للتوصيل، فإن تاستي تشيكن تو جو هنا لإشباع جوعك بجودة يمكنك تذوقها وخدمة ستعشقها.\nطعام رائع. خدمة سريعة. نكهة لا تُقاوَم. هذا هو وعد تاستي تشيكن تو جو!',
          imagePath: 'assets/images/burger.png',
          buttonTextEn: 'Read more',
          buttonTextAr: 'أقرأ المزيد',
        ),
        postBuild(
          context,
          isRight: false,
          pageTitleEn: 'Restaurant Menu',
          pageTitleAr: 'قائمة المطعم',
          titleEn: 'Always Fresh Ingredients',
          titleAr: 'مكونات طازجة دائمًا',
          bodyEn:
              'At Tastee Chicken To Go, freshness is our secret ingredient. We take pride in crafting every dish with the highest quality, farm-fresh ingredients to ensure bold flavors in every bite. From our perfectly seasoned chicken to our freshly prepared sides, every item on our menu is made to satisfy.\nWhether you’re craving crispy fried chicken, tender grilled options, or wholesome salads, we guarantee every meal is made fresh and served with care. At Tastee Chicken To Go, freshness isn’t just a promise—it’s our way of life.\nTaste the difference of always fresh, never frozen ingredients today',
          bodyAr:
              'في تاستي تشيكن تو جو، السر وراء نكهاتنا اللذيذة هو الطزاجة! نحن نفتخر بتحضير كل طبق باستخدام أجود المكونات الطازجة مباشرة من المزارع، لضمان نكهات غنية في كل لقمة. من دجاجنا المتبل بعناية إلى الأطباق الجانبية المحضرة يوميًا، كل عنصر في قائمتنا مصنوع خصيصًا لإرضاء ذوقك.\nسواء كنت تشتهي الدجاج المقلي المقرمش، المشوي الطري، أو السلطات الصحية، نضمن لك أن كل وجبة يتم تحضيرها طازجة وتُقدَّم بعناية. في تاستي تشيكن تو جو، الطزاجة ليست مجرد وعد – بل هي أسلوب حياتنا.\nاستمتع بالنكهة الحقيقية لمكونات طازجة دائمًا، دون أي تجميد!',
          imagePath: 'assets/images/fresh_food.png',
          buttonTextEn: 'View Menu',
          buttonTextAr: 'عرض القائمة',
        ),
        postBuild(
          context,
          isRight: true,
          pageTitleEn: 'Our Team',
          pageTitleAr: 'فريقنا',
          titleEn: 'Use the Tips & Recipes of Our Chefs',
          titleAr: 'استخدم نصائح ووصفات طهاتنا',
          bodyEn:
              'At Tastee Chicken To Go, our team is the heart and soul of everything we do. From our skilled chefs to our friendly servers, each member is dedicated to delivering the freshest, most delicious meals with exceptional service.\nWe share a passion for great food and a commitment to quality, working together to ensure every bite exceeds your expectations. Our team’s attention to detail, creativity, and love for what we do make Tastee Chicken To Go a place where flavor meets care.\nIt’s not just about food—it’s about creating an experience. Come see the difference our team makes!',
          bodyAr:
              'في تاستي تشيكن تو جو، يُعد فريقنا القلب النابض لكل ما نقوم به. من طهاتنا المهرة إلى موظفينا الودودين، يكرّس كل فرد في فريقنا جهوده لتقديم أشهى الأطباق الطازجة مع خدمة استثنائية.\nنحن نشارك شغفًا حقيقيًا بالطعام الرائع والتزامًا بالجودة، ونعمل معًا لضمان أن كل لقمة تتجاوز توقعاتك. بفضل اهتمام فريقنا بأدق التفاصيل، إبداعه، وحبه لما يقدمه، أصبح تاستي تشيكن تو جو المكان الذي تلتقي فيه النكهة بالعناية.\nالأمر لا يتعلق بالطعام فقط، بل بتجربة متكاملة. تعال واكتشف الفرق الذي يصنعه فريقنا!',
          imagePath: 'assets/images/our_team.png',
          buttonTextEn: 'Meet the Team',
          buttonTextAr: 'تعرف على الفريق',
        ),
      ],
    );
  }

  Widget postBuild(
    BuildContext context, {
    required bool isRight,
    required String pageTitleEn,
    required String pageTitleAr,
    required String titleEn,
    required String titleAr,
    required String bodyEn,
    required String bodyAr,
    required String imagePath,
    required String buttonTextEn,
    required String buttonTextAr,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(64, 0, 32, 0),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Row(
          children: [
            isRight
                ? Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 5,
                              width: 57,
                              color: const Color(0xffF29D38),
                            ),
                            const Gap(16),
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: pageTitleEn, arText: pageTitleAr),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ).withFont(
                                fontFamily: AppFonts.radioCanada,
                                fontWeight: AppFonts.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          FFLocalizations.of(context).getVariableText(
                              enText: titleEn, arText: titleAr),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                          ).withFont(
                            fontFamily: AppFonts.radioCanada,
                            fontWeight: AppFonts.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const Gap(16),
                        Text(
                          FFLocalizations.of(context)
                              .getVariableText(enText: bodyEn, arText: bodyAr),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ).withFont(
                            fontFamily: AppFonts.quicksand,
                            fontWeight: AppFonts.regular,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Gap(16),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xffF29D38),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: buttonTextEn, arText: buttonTextAr),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ).withFont(
                                fontFamily: AppFonts.radioCanada,
                                fontWeight: AppFonts.regular,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        )
                      ],
                    ))
                : Expanded(
                    flex: 4,
                    child: Image.asset(
                      imagePath,
                    ),
                  ),
            const Gap(32),
            isRight
                ? Expanded(
                    flex: 4,
                    child: Image.asset(
                      imagePath,
                    ),
                  )
                : Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 5,
                              width: 57,
                              color: const Color(0xffF29D38),
                            ),
                            const Gap(16),
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: pageTitleEn, arText: pageTitleAr),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ).withFont(
                                fontFamily: AppFonts.radioCanada,
                                fontWeight: AppFonts.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          FFLocalizations.of(context).getVariableText(
                              enText: titleEn, arText: titleAr),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                          ).withFont(
                            fontFamily: AppFonts.radioCanada,
                            fontWeight: AppFonts.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const Gap(16),
                        Text(
                          FFLocalizations.of(context)
                              .getVariableText(enText: bodyEn, arText: bodyAr),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ).withFont(
                            fontFamily: AppFonts.quicksand,
                            fontWeight: AppFonts.regular,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Gap(16),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xffF29D38),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              FFLocalizations.of(context).getVariableText(
                                  enText: 'Read more', arText: 'أقرأ المزيد'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ).withFont(
                                fontFamily: AppFonts.radioCanada,
                                fontWeight: AppFonts.regular,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        )
                      ],
                    )),
          ],
        ),
      ),
    );
  }
}
