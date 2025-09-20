import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Terms & Condition", fontSize: 20),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
              allowDrawingOutsideViewBox: true,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: 16.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MyText(text: "Condition & Attending", fontSize: 18, textAlign: TextAlign.start),

                  10.sbh,

                  MyText(
                    text: "At enim hic etiam dolore. Dulce amarum, leve asperum, prope longe, stare movere, quadratum rotundum. At certe gravius. Nullus est igitur cuiusquam dies natalis. Paulum, cum regem Persem captum adduceret, eodem flumine invectio?\n\n"
                      "\n\n"
                      "Quare hoc videndum est, possitne nobis hoc ratio philosophorum dare.\n\n"
                      "Sed finge non solum callidum eum, qui aliquid improbe faciat, verum etiam praepotentem, ut M.\n\n"
                      "Est autem officium, quod ita factum est, ut eius facti probabilis ratio reddi possit.\n\n",
                    fontSize: 14,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    height: 1.3,
                  ),

                  20.sbh,

                  MyText(text: "Terms & Use", fontSize: 18, textAlign: TextAlign.start),

                  10.sbh,

                  MyText(
                    text: "Ut proverbia non nulla veriora sint quam vestra dogmata. Tamen aberramus a proposito, et, ne longius, prorsus, inquam, Piso, si ista mala sunt, placet. Omnes enim iucundum motum, quo sensus hilaretur. Cum id fugiunt, re eadem defendunt, quae Peripatetici, verba. Quibusnam praeteritis? Portenta haec esse dicit, quidem hactenus; Si id dicis, vicimus. Qui ita affectus, beatum esse numquam probabis; Igitur neque stultorum quisquam beatus neque sapientium non beatus.\n\n"
                      "\n\n"
                      "Dicam, inquam, et quidem discendi causa magis, quam quo te aut Epicurum reprehensum velim. Dolor ergo, id est summum malum, metuetur semper, etiamsi non ader.",
                    fontSize: 14,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    height: 1.3,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
