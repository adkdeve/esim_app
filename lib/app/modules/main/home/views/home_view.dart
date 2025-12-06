import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/circle_item.dart';
import '../../../../../common/widgets/custom_country_card.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';
import '../../card_details/bindings/card_details_binding.dart';
import '../../card_details/views/card_details_view.dart';
import '../../controllers/main_controller.dart';
import '../controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
      ),
      child: DefaultTabController(
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
                    SliverToBoxAdapter(child: 20.sbh),
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
                    onTap: () async {
                      final Uri url = Uri.parse('https://wilixifysoft.com/conat-us/');

                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/icons/ic_help_support.svg',
                    )
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

                  CompositedTransformTarget(
                    link: controller.layerLink, // 1. Links the floating list to this widget
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: R.theme.secondary, // Dark background
                        borderRadius: BorderRadius.circular(15), // ✅ Rounded corners (15px)
                        // ✅ No 'border:' property here ensures no border color
                        boxShadow: [
                          BoxShadow(
                            color: R.theme.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        onChanged: controller.onSearchQueryChanged,
                        style: TextStyle(color: R.theme.white, fontSize: 14),
                        cursorColor: R.theme.primary,
                        decoration: InputDecoration(
                          hintText: 'Search your destination',
                          hintStyle: const TextStyle(color: Color(0xff7a7a7a), fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Color(0xff7a7a7a)),

                          // ✅ This removes the internal underline/border of the TextField
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(vertical: 12),

                          // Shows 'X' button only when user types or has results
                          suffixIcon: Obx(() =>
                          controller.searchResults.isNotEmpty || controller.searchController.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                            onPressed: () {
                              controller.searchController.clear();
                              controller.onSearchQueryChanged('');
                              controller.searchFocusNode.unfocus();
                            },
                          )
                              : const SizedBox.shrink()
                          ),
                        ),
                      ),
                    ),
                  )
                  // GestureDetector(
                  //   onTap: () {
                  //     showSearch(
                  //       context: context,
                  //       delegate: DestinationSearchDelegate(),
                  //     );
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  //     decoration: BoxDecoration(
                  //       color: R.theme.secondary,
                  //       borderRadius: 15.radius,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: R.theme.black.withOpacity(0.1),
                  //           blurRadius: 10,
                  //           offset: const Offset(0, 5),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //
                  //         Icon(Icons.search,color: Color(0xff7a7a7a)),
                  //
                  //         8.sbw,
                  //
                  //         MyText(
                  //             text: 'Search your destination',
                  //             fontSize: 14,
                  //             color: Color(0xff7a7a7a)
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
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
            text: 'Popular Destinations', // Updated title
            color: R.theme.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          10.sbh,
          SizedBox(
            height: 70,
            child: Obx(() {

              var popularList = controller.countryCategories.take(6).toList();

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popularList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (_, i) {
                  final category = popularList[i];

                  return GestureDetector(
                      onTap: () {
                        Get.to(
                              () => const CardDetailsView(),
                          binding: CardDetailsBinding(),
                          arguments: {
                            'countryName': category.name,
                            'imageUrl': category.image,
                            'products': category,
                          },
                        );
                      },
                      child: CircleItem(
                          name: category.name, imageUrl: category.image, imageSize: 45, textSize: 12
                      )
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CountriesTabWidget extends GetView<HomeController> {
  const CountriesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.countryCategories.length,
        itemBuilder: (context, index) {
          final country = controller.countryCategories[index];
          return CustomCard(
            countryName: country.name,
            imageUrl: country.image,
            imageSize: 35,
            textSize: 14,
            onTap: () {
              controller.navigateToDetails(country);
            }
          );
        },
      );
    });
  }
}

class RegionalPlanTabWidget extends GetView<HomeController> {
  const RegionalPlanTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.regionalCategories.length,
        itemBuilder: (context, index) {
          final region = controller.regionalCategories[index];
          return CustomCard(
            countryName: region.name,
            imageUrl: region.image,
            imageSize: 35,
            textSize: 14,
            onTap: () {
              controller.navigateToDetails(region);
            },
          );
        },
      );
    });
  }
}
