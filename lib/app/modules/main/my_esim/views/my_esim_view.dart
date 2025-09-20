import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/build_image.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../common/widgets/smooth_rectangle_border.dart';
import '../controllers/my_esim_controller.dart';

class MyEsimView extends GetView<MyEsimController> {
  const MyEsimView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: _buildHeaderSection(context)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: [
                      esimCard(context),
                      esimGuideCard(),
                      20.sbh,
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 17.5,
                            backgroundColor: Color(0xFFD8D8D8),
                          ),
                          12.sbw,
                          Obx(()
                            => MyText(
                              text: controller.esimName.value + ' Plans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      16.sbh,
                      Padding(
                        padding: 10.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            color: R.theme.secondary,
                            borderRadius: 30.radius,
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: R.theme.primary,
                              borderRadius: 30.radius,
                            ),
                            labelColor: R.theme.white,
                            unselectedLabelColor: R.theme.white,
                            indicatorPadding: 5.all,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: R.theme.transparent,
                            tabs: [
                              Tab(text: 'Current Plans'),
                              Tab(text: 'Achieved Plans'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                CurrentPlanTabWidget(controller: controller),
                AchievedPlanTabWidget(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Stack(
      children: [

        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/header_background.svg",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),

        Padding(
          padding: 26.all,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: Icon(
                  Icons.person,
                  color: R.theme.primary,
                  size: 20,
                ),
              ),

              8.sbw,

              MyText(
                text: "Sign In",
                color: R.theme.white,
                fontSize: 12
              ),

              Spacer(),

              SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton.icon(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_add.svg',
                    height: 14,
                    width: 14,
                    fit: BoxFit.fill,
                    color: R.theme.white,
                  ),
                  label: MyText(
                    text: 'New eSIM',
                    fontSize: 12,
                    height: 0.66,
                    fontWeight: FontWeight.w600,
                    color: R.theme.white,
                  ),
                  onPressed: ()=>{

                  },
                  style: ElevatedButton.styleFrom(
                    padding: 8.all,
                    shadowColor: R.theme.transparent,
                    surfaceTintColor: R.theme.transparent,
                    backgroundColor: R.theme.primary,
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: 30.radius,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }

  Widget esimCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: 10.radius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF053189), Color(0xFF060D2A)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  children: [

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 17.5,
                          backgroundColor: const Color(0xFFD8D8D8),
                        ),

                        10.sbw,

                        Obx(() => MyText(
                          text: controller.esimName.value,
                          overflow: TextOverflow.ellipsis,
                          color: R.theme.white,
                          softWrap: true,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),

                        6.sbw,

                        InkWell(
                          onTap: () {
                            final TextEditingController nameController =
                            TextEditingController(text: controller.esimName.value);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF121A36),
                                  title: const Text("Edit eSIM Name", style: TextStyle(color: Colors.white54, fontSize: 14),),
                                  content: TextField(
                                    controller: nameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintText: "Enter new name",
                                      hintStyle: TextStyle(color: Colors.white54),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white24),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (nameController.text.trim().isNotEmpty) {
                                          controller.esimName.value = nameController.text.trim();
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/icons/ic_edit_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ],
                    ),

                    9.sbh,

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121A36),
                        borderRadius: 8.radius,
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Row(
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [

                                MyText(
                                  text: "ICCID",
                                  color: R.theme.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),

                                2.sbh,

                                MyText(
                                  text: controller.iccid,
                                  color: R.theme.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: controller.iccid));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${controller.iccid} copied')),
                              );
                            },
                            child: SvgPicture.asset('assets/icons/ic_copy_icon.svg', width: 18, height: 18,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              12.sbw,

              QrImageView(
                data: controller.iccid,
                version: QrVersions.auto,
                size: 75,
                foregroundColor: R.theme.white,
              ),

            ],
          ),

          16.sbh,

          Row(
            children: [

              const _ActionTile(
                icon: 'assets/icons/ic_manual_transmission.svg',
                size: 22,
                label: 'Manual Install',
              ),

              const _VerticalSep(),

              Column(
                children:
                [
                  SizedBox(
                    width: 62,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: R.theme.white,
                        shape: const StadiumBorder(),
                        minimumSize: Size(62, 30),
                        padding: EdgeInsets.zero,
                      ),
                      child: Icon(Icons.add, size: 24, color: R.theme.secondary),
                    ),
                  ),

                  8.sbh,

                  MyText(
                    text: 'Add New Plan',
                    color: R.theme.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              const _VerticalSep(),

              const _ActionTile(
                icon: 'assets/icons/ic_share.svg',
                size: 22,
                label: 'Share QR Code',
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget esimGuideCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: R.theme.secondary,
        borderRadius: 8.radius,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row
        (
          children: [

            SvgPicture.asset('assets/icons/ic_play_button.svg'),

            9.sbw,

            MyText(
              text: "Play eSim Installation Guide",
                color: R.theme.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
            ),

            Spacer(),

            Icon(
              Icons.chevron_right_rounded,
              color: R.theme.white,
              size: 22,
            ),
          ],
        ),
    );
  }

}

class CurrentPlanTabWidget extends StatelessWidget {
  CurrentPlanTabWidget({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.currentPlans.length,
        separatorBuilder: (_, __) => 16.sbh,
        itemBuilder: (context, index) {
          final plan = controller.currentPlans[index];
          return PlanCard(
            country: plan['country'],
            subtitle: plan['subtitle'],
            validUntil: plan['validUntil'],
            totalGb: plan['totalGb'],
            usedGb: plan['usedGb'],
            flagImage: plan['flagImage'],
            active: plan['active'],
            onFuelUp: () {
            },
          );
        },
      ),
    );
  }
}

class AchievedPlanTabWidget extends StatelessWidget {
  AchievedPlanTabWidget({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.achievedPlans.length,
        separatorBuilder: (_, __) => 16.sbh,
        itemBuilder: (context, index) {
          final plan = controller.achievedPlans[index];
          return PlanCard(
            country: plan['country'],
            subtitle: plan['subtitle'],
            validUntil: plan['validUntil'],
            totalGb: plan['totalGb'],
            usedGb: plan['usedGb'],
            flagImage: plan['flagImage'],
            active: plan['active'],
            onFuelUp: () {},
          );
        },
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String icon;
  final double size;
  final String label;
  const _ActionTile({required this.icon, required this.size ,required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [

          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: R.theme.secondary,
              shape: BoxShape.circle,
            ),
            padding: 8.all,
            child: SvgPicture.asset(icon, width: size, height: size),
          ),

          4.sbh,

          MyText(
            text: label,
            textAlign: TextAlign.center,
            color: R.theme.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _VerticalSep extends StatelessWidget {
  const _VerticalSep();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(.22),
            Colors.white.withOpacity(.06),
            Colors.white.withOpacity(.22),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String country;
  final String subtitle;
  final DateTime validUntil;
  final double totalGb;
  final double usedGb;
  final VoidCallback? onFuelUp;
  final String flagImage;
  final bool active;

  const PlanCard({
    super.key,
    required this.country,
    required this.subtitle,
    required this.validUntil,
    required this.totalGb,
    required this.usedGb,
    required this.flagImage,
    required this.active,
    this.onFuelUp,
  });

  @override
  Widget build(BuildContext context) {
    final leftGb = (totalGb - usedGb).clamp(0, totalGb);
    final pct = totalGb == 0 ? 0.0 : (leftGb / totalGb);
    final pctText = (pct * 100).toStringAsFixed(0);

    return Container(
      width: 330,
      height: 184,
      decoration: BoxDecoration(
        color: R.theme.white,
        borderRadius: 16.radius,
      ),
      child: Stack(
        children: [

          Positioned.fill(
            child: SvgPicture.asset(
              'assets/icons/ic_credit_card_background.svg',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    _StatusBadge(
                      text: active ? 'Active' : 'Expired',
                      color: active ? const Color(0xFFA0F695) : const Color(0xFFF3CECE),
                      textColor: active ? const Color(0xFF22A210) : const Color(0xFFFD0000),
                    ),
                    const Spacer(),
                    _FuelUpButton(onTap: onFuelUp, active: active),
                  ],
                ),

                6.sbh,

                Row(
                  children: [

                    ClipRRect(
                      borderRadius: 50.radius,
                      child: buildImage(
                        flagImage,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),

                    8.sbw,

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: country,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: R.theme.black,
                          ),

                          MyText(
                            text: subtitle,
                            fontSize: 10,
                            color: R.theme.grey,
                            height: 1.2,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                8.sbh,

                if (active)
                  MyText(
                  text: 'Valid until ${_fmtDate(validUntil)}',
                  fontSize: 10,
                  color: R.theme.black,
                  fontWeight: FontWeight.w500,
                ),

                2.sbh,

                MyText(
                  text: '${leftGb.toStringAsFixed(2)}GB ($pctText%) left of ${totalGb.toStringAsFixed(0)}GB',
                  fontSize: 10,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                  color: active ? R.theme.black : R.theme.red,
                ),

                10.sbh,

                ClipRRect(
                  borderRadius: 8.radius,
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFE2E6ED),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF123E68)),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return '$dd.$mm.$yy';
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _StatusBadge({
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(0.42),
        borderRadius: 30.radius,
        border: Border.all(color: color, width: 2),
      ),
      child: MyText(
        text: text,
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 9,
        height: 1.6
      ),
    );
  }
}

class _FuelUpButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool active;

  const _FuelUpButton({this.onTap, required this.active});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: 30.radius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF9C642B) : const Color(0xFF31D368),
          borderRadius: 30.radius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            SvgPicture.asset('assets/icons/ic_fuel_icon.svg', width: 21, height: 21),

            6.sbw,

            MyText(
              text: 'Fuel Up',
              color: R.theme.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}

