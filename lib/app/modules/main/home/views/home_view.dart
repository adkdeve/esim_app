import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/circle_item.dart';
import '../../../../../common/widgets/custom_country_card.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';
import '../../card_details/controllers/card_details_controller.dart';
import '../../card_details/views/card_details_view.dart';
import '../../controllers/main_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  "assets/images/background.svg",
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                  allowDrawingOutsideViewBox: true,
                ),
              ),

              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(child: _buildHeaderSection(context)),
                  SliverToBoxAdapter(child: _buildCountrySection(context)),
                  SliverToBoxAdapter(child: 20.sbh),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: 20.horizontal,
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
                            Tab(text: 'Countries'),
                            Tab(text: 'Regional plan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: TabBarView(
                    children: [
                      CountriesTabWidget(),
                      RegionalPlanTabWidget(),
                    ],
                  )
                ),
              ),
            ],
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
            fit: BoxFit.fill,
          ),
        ),

        Container(
          padding: EdgeInsets.only(top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                IconButton(onPressed: Get.find<MainController>().openDrawer, icon: Icon(Icons.menu)),

                Spacer(),

                GestureDetector(
                    onTap: () {
                    },
                    child: SvgPicture.asset('assets/icons/ic_help_support.svg',)
                ),

              ],
            ),

            30.sbh,

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MyText(
                    text: 'Where are you travelling next?',
                    fontSize: 14,
                    color: R.theme.white,
                  ),

                  10.sbh,

                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: R.theme.secondary,
                        borderRadius: 15.radius,
                        boxShadow: [
                          BoxShadow(
                            color: R.theme.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          Icon(Icons.search,color: Color(0xff7a7a7a)),

                          8.sbw,

                          MyText(
                              text: 'Search your destination',
                              fontSize: 14,
                              color: Color(0xff7a7a7a)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            23.sbh,
          ],
        ),
      ),
      ]
    );
  }

  Widget _buildCountrySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
      decoration: BoxDecoration(
        color: R.theme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MyText(
            text: 'Popular',
            color: R.theme.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),

          10.sbh,

          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.popular.length,
              separatorBuilder: (_, __) => const SizedBox(width: 0),
              itemBuilder: (_, i) {
                final name = controller.popular[i]['name']!;
                final asset = controller.popular[i]['asset']!;
                return GestureDetector(
                    onTap: () {
                      Get.to(
                        GetBuilder<CardDetailsController>(
                          init: CardDetailsController(),
                          builder: (_) => CardDetailsView(countryName: name, imageUrl: asset),
                        ),
                      );
                    },
                    child: CircleItem(
                        name: name, imageUrl: asset, imageSize: 47, textSize: 12
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

class CountriesTabWidget extends StatelessWidget {
  const CountriesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 2,
      childAspectRatio: 1.5,
      children: [
        CustomCard(countryName: 'Qatar', imageUrl: 'https://flagcdn.com/w320/qa.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Qatar', imageUrl: 'https://flagcdn.com/w320/qa.png'),
            ),
          );
        }),
        CustomCard(countryName: 'China', imageUrl: 'https://flagcdn.com/w320/cn.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'China', imageUrl: 'https://flagcdn.com/w320/cn.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Cuba', imageUrl: 'https://flagcdn.com/w320/cu.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Cuba', imageUrl: 'https://flagcdn.com/w320/cu.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Egypt', imageUrl: 'https://flagcdn.com/w320/eg.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Egypt', imageUrl: 'https://flagcdn.com/w320/eg.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Israel', imageUrl: 'https://flagcdn.com/w320/il.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Israel', imageUrl: 'https://flagcdn.com/w320/il.png'),
            ),
          );
        }),
        CustomCard(countryName: 'England', imageUrl: 'https://flagcdn.com/w320/gb.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'England', imageUrl: 'https://flagcdn.com/w320/gb.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Poland', imageUrl: 'https://flagcdn.com/w320/pl.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Poland', imageUrl: 'https://flagcdn.com/w320/pl.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Switzerland', imageUrl: 'https://flagcdn.com/w320/ch.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Switzerland', imageUrl: 'https://flagcdn.com/w320/ch.png'),
            ),
          );
        }),
        CustomCard(countryName: 'New Zealand', imageUrl: 'https://flagcdn.com/w320/nz.png', imageSize: 50, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'New Zealand', imageUrl: 'https://flagcdn.com/w320/nz.png'),
            ),
          );
        }),
      ],
    );
  }
}

class RegionalPlanTabWidget extends StatelessWidget {
  const RegionalPlanTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: [
        CustomCard(countryName: 'Global', imageUrl: 'assets/images/ic_global.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Global', imageUrl: 'assets/images/ic_global.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Europe', imageUrl: 'assets/images/ic_europe.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Europe', imageUrl: 'assets/images/ic_europe.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Australia', imageUrl: 'assets/images/ic_australia.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Australia', imageUrl: 'assets/images/ic_australia.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Latin America', imageUrl: 'assets/images/ic_america.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Latin America', imageUrl: 'assets/images/ic_america.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Africa', imageUrl: 'assets/images/ic_africa.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Africa', imageUrl: 'assets/images/ic_africa.png'),
            ),
          );
        }),
        CustomCard(countryName: 'Asia', imageUrl: 'assets/images/ic_asia.png', imageSize: 48, textSize: 14, onTap: () {
          Get.to(
            GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) => CardDetailsView(countryName: 'Asia', imageUrl: 'assets/images/ic_asia.png'),
            ),
          );
        }),

      ],
    );
  }
}
