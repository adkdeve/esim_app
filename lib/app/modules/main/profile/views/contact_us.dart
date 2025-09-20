import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/main/profile/controllers/profile_controller.dart';
import 'package:pcom_app/common/widgets/custom_text_field.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';

class ContactUSView extends GetView<ProfileController> {
  const ContactUSView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Contact Us', fontSize: 20),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  MyText(text: 'Lets Get In Touch With Our Team.', fontSize: 20, height: 1.55, textAlign: TextAlign.center, softWrap: true,),

                  24.sbh,

                  Row(
                    children: [
                      Icon(Icons.phone, color: R.theme.primary),

                      18.sbw,

                      MyText(text: '+18776521644', fontSize: 16, height: 1.7)
                    ],
                  ),

                  17.sbh,

                  Row(
                    children: [
                      Icon(Icons.email, color: R.theme.primary),

                      18.sbw,

                      MyText(text: 'Info@wilixifysoft.com', fontSize: 16, height: 1.7)
                    ],
                  ),

                  17.sbh,

                  Row(
                    children: [
                      Icon(Icons.location_on, color: R.theme.primary),

                      18.sbw,

                      Container(
                        constraints: BoxConstraints(maxWidth: 250),
                          child: MyText(text: '15442 Ventura Blvd Sherman Oaks CA 91403', fontSize: 16, height: 1.7, softWrap: true, textAlign: TextAlign.start))
                    ],
                  ),

                  29.sbh,

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyText(text: 'We will respons as soon as possible', fontSize: 20, height: 1.55, textAlign: TextAlign.center,softWrap: true,),
                  ),

                  23.sbh,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child:
                          CustomTextField(
                            label: 'First Name',
                            controller: controller.name,
                            hintText: 'Emily',
                            borderClr: Color(0xff0052b3),
                          )
                      ),
                      16.sbw,
                      Expanded(
                          child:
                          CustomTextField(
                            label: 'Last Name',
                            controller: controller.name,
                            hintText: 'John',
                            borderClr: Color(0xff0052b3),
                          )
                      )
                    ],
                  ),

                  20.sbh,

                  CustomTextField(
                    label: 'Email',
                    hintText: 'emily@untitledui.com',
                    controller: controller.email,
                    borderClr: Color(0xff0052b3),
                  ),

                  20.sbh,

                  CustomTextField(
                    label: 'Subject',
                    hintText: 'Abc',
                    controller: controller.name,
                    borderClr: Color(0xff0052b3),
                  ),

                  20.sbh,

                  CustomTextField(
                    label: 'Message',
                    hintText: 'Abc',
                    controller: controller.name,
                    borderClr: Color(0xff0052b3),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: PrimaryButton(color: R.theme.primary, text: 'Send Message', onPressed: () => {}),
        ),
      ),
    );
  }
}
