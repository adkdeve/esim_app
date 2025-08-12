import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_country_card.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';
import '../controllers/home_controller.dart';

class DataEsims extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: R.theme.white,
        title: MyText(text: 'Data eSIM', fontSize: 20, textAlign: TextAlign.center, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 16.all,
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Where are you travelling next?',
                  fontSize: 12,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.bold,
                ),
              ),

              10.sbh,

              GestureDetector(
                onTap: () {
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: R.theme.black,
                    borderRadius: 15.radius,
                    boxShadow: [
                      BoxShadow(
                        color: R.theme.white.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [

                      Icon(Icons.search, color: R.theme.color500),

                      8.sbw,

                      MyText(
                        text: 'Search your destination',
                        fontSize: 14,
                        color: R.theme.color500,
                      ),
                    ],
                  ),
                ),
              ),

              20.sbh,

              DefaultTabController(
                length: 2,
                child: Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: 30.radius,
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: R.theme.primary,
                          borderRadius: 30.radius,
                        ),
                        labelColor: R.theme.white,
                        unselectedLabelColor: R.theme.black,
                        indicatorPadding: 5.all,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: R.theme.transparent,
                        tabs: [
                          Tab(text: 'Countries'),
                          Tab(text: 'Regional plan'),
                        ],
                      ),
                    ),

                    20.sbh,

                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: TabBarView(
                        children: [
                          CountriesTabWidget(),
                          RegionalPlanTabWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountriesTabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: [
        CustomCard(countryName: 'Qatar', flagAsset: 'https://flagcdn.com/w320/qa.png'),
        CustomCard(countryName: 'China', flagAsset: 'https://flagcdn.com/w320/cn.png'),
        CustomCard(countryName: 'Cuba', flagAsset: 'https://flagcdn.com/w320/cu.png'),
        CustomCard(countryName: 'Egypt', flagAsset: 'https://flagcdn.com/w320/eg.png'),
        CustomCard(countryName: 'Israel', flagAsset: 'https://flagcdn.com/w320/il.png'),
        CustomCard(countryName: 'England', flagAsset: 'https://flagcdn.com/w320/gb.png'),
        CustomCard(countryName: 'Poland', flagAsset: 'https://flagcdn.com/w320/pl.png'),
        CustomCard(countryName: 'Switzerland', flagAsset: 'https://flagcdn.com/w320/ch.png'),
        CustomCard(countryName: 'New Zealand', flagAsset: 'https://flagcdn.com/w320/nz.png'),
      ],
    );
  }
}

class RegionalPlanTabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: [
        CustomCard(countryName: 'Global', flagAsset: 'assets/images/ic_global.png'),
        CustomCard(countryName: 'Europe', flagAsset: 'assets/images/ic_europe.png'),
        CustomCard(countryName: 'Australia', flagAsset: 'assets/images/ic_australia.png'),
        CustomCard(countryName: 'Latin America', flagAsset: 'assets/images/ic_america.png'),
        CustomCard(countryName: 'Africa', flagAsset: 'assets/images/ic_africa.png'),
        CustomCard(countryName: 'Asia', flagAsset: 'assets/images/ic_asia.png'),

      ],
    );
  }
}
