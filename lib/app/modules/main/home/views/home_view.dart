import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';
import '../controllers/home_controller.dart';
import 'card_details_screen.dart';
import 'data_esims.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(context),

                _buildPopulareSimsSection(),

                _buildFeaturesSection(),

                _buildeSimDataSection(),

                _buildPromoBannerSection()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardDetailScreen()),
          );
        },
        child: Icon(Icons.navigate_next),
      ),

    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/header_image.png"), fit: BoxFit.cover),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [

                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: R.theme.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: R.theme.primary,
                    ),
                  ),

                  8.sbw,

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      MyText(
                        text: 'Hey Safi',
                        fontSize: 14,
                        color: R.theme.white,
                        fontWeight: FontWeight.w500
                      ),

                      5.sbh,

                      MyText(
                        text: 'Welcome',
                        color: R.theme.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900
                      ),
                    ],
                  ),
                ],
              ),

              14.sbw,

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: SvgPicture.asset('assets/icons/ic_notification.svg')
                  ),

                  10.sbw,

                  GestureDetector(
                      onTap: () {
                      },
                      child: Icon(Icons.settings_outlined,color: R.theme.white)
                  ),
                ],
              ),
            ],
          ),

          30.sbh,

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
                color: R.theme.surface,
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

                  Icon(Icons.search),

                  8.sbw,

                  MyText(
                    text: 'Search your destination',
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          12.sbh,
        ],
      ),
    );
  }

  Widget _buildPopulareSimsSection() {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MyText(
            text: "Popular eSim",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),

          16.sbh,

          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.countries.length,
              itemBuilder: (context, index) {
                final country = controller.countries[index];
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: 10.right,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ClipRRect(
                          borderRadius: 50.radius,
                          child: SizedBox(
                            width: 50,
                            height: 50,

                            child: Image.network(
                              country['imageUrl']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image);
                              },
                            ),
                          ),
                        ),

                        8.sbh,

                        MyText(
                          text: country['country']!,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final feature = controller.features[index];
          return GestureDetector(
            onTap: () {
              _navigateToScreen(context, feature['label']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: R.theme.primary,
                borderRadius: 16.radius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircleAvatar(
                    backgroundColor: R.theme.black,
                    radius: 20,
                    child: buildImage(feature['icon']),
                  ),

                  8.sbh,

                  MyText(
                    text: feature['label'] as String,
                    fontSize: 12,
                    color: R.theme.white,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String label) {
    switch (label) {
      case 'Data':

        break;
      case 'Conversation':

        break;
      case 'Full ESIMs':

        break;
      case 'Phone Number':

        break;
      case 'Data ESIMs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataEsims()),
        );
        break;
      case 'Calling Plans':

        break;
      default:
        print('Unknown feature: $label');
        break;
    }
  }

  Widget _buildeSimDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            flex: 2,
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MyText(
                    text: 'Turkey eSim Data',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,

                  ),

                  10.sbh,

                  Container(
                    padding: 12.all,
                    decoration: BoxDecoration(
                      color: R.theme.white,
                      borderRadius: 16.radius,
                      boxShadow: [
                        BoxShadow(
                          color: R.theme.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        _buildDataRow(
                          color: R.theme.primary,
                          label: 'Data',
                          value: '14.71 GB',
                          expiry: 'EX 2023/10',
                          progress: 20 / 100,
                        ),

                        16.sbh,

                        _buildDataRow(
                          color: R.theme.black,
                          label: 'Conversation',
                          value: '160 Min',
                          expiry: 'EX 2023/08',
                          progress: 80 / 100,
                        ),

                        16.sbh,

                        _buildDataRow(
                          color: R.theme.primary,
                          label: 'Text',
                          value: '30 Text',
                          expiry: 'EX 2023/08',
                          progress: 65 / 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          12.sbh,

          Expanded(
            flex: 1,
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MyText(
                    text: 'All eSIM data',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  10.sbh,

                  _buildSummaryBox('12.48 GB', 'Total data All'),

                  8.sbh,

                  _buildSummaryBox('430 Min', 'Total All of conversation'),

                  8.sbh,

                  _buildSummaryBox('58 Number', 'Total of all Text'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow({
    required Color color,
    required String label,
    required String value,
    required String expiry,
    required double progress,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: 4.radius,
          ),
        ),

        12.sbw,

        Expanded(
          flex: 1,
          child: MyText(
            text: label,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),

        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),

        12.sbw,

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            MyText(
              text: value,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),

            MyText(
              text: expiry,
              fontSize: 10,
              color: R.theme.grey,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryBox(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: R.theme.white,
        borderRadius: 12.radius,
        border: Border.all(color: Colors.brown.shade200),
      ),
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: MyText(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: MyText(
              text: subtitle,
              fontSize: 10,
              color: Colors.black54,
              overflow: TextOverflow.ellipsis,
              maxLines: 1
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBannerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: 20.radius,
        child: Image.asset(
          'assets/images/promo_banner.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: 100,
        ),
      ),
    );
  }

}
